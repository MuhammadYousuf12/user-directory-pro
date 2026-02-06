import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  // Defined here because they belong to this screen
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final skillsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    professionController.dispose();
    emailController.dispose();
    phoneController.dispose();
    skillsController.dispose();
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Enter Name"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: professionController,
              decoration: const InputDecoration(labelText: "Enter Profession"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Enter Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Enter Phone Number",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: skillsController,
              decoration: const InputDecoration(labelText: "Enter Skills"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    professionController.text.isNotEmpty) {
                  // Passing data back to Login Page
                  // Note: We are sending 'icon' as a String here
                  Map<String, dynamic> userInput = {
                    "name": nameController.text.trim(),
                    "profession": professionController.text.trim(),
                    "email": emailController.text.trim(),
                    "phone": phoneController.text.trim(),
                    "skills": skillsController.text.trim(),
                    "icon": "person", // Default icon string
                  };

                  Navigator.pop(context, userInput);
                } else {
                  debugPrint("Please fill all fields");
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
