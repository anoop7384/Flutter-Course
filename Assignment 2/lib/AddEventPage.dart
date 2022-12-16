import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final controller = TextEditingController();
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFb3b3ff),
        appBar: AppBar(
            title: const Text("New Event"),
            ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  minLines: 1,
                  maxLines: 5,
                  onChanged: (value) => result = value,
                  decoration: const InputDecoration(
                    labelText: "Event",
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
                tileColor: Colors.deepPurple,
                textColor: Colors.white,
                leading: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, result),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white38,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(350.0, 50.0),
                ),
                child: const Text("Add"),
              )
            ],
          ),
        )));
  }
}
