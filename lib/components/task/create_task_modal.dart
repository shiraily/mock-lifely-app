import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateTaskModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('タスクの作成'),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'タイトル',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: '説明',
          ),
        ),
      ],
    );
  }
}
