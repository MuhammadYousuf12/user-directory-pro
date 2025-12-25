import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:profile_ui_practice/screens/add_details.dart';
import 'package:profile_ui_practice/info_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Image Picker Instence
  final ImagePicker picker = ImagePicker();

  // Image Picker Function
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  List<Map<String, dynamic>> profileData = [
    {"title": "Full Name", "value": "Muhammad Yousuf", "icon": Icons.person},
    {
      "title": "Email Address",
      "value": "muhammad.yousuf01@gmail.com",
      "icon": Icons.email,
    },
    {"title": "Phone Number", "value": "+92 322 2591216", "icon": Icons.phone},
    {
      "title": "Location",
      "value": "Karachi, Pakistan",
      "icon": Icons.location_on,
    },
    {
      "title": "Designation",
      "value": "Flutter Intern in Training",
      "icon": Icons.work,
    },
    {"title": "Education", "value": "Intermediate", "icon": Icons.school},
  ];
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Profile Viewer"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.person, size: 80, color: Colors.grey.shade600)
                    : null,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: profileData.length,
                itemBuilder: (context, index) {
                  return InfoCard(
                    title: profileData[index]["title"],
                    value: profileData[index]["value"],
                    icon: profileData[index]["icon"],
                    onDelete: () {
                      setState(() {
                        profileData.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDetails()),
          );
          if (data != null) {
            setState(() {
              profileData.add(data);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
