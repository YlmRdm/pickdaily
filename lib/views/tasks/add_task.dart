import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickdaily/widgets/appbar.dart';
import 'package:pickdaily/widgets/buttons/return_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  // const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String title;
  late String des;

  late DatePickerDialog pickerDate;
  late DateTime datetime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                returnButton(context),
                saveButton(),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Task Title',
                        ),
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Task Description',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                          onChanged: (_val) {
                            des = _val;
                          },
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty!";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 12,
                        ),
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

  ElevatedButton saveButton() {
    return ElevatedButton(
      onPressed: add,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 8,
          ),
        ),
      ),
      child: Text(
        'Save',
        style: TextStyle(
          fontSize: 38,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
  }

  void add() async {
    //Saving to DB
    final CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tasks');

    final data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    await ref.add(data);

    Navigator.pop(context);
  }
}
