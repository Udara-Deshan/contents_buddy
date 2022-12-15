import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app/model/contactsDTO.dart';


class database_helper{
  database_helper._privateConstructor();
  static final database_helper instance =database_helper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path =join(documentDirectory.path,'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db,int version) async {
    await db.execute('''
    CREATE TABLE contacts(
      id INTEGER PRIMARY KEY,
      name TEXT,
      number TEXT,
      email TEXT,
      imgPath TEXT
    )
    ''');
  }

  Future<List<Contact>> getUsers() async{
    Database db =await instance.database;
    var contacts = await db.query('contacts', orderBy: 'name');
    List<Contact> contactList = contacts.isNotEmpty
        ? contacts.map((c) => Contact.fromMap(c)).toList()
        : [];
    return contactList;
  }

  Future<int> add(Contact contact) async {
    Database db = await instance.database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('contacts',where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    Database db = await instance.database;
    return await db.update('contacts', contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> searchContacts(String keyword) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db
        .query('contacts', where: 'name LIKE ?', whereArgs: ['%$keyword%']);
    List<Contact> contacts =
    allRows.map((contact) => Contact.fromMap(contact)).toList();
    return contacts;
  }

}