import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

import '../model/contactsDTO.dart';
import '../utils/database_helper.dart';
class SaveContact extends StatefulWidget {
  const SaveContact({Key? key}) : super(key: key);

  @override
  State<SaveContact> createState() => _SaveContactState();
}

class _SaveContactState extends State<SaveContact> {
  final name = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late String imagetemPath;

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Save Contact'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      // Image radius
                      width: 100,
                      height: 100,
                      child: _image != null
                          ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: Colors.grey,
                      ),
                    ),

                    TextButton(
                        onPressed: () {
                          _onImage();
                        },
                        child: const Text("Upload Photo"))
                  ],
                ),
                TextFormField(
                  controller: name,
                  cursorColor: Colors.teal,
                  decoration: const InputDecoration(
                    labelText: 'Contact Name',
                  ),
                ),
                TextFormField(
                  controller: number,
                  cursorColor: Colors.teal,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Contact Number';
                    }
                    return null;
                  },

                ),
                TextFormField(
                  controller: email,
                  cursorColor: Colors.teal,
                  decoration: const InputDecoration(
                    labelText: 'Contact Email',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () async {

                    await database_helper.instance.add(Contact(
                      name: name.text,
                      number: number.text,
                      email: email.text,
                      imgPath: imagetemPath,
                    ));
                    setState(() {
                      name.clear();
                      number.clear();
                      email.clear();
                      Navigator.pop(context, true);
                    });

                  },
                  child: Text('Save'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                    elevation: 5,
                  ),
                )
              ],
            )));
  }

  Future _onImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image=File(image!.path);
      this.imagetemPath = image!.path;
    });
    print(imagetemPath);
  }
}
