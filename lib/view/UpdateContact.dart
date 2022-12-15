import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/contactsDTO.dart';
import '../utils/database_helper.dart';

class UpdateContact extends StatelessWidget {
  const UpdateContact(this.id,this.name,this.number,this.email,this.imagePath,{Key? key}) : super(key: key);
  final int ?id;
  final String name;
  final String number;
  final String ?email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {

    final name1 = TextEditingController(text:name);
    final number1 = TextEditingController(text: number);
    final email1 = TextEditingController(text: email);

    return Scaffold(
        appBar: AppBar(
          title: Text('Update Screen'),

        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                      child:Image.file(File(imagePath),fit: BoxFit.cover,width: 90,height: 90,)
                  ),
                ),
                TextFormField(
                  controller: name1,
                  cursorColor: Colors.teal,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Contact Name',
                  ),
                ),
                TextFormField(
                  //initialValue: widget.number,
                  controller: number1,
                  cursorColor: Colors.teal,

                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact Number',


                  ),
                ),
                TextFormField(
                  controller: email1,
                  cursorColor: Colors.teal,

                  decoration:  const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Contact Email',


                  ),
                ),
                SizedBox(height: 25),
                TextButton(
                  onPressed: () async {
                    await database_helper.instance.update(
                        Contact(
                            id: id,
                            name: name1.text,
                            number: number1.text,
                            email: email1.text,
                            imgPath:imagePath
                        )
                    );

                    name1.clear();
                    number1.clear();
                    email1.clear();
                    Navigator.pop(context, true);

                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                    elevation: 5,
                  ),
                  child:  const Text('Update'),
                )
              ],
            )
        )
    );
  }
}
