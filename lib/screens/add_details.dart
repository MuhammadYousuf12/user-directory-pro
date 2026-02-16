import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_ui_practice/models/user_model.dart';

class AddDetails extends StatefulWidget {
  final UserModel? userToEdit;
  final int? index;

  const AddDetails({super.key, this.userToEdit, this.index});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
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

  File? _selectedImage;
  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.userToEdit != null) {
      nameController.text = widget.userToEdit!.name;
      professionController.text = widget.userToEdit!.profession;
      emailController.text = widget.userToEdit!.email;
      phoneController.text = widget.userToEdit!.phone;
      skillsController.text = widget.userToEdit!.skills;
      _imagePath = widget.userToEdit!.imagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Add New Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : (_imagePath != null
                          ? FileImage(File(_imagePath!))
                          : null),
                child: (_selectedImage == null && _imagePath == null)
                    ? const Icon(Icons.add_a_photo)
                    : null,
              ),
            ),
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
                if (nameController.text.trim().isNotEmpty &&
                    professionController.text.trim().isNotEmpty) {
                  // Passing data back to Login Page
                  // Note: 'icon' is sending as a String here
                  Map<String, dynamic> userInput = {
                    "name": nameController.text.trim(),
                    "profession": professionController.text.trim(),
                    "email": emailController.text.trim(),
                    "phone": phoneController.text.trim(),
                    "skills": skillsController.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .join(','),
                    "icon": "person",
                    "imagePath": _imagePath,
                  };

                  Navigator.pop(context, userInput);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields!")),
                  );
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
