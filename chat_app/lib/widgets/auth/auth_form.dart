import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn, this.isLoading);  // argument we are receiving here is bound to this property of this class and this property here will point at the function we're getting from auth screen
  
  final bool isLoading;

  final void Function(
    String email, 
    String username, 
    String password, 
    File image,
    bool isLogin, 
    BuildContext ctx
    ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

final _formKey = GlobalKey<FormState>();   //to manage form submission

var _isLogin=true;
String _userEmail='';
String _userName='';
String _userPassword='';
File _userImageFile;

void _pickedImage( File image) {
  _userImageFile= image;
}

void _trySubmit()
{
  final isValid = _formKey.currentState.validate();  // will trigger all the validators of all the text form fields in the form
  FocusScope.of(context).unfocus();                 //keyboard unfocus while saving
  
  if(_userImageFile==null && !_isLogin)
  {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
    return;
  }
 
  if(isValid)
  {
    _formKey.currentState.save();                 // will trigger onSaved function in every text form field
    widget.submitFn(
      _userEmail.trim(), 
      _userName.trim(), 
      _userPassword.trim(), 
     _userImageFile,
      _isLogin, 
      context);  //passing data to submiFn

    // print(_userPassword);
    // print(_userName);
    // print(_userEmail);
   
  }
}

  @override
  Widget build(BuildContext context) {
    return 
Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,    //will take only as much height as needed
                  children: [

                    if(!_isLogin)
                     UserImagePicker(_pickedImage),

                    TextFormField(
                      key: ValueKey('email'),    //keys to differentiate between textfields and their value so as to aid while switching between login and signup mode
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value){
                        if(value.isEmpty || !value.contains('@'))
                        {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        ),
                      onSaved: (value){
                        _userEmail=value;
                      },  
                    ),
                    
                    if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value){
                        if(value.isEmpty || value.length < 4)
                        {
                          return 'Password must be atleast 4 characters long!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        ),
                      onSaved: (value){
                        _userName=value;
                      },    
                    ),

                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value){
                        if(value.isEmpty || value.length < 7)
                        {
                          return 'Password must be atleast 7 characters long!';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        ),
                      onSaved: (value){
                        _userPassword=value;
                      },    
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    if(widget.isLoading)
                       CircularProgressIndicator(),
                    if(!widget.isLoading)  
                        RaisedButton(
                          child: Text(_isLogin? 'Login' : 'Signup'),
                          onPressed: _trySubmit,
                          ),
                      if(!widget.isLoading) 
                          FlatButton(
                            child: Text(
                              _isLogin ? 
                              'Create new account!'
                              :'I already have an account!'
                              ),
                            onPressed: (){
                              setState(() {
                                _isLogin=!_isLogin;    //as ui will be changed                                                   
                              });
                            },
                            textColor: Theme.of(context).primaryColor,
                            ),
                  ],
                ),
              ),
              ),
            ),
          ),
          );
  }
}