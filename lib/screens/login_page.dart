import 'package:flutter/material.dart';
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
  List<UserModel> users = []; // Main list

  @override
  void initState() {
    super.initState();
    _initializeUserList();
  }

  void handleUserForm({UserModel? data, int? i}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddDetails(userToEdit: data, index: i),
      ),
    );

    if (result == null) return;

    setState(() {
      // Map converts into UserModel
      UserModel updatedUser = UserModel(
        name: result['name'],
        profession: result['profession'],
        email: result['email'],
        skills: result['skills'],
        phone: result['phone'],
        icon: result['icon'],
        imagePath: result['imagePath'],
      );

      (i == null) ? users.add(updatedUser) : users[i] = updatedUser;
    });

    await StorageServices.saveUsers(users);
  }

  // Loads data from Shared Preferences
  Future<void> _initializeUserList() async {
    final savedData = await StorageServices.loadUsers();
    setState(() {
      users = savedData;
    });
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Text(
              "Total Members: ${users.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
                          onEdit: () => handleUserForm(data: user, i: index),
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
        onPressed: () => handleUserForm(),
      ),
    );
  }
}
