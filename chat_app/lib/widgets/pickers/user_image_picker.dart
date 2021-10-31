import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {

  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);


  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile= await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,      //for smaller image
      );
    setState(() {
          _pickedImage = pickedImageFile;
        });

        widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                    CircleAvatar(  //image preview
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage: _pickedImage !=null ? FileImage(_pickedImage) : null,
                    ),
                    
                    FlatButton.icon(
                      onPressed: _pickImage,           //open image picker
                      icon: Icon(Icons.image), 
                      label: Text('Add image'),
                      textColor: Theme.of(context).primaryColor,
                      ),

      ]
      
    );
  }
}