import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ntx2/cubit/appCubit.dart';
import 'package:ntx2/modules/note_page.dart';

Future<dynamic> moveTo(
    @required context ,
    @required Widget screen

    )=>Navigator.push(context, MaterialPageRoute(builder: (context) {
  return screen;
},));



Widget noteItemBuilder(
{
  required Map noteModel,
  required context
}
    )=>  Dismissible(
      key: Key(noteModel['id'].toString()),
      direction: DismissDirection.horizontal,
       onDismissed: (value){
        appCubit appCubitObj3=appCubit.get(context);
        appCubitObj3.deleteNoteFromDatabase(noteModel['id']);

      },
      child: MaterialButton(onPressed: (){
        moveTo(context, notePage(noteModel['id'],noteModel['title'], noteModel['date'],noteModel['body'],noteModel['color']));
      },
        child: Padding(


  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child:   Container(

        height: 200,

        decoration: BoxDecoration(

        color: noteModel['color']==0?Colors.pink
            :noteModel['color']==1?Colors.teal
            :noteModel['color']==2?Color(0xff702963)
            :Color(0xff8d021f),

            boxShadow: [BoxShadow(

                color: Colors.amberAccent,

                offset: Offset(1, 1),

                blurRadius: 7,

                spreadRadius: 7

            )],
            borderRadius: BorderRadius.all(Radius.circular(20))



        ),

        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Column(

          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${noteModel['title']}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            SizedBox(height: 5,),
            Container(height: 1,color: Colors.black,width: double.infinity,),
            SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${noteModel['date']}",style: TextStyle(color: Colors.amber,fontSize: 16,fontWeight: FontWeight.w400),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            SizedBox(height: 5,),

            Container(height: 1,color: Colors.black,width: double.infinity,),
            SizedBox(height: 5,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${noteModel['body']}",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),maxLines: 3,overflow: TextOverflow.ellipsis,),
            ),

          ],

        ),

  ),
),
      ),
    );