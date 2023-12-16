import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntx2/components.dart';
import 'package:ntx2/cubit/appCubit.dart';
import 'package:ntx2/cubit/appStates.dart';
import 'package:ntx2/database_helper/database_helper.dart';
import 'package:ntx2/modules/search_note_page.dart';
import 'package:ntx2/modules/note_page.dart';


class noteScreen extends StatelessWidget {
  var searchNoteController= TextEditingController();
  var scaffoldKey=GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appCubit,appStates>(

      builder: (BuildContext context, appStates state) {
        appCubit appCubitObt2 = appCubit.get(context);
        // no need to get here as long a you get while opening databse
        // appCubitObt2.getNoteFromDatabase(appCubitObt2.databaseObj);
        return  Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("My Notes",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[Colors.deepOrange,Colors.amberAccent]))),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){

            moveTo(context, notePage(null,"","","",null));

          }, child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[Colors.deepOrange,Colors.amberAccent]),
                  shape: BoxShape.circle
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Icon(Icons.add,color: Colors.black,)),backgroundColor: Colors.black,),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [

              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,

                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  onTap: (){
                    moveTo(context, searchNote());
                    // appCubitObt2.searchNoteIntoDatabase(searchNoteController.text);

                  },
                  keyboardType: TextInputType.text,
                  controller: searchNoteController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ConditionalBuilder(
                condition: appCubitObt2.notes.length>0,
                builder: (BuildContext context) { return  Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return noteItemBuilder(context: context,noteModel: appCubitObt2.notes[index]
                        );
                      },
                      separatorBuilder:(context, index) =>  SizedBox(height: 30,),
                      itemCount: appCubitObt2.notes.length),
                ); },
                fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

              )




            ]),
          ),

        );
      },
      listener: (BuildContext context, appStates state) {  },

    );

  }
}