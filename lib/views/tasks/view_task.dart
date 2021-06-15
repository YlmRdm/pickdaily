import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickdaily/widgets/appbar.dart';
import 'package:pickdaily/widgets/buttons/return_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTask extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  const ViewTask(this.data, this.time, this.ref);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  late String title;
  late String des;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                returnButton(context),
                Row(
                  children: [
                    editButton(),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                deleteButton(),
              ],
            ),
          ),
        ),
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.white70,
                  size: 38,
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Title',
                        ),
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                        initialValue: widget.data['title'],
                        enabled: edit,
                        onChanged: (_val) {
                          title = _val;
                        },
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                        ),
                        child: Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Task Description',
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          color: Colors.white70,
                        ),
                        initialValue: widget.data['description'],
                        enabled: edit,
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty!";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton deleteButton() {
    return ElevatedButton(
      onPressed: delete,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
      ),
      child: Icon(
        Icons.delete_forever,
        color: Colors.red.shade300,
        size: 38,
      ),
    );
  }

  ElevatedButton editButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          edit = !edit;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
      ),
      child: Icon(
        Icons.edit,
        size: 38,
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState!.validate()) {
      // TODo : showing any kind of alert that new changes have been saved
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}
