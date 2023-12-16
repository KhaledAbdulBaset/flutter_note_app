import 'package:sqflite/sqflite.dart';

class databaseHelper{

  static Database? databaseObj;


  static void createDatabase()async{

    databaseObj=await openDatabase(
      "Notex1.db",
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE notes( id INTEGER PRIMARY KEY, title TEXT NOT NULL, date TEXT NOT NULL, body TEXT NOT NULL, color INTEGER NOT NULL);").then(
                (value) {print("note table is created");}).catchError((error){print("Error creating notes table: $error");});


      },
      onOpen: (db) {
        print("DB is opened");
        getNoteFromDatabase();
      },);



  }

  static void insertNoteIntoDatabase({required String title, required String date, required String body,required int color})async{
    await databaseObj?.transaction((txn) async{
      txn.rawInsert('INSERT INTO notes (title, date, body, color) VALUES("$title", "$date", "$body", "$color")')
      .then((value) {
        print("$value Successful Inserting note");
        getNoteFromDatabase();
      }).catchError((error){print("Error while Inserting note:$error");});

    });


  }


  static List<Map> notes=[];
  static void getNoteFromDatabase()async{
    await databaseObj?.rawQuery("SELECT * FROM notes").then((value) {

      notes=value;
      print("GET ALL NOTES : $value");
    }).catchError((error){print("Error while get notes : $error");});


  }

}