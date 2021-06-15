import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickdaily/widgets/appbar.dart';
import 'package:pickdaily/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pickdaily/views/tasks/add_task.dart';
import 'package:pickdaily/views/tasks/view_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('tasks');

  List<Color> myColors = [
    Colors.grey.shade700,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          )
              .then((value) {
            print('Calling SetState!');
            setState(() {});
          });
        },
        backgroundColor: Color(0xFF010101),
        child: Icon(
          Icons.add,
          size: 38,
          color: Colors.white70,
        ),
      ),
      //
      //
      appBar: buildAppBar(
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leadingIcon(),
              titleText(),
              signOutButton(),
            ],
          ),
        ),
      ),

      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'You have no daily task!',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var random = Random();
                var bg = myColors[random.nextInt(1)];
                var data = snapshot.data!.docs[index].data() as Map?;
                DateTime mydateTime = data!['created'].toDate();
                var formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewTask(
                          data,
                          formattedTime,
                          snapshot.data!.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Nunito Sans',
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then(
        (value) {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(
        Icons.logout,
        size: 38,
        color: Colors.white70,
      ),
      onPressed: _signOut,
    );
  }

  Widget leadingIcon() {
    return Icon(
      Icons.description_outlined,
      color: Colors.white70,
    );
  }

  Widget titleText() {
    return Text(
      'Tasks',
      style: TextStyle(
        fontSize: 32,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    );
  }
}
