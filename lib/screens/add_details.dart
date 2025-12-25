import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Add New Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Enter Title (e.g. GitHub)",
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: "Enter Username"),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    valueController.text.isNotEmpty) {
                  Map<String, dynamic> userInput = {
                    "title": titleController.text.trim(),
                    "value": valueController.text.trim(),
                    "icon": Icons.add_task,
                  };
                  Navigator.pop(context, userInput);
                } else {
                  debugPrint("Please fill all fields");
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
