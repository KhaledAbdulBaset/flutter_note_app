import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntx2/cubit/appStates.dart';
import 'package:sqflite/sqflite.dart';

class appCubit extends Cubit<appStates>{

  appCubit(): super(appInitState());

static  appCubit get(context)=> BlocProvider.of(context);

  int colorIndex=0;
  List<Color> colorList=[Colors.pink,Colors.teal,Color(0xff702963),Color(0xff8d021f)];
  String? selectedColor;

  void changeNoteColor(index){
    colorIndex=index;
    emit(appchangeNoteColorState());
  }

  Database? databaseObj;


   void createDatabase()async{

    databaseObj=await openDatabase(
      "Notex1.db",
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE notes( id INTEGER PRIMARY KEY, title TEXT NOT NULL, date TEXT NOT NULL, body TEXT NOT NULL, color INTEGER NOT NULL);").then(
                (value) {print("note table is created");}).catchError((error){print("Error creating notes table: $error");});
      },
      onOpen: (databaseObj) {
        print("DB is opened");
        getNoteFromDatabase(databaseObj);
                   },

    );
  emit(appCreateDatabaseState());




  }

   void insertNoteIntoDatabase(

       {required String title, required String date,
         required String body,required int color})async{
    await databaseObj?.transaction((txn) async{
      txn.rawInsert('INSERT INTO notes (title, date, body, color) VALUES("$title", "$date", "$body", "$color")')
          .then((value) {
        print("$value Successful Inserting note");
        getNoteFromDatabase(databaseObj);
        emit(appInsertNoteIntoDatabase());
      }).catchError((error){print("Error while Inserting note:$error");});

    });


  }


   List<Map> notes=[];
   void getNoteFromDatabase(databaseObj)async{
    await databaseObj?.rawQuery("SELECT * FROM notes").then((value) {

      notes=value;
      print("GET ALL NOTES : $value");
      emit(appGetNoteFromDatabase());
    }).catchError((error){print("Error while get notes : $error");});


  }

  void deleteNoteFromDatabase(int id){
     databaseObj?.rawDelete("DELETE FROM notes WHERE id=? ",[id]).then((value) {
       print("Successfull deleting");
       emit(appDeleteNoteFromDatabase());
       getNoteFromDatabase(databaseObj);
     }).catchError((error){print("Error While delteing : $error");});
  }
  
  void updateNoteInDatabase({required String title, required String date,
        required String body,required int? color,required int? id})async {
     await databaseObj?.rawUpdate("UPDATE notes SET title=?, date=?, body=?, color=? WHERE id=?",["$title","$date","$body",color,id]).then((value) {
       print("sucecessful update:$value");
       emit(appUpdateNoteFromDatabase());
       getNoteFromDatabase(databaseObj);

     });
  }

  List<Map>? searchNoteList=[];
  void searchNoteIntoDatabase(
      @required String title
      ){
     databaseObj?.rawQuery("SELECT * FROM notes WHERE title=? ",[title]).then((value) {
       searchNoteList=value;
       print("Successful searching: $value");
       emit(appSearchNoteFromDatabase());
     }).catchError((error){
       print("Error while searching: $error");
     });
  }
}