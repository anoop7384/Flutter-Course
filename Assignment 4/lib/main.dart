import 'package:chatrooms/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  dynamic username = "";
  final userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create a username")),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.grey),
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: userController,
                onChanged: (value) => username = value,
                decoration: const InputDecoration(
                  hintText: "Enter your username",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () => {
                userController.text="",
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatRoom(user: username)),
                )
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350.0, 50.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      )),
    );
  }
}

class Message {
  late String body;
  late String user;
  late DateTime date;

  Message({required this.body, required this.user, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'message': body,
      'time': date,
    };
  }
}

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addChat(Map<String, dynamic> chat, String room) async {
    DocumentReference documentReferencer =
        _db.collection("chatrooms").doc(room).collection("chats").doc();

    await documentReferencer
        .set(chat)
        .whenComplete(() => print("Chat added to the $room"))
        .catchError((e) => print(e));
  }
}

class ChatRoom extends StatefulWidget {
  final String user;
  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  PageController page = PageController();
  TextEditingController messageController = TextEditingController();
  dynamic appBarTitle = "College";
  dynamic messgae = "";
  dynamic time = "";

  changeTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: const Icon(Icons.menu),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'mohada',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'College',
                onTap: () {
                  changeTitle("College");
                  // appBarTitle="Dashboard";
                  page.jumpToPage(0);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                priority: 1,
                title: 'Sports',
                onTap: () {
                  changeTitle("Sports");
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.sports_volleyball),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Coding',
                onTap: () {
                  changeTitle("Coding");
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.computer),
                trailing: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Food',
                onTap: () {
                  changeTitle("Food");
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.emoji_food_beverage),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Travel',
                onTap: () {
                  changeTitle("Travel");
                  page.jumpToPage(4);
                },
                icon: const Icon(Icons.car_rental),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Exit',
                onTap: goback(),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chatrooms")
                              .doc("College")
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                if (data['user'] == widget.user) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        color: Colors.blueGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: TextField(
                                  controller: messageController,
                                  onChanged: (value) => messgae = value,
                                  decoration: const InputDecoration(
                                    hintText: "Enter message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {
                                        // time = DateFormat("hh:mm a")
                                        //     .format(DateTime.now()),
                                        Database.addChat(
                                            Message(
                                                    body: messgae,
                                                    user: widget.user,
                                                    date: DateTime.now())
                                                .toMap(),
                                            "College"),
                                        messageController.text = ""
                                      },
                                  child: const Icon(Icons.send))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chatrooms")
                              .doc("Sports")
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                if (data['user'] == widget.user) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        color: Colors.blueGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: TextField(
                                  controller: messageController,
                                  onChanged: (value) => messgae = value,
                                  decoration: const InputDecoration(
                                    hintText: "Enter message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {
                                        // time = DateFormat("hh:mm a")
                                        //     .format(DateTime.now()),
                                        Database.addChat(
                                            Message(
                                                    body: messgae,
                                                    user: widget.user,
                                                    date: DateTime.now())
                                                .toMap(),
                                            "Sports"),
                                    messageController.text = ""
                                      },
                                  child: const Icon(Icons.send))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chatrooms")
                              .doc("Coding")
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                if (data['user'] == widget.user) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        color: Colors.blueGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: TextField(
                                  controller: messageController,
                                  onChanged: (value) => messgae = value,
                                  decoration: const InputDecoration(
                                    hintText: "Enter message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {
                                        // time = DateFormat("hh:mm a")
                                        //     .format(DateTime.now()),
                                        Database.addChat(
                                            Message(
                                                    body: messgae,
                                                    user: widget.user,
                                                    date: DateTime.now())
                                                .toMap(),
                                            "Coding"),
                                    messageController.text = ""
                                      },
                                  child: const Icon(Icons.send))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chatrooms")
                              .doc("Food")
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                if (data['user'] == widget.user) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        color: Colors.blueGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: TextField(
                                  controller: messageController,
                                  onChanged: (value) => messgae = value,
                                  decoration: const InputDecoration(
                                    hintText: "Enter message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {
                                        // time = DateFormat("hh:mm a")
                                        //     .format(DateTime.now()),
                                        Database.addChat(
                                            Message(
                                                    body: messgae,
                                                    user: widget.user,
                                                    date: DateTime.now())
                                                .toMap(),
                                            "Food"),
                                    messageController.text = ""
                                      },
                                  child: const Icon(Icons.send))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("chatrooms")
                              .doc("Travel")
                              .collection("chats")
                              .orderBy("time", descending: false)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                if (data['user'] == widget.user) {
                                  return Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        color: Colors.blueAccent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card(
                                        color: Colors.blueGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["user"] +
                                                    " " +
                                                    DateFormat("hh:mm a")
                                                        .format(DateTime.parse(
                                                            data["time"]
                                                                .toDate()
                                                                .toString())),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                data["message"],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: TextField(
                                  controller: messageController,
                                  onChanged: (value) => messgae = value,
                                  decoration: const InputDecoration(
                                    hintText: "Enter message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {
                                        // time = DateFormat("hh:mm a")
                                        //     .format(DateTime.now()),
                                        Database.addChat(
                                            Message(
                                                    body: messgae,
                                                    user: widget.user,
                                                    date: DateTime.now())
                                                .toMap(),
                                            "Travel"),
                                    messageController.text = ""
                                      },
                                  child: const Icon(Icons.send))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  goback() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const Welcome()),
    // );
  }
}
