import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ntx2/components.dart';
import 'package:ntx2/cubit/appCubit.dart';
import 'package:ntx2/cubit/appStates.dart';
import 'package:ntx2/database_helper/database_helper.dart';
import 'package:ntx2/modules/note_screen.dart';



class notePage extends StatelessWidget{
  var noteTittleController = TextEditingController();
  var noteDateController = TextEditingController();
  var noteBodyController = TextEditingController();

    String? noteTitleComing;
   String? noteDateComing;
   String? noteBodyComing;
   int? noteColorComing;
   int? noteIdComing;

  notePage(this.noteIdComing,this.noteTitleComing, this.noteDateComing, this.noteBodyComing,this.noteColorComing);




  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appCubit,appStates>(
      builder: (BuildContext context, appStates state) {
        appCubit appCubitObj = appCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[Colors.deepOrange,Colors.amberAccent]),)),
            actions: [

              Container(
                  decoration: BoxDecoration( color: Colors.teal,shape: BoxShape.circle),
                  clipBehavior:Clip.antiAliasWithSaveLayer,
                  child: IconButton(onPressed: (){


                      appCubitObj.insertNoteIntoDatabase(
                          title: noteTittleController.text,
                          date: noteDateController.text,
                          body: noteBodyController.text,
                          color: appCubitObj.colorIndex
                      );
                      // moveTo(context, noteScreen());
                    Navigator.pop(context);


                  },icon: Icon(Icons.save_as_outlined,color: Colors.white,))),
              SizedBox(width: 10,),
              Container(

                  decoration: BoxDecoration( color: Colors.blueAccent,shape: BoxShape.circle),
                  clipBehavior:Clip.antiAliasWithSaveLayer,
                  child: IconButton(onPressed: (){


                    appCubitObj.updateNoteInDatabase(
                        title: noteTittleController.text,
                        date: noteDateController.text,
                        body: noteBodyController.text,
                        color: appCubitObj.colorIndex,
                        id: noteIdComing
                    );
                    // moveTo(context, noteScreen());
                    Navigator.pop(context);


                  },icon: Icon(Icons.edit,color: Colors.white,)))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 40,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(height: 40,width: 40,decoration: BoxDecoration(color: appCubitObj.colorIndex==0?Colors.green:Colors.white,
                                shape: BoxShape.circle),)
                            ,Container(height: 30,width: 30,decoration: BoxDecoration(color: Colors.pink,shape: BoxShape.circle),)
                          ],), onPressed: () {
                        appCubitObj.changeNoteColor(0);
                      },
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        iconSize: 40,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(height: 40,width: 40,decoration: BoxDecoration(color: appCubitObj.colorIndex==1?Colors.green:Colors.white,shape: BoxShape.circle),)
                            ,Container(height: 30,width: 30,decoration: BoxDecoration(color: Colors.teal,shape: BoxShape.circle),)

                          ],), onPressed: () {


                        appCubitObj.changeNoteColor(1);

                      },
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        iconSize: 40,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(height: 40,width: 40,decoration: BoxDecoration(color: appCubitObj.colorIndex==2?Colors.green:Colors.white,shape: BoxShape.circle),)
                            ,Container(height: 30,width: 30,decoration: BoxDecoration(color:Color(0xff702963),shape: BoxShape.circle),)

                          ],), onPressed: () {

                        appCubitObj.changeNoteColor(2);

                      },
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        iconSize: 40,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(height: 40,width: 40,decoration: BoxDecoration(color: appCubitObj.colorIndex==3?Colors.green:Colors.white,shape: BoxShape.circle),)
                            ,Container(height: 30,width: 30,decoration: BoxDecoration(color: Color(0xff8d021f),shape: BoxShape.circle),)

                          ],),
                        onPressed: () {

                          appCubitObj.changeNoteColor(3);

                        },
                      )

                    ],),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),

                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: noteTittleController=TextEditingController(text: noteTitleComing),
                    maxLines: 10,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Title",
                      prefixIcon: Icon(Icons.title_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[Colors.deepOrange,Colors.amberAccent])
                          ,borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    onTap: (){
                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100)).then((value) {
                        noteDateController.text=DateFormat.yMMMd().format(value!).toString();
                        print(noteDateController.text);
                      }).catchError((error){print("Erorr Date: $error");});
                    },
                    controller: noteDateController=TextEditingController(text: noteDateComing),
                    decoration: InputDecoration(
                      hintText: "Date",
                      prefixIcon: Icon(Icons.date_range_rounded),
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),

                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: noteBodyController=TextEditingController(text: noteBodyComing),
                    maxLines: 20,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Subject",
                      prefixIcon: Icon(Icons.subject_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10,),



              ]),
            ),
          ),

        );
      }, listener: (BuildContext context, appStates state) {  },


    );
  }
}