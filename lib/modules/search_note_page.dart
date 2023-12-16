import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntx2/cubit/appCubit.dart';
import 'package:ntx2/cubit/appStates.dart';

import '../components.dart';

class searchNote extends StatelessWidget{
  var searchNoteController1= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appCubit,appStates>(
      builder: (BuildContext context, appStates state) {
        appCubit appCubitObj4 = appCubit.get(context);

        return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        centerTitle: true,
        flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[Colors.deepOrange,Colors.amber])),),
        ),
        body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(

                  keyboardType: TextInputType.text,
                  controller: searchNoteController1,
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: IconButton(onPressed: (){
                      appCubitObj4.searchNoteIntoDatabase(searchNoteController1.text);
                    },icon: Icon(Icons.search)),
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ConditionalBuilder(
                condition: appCubitObj4.searchNoteList!.length>0,
                builder: (BuildContext context) { return  Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return noteItemBuilder(context: context,noteModel: appCubitObj4.searchNoteList![index]
                        );
                      },
                      separatorBuilder:(context, index) =>  SizedBox(height: 30,),
                      itemCount: appCubitObj4.searchNoteList!.length),
                ); },
                fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

              )


            ]

            )),
      ); }
      , listener: (BuildContext context, appStates state) {  },



    );
  }

}