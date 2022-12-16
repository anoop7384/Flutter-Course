import 'package:flutter/material.dart';
import 'package:flutter_tut/AddEventPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _list = [];

  void addEvent(String event){
    setState(() {
      _list.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFb3b3ff),
      appBar: AppBar(
        title: const Text("Event Scheduler"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(_list[index],textAlign: TextAlign.center,),
            tileColor: Colors.white,
            textColor: Colors.black,
            contentPadding: const EdgeInsets.all(5.0),

          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEventPage()),
          );
          if(result!=null){
            addEvent(result.toString());
          }

        },
        tooltip: 'Add Event',
        child: const Icon(Icons.add),
      ),
    );
  }
}
