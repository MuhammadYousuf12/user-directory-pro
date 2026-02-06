import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:profile_ui_practice/models/user_model.dart';
import 'package:profile_ui_practice/screens/add_details.dart';
import 'package:profile_ui_practice/info_card.dart'; // Ensure path is correct
import 'package:profile_ui_practice/services/storage_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ImagePicker picker = ImagePicker();
  File? _image;
  List<UserModel> users = []; // Our main list

  @override
  void initState() {
    super.initState();
    _initializeUserList();
  }

  // Loads data from Shared Preferences
  Future<void> _initializeUserList() async {
    final savedData = await StorageServices.loadUsers();
    setState(() {
      users = savedData;
    });
  }

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

  // Helper function to convert String from storage to IconData for UI
  IconData _getIconData(String iconName) {
    if (iconName == 'work') return Icons.work;
    return Icons.person; // Default
  }

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
          const SizedBox(height: 20),
          // Image Picker Logic
          GestureDetector(
            onTap: pickImage,
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
          const SizedBox(height: 20),

          // User List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: users.isEmpty
                  ? const Center(child: Text("No users added yet"))
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        // Using your custom InfoCard here
                        return InfoCard(
                          user: user,
                          icon: _getIconData(
                            user.icon,
                          ), // Converting String to IconData
                          onDelete: () async {
                            setState(() {
                              users.removeAt(index);
                            });
                            // Updating storage after deletion
                            await StorageServices.saveUsers(users);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),

      // Floating Action Button to Add New User
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Navigate to AddDetails screen and wait for result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDetails()),
          );

          // If we got data back (User clicked Save)
          if (result != null && result is Map<String, dynamic>) {
            final newUser = UserModel(
              name: result['name'],
              profession: result['profession'],
              email: result['email'],
              skills: result['skills'],
              phone: result['phone'],
              icon: result['icon'],
            );

            setState(() {
              users.add(newUser);
            });

            // Save to local storage
            await StorageServices.saveUsers(users);
          }
        },
      ),
    );
  }
}
