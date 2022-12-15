import 'dart:io';

import 'package:flutter/material.dart';


import 'utils/notification.dart';
import 'model/contactsDTO.dart';
import 'view/SaveContact.dart';
import 'view/UpdateContact.dart';
import 'utils/database_helper.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/save':(context) => const SaveContact(),
    },
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);


  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  // Db_help db_help = Db_help();
  late String keyword;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Contact'),

      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Search'),
                onChanged: (value) {
                  keyword = value;
                  setState(() {

                  });
                },
              ),
            ),
            Flexible(
              child:

              FutureBuilder<List<Contact>>(
                  future: database_helper.instance.getUsers(),
                  builder: (BuildContext context, AsyncSnapshot <List<Contact>> snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ?const Center(child: Text('No Contacts..'))
                        :ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((contacts) {
                        return Center(
                          child: ListTile(
                            leading:SizedBox(
                              child: Image.file(File(contacts.imgPath!), fit: BoxFit.cover,width: 50,height: 50,),

                            ),
                            subtitle: Text(contacts.number),
                            title: Text(contacts.name),
                            onLongPress: (){
                              Delete(contacts.id!);
                            },
                            onTap: (){
                              Update(context,contacts.id,contacts.name,contacts.number,contacts.email,contacts.imgPath);
                            },
                          ),
                        );

                      }).toList(),
                    );
                  }
              ),

            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton (

        onPressed: (){
          saveFunction(context);
        },

        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }

  saveFunction(BuildContext context) async {

    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaveContact()),
    );

    if (reLoadPage) {
      setState(() {});
    }
    onToastSave('Contact Saved !', context);
  }


  Update(BuildContext context,int ?id,String name,String number,String ?email,String ?imagePath) async {
    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateContact(id,name,number,email,imagePath!)),
    );

    if (reLoadPage) {
      setState(() {});
    }
    onToastUpdate('Contact Updated',context);
  }


  Delete(int id) {
    Widget cancelButton = TextButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(color: Colors.red),
      ),
      child: Text('Delete'),
      onPressed: () async {
        await database_helper.instance.delete(id);
        setState(() {});
        onToastDelete('Contact Deleted',context);
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert= AlertDialog(
      title: Text('Delete contact?'),
      content: Text('Are you sure you want to delete this contact?'),
      actions: <Widget>[
        cancelButton,
        deleteButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );

  }


}
