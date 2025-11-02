import 'package:flutter/material.dart';

//codded by zain

Widget customCommentField({required String name, required String comment}){

  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    color: Colors.grey.shade300,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(name[0], style:  TextStyle(color: Colors.white)),
      ),
      title: Text(
        name,
        style:  TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(comment,style: TextStyle(
        fontSize: 14
      ),),
    ),
  );

}