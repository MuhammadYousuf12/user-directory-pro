import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:profile_ui_practice/models/user_model.dart';

class UserDetail extends StatelessWidget {
  final UserModel user;
  const UserDetail({super.key, required this.user});

  Future<void> _makeCall(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(' ', '');
    final Uri url = Uri(scheme: 'tel', path: cleanNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Header
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade50,
                backgroundImage:
                    (user.imagePath != null && user.imagePath!.isNotEmpty)
                    ? FileImage(File(user.imagePath!))
                    : null,
                child: (user.imagePath == null || user.imagePath!.isEmpty)
                    ? Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user.profession,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),
            // Phone ListTiles
            ListTile(
              leading: const Icon(Icons.smartphone, color: Colors.grey),
              title: const Text("Mobile Number"),
              subtitle: Text(user.phone),
              trailing: IconButton(
                onPressed: user.phone.isNotEmpty
                    ? () => _makeCall(user.phone)
                    : null,
                icon: Icon(
                  Icons.call,
                  color: user.phone.isNotEmpty ? Colors.green : Colors.grey,
                ),
              ),
            ),
            // Email ListTiles
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("Email Address"),
              subtitle: Text(user.email),
            ),
            // Skills Chips
            if (user.skills.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8.0,
                    children: user.skills
                        .split(',')
                        .where((skill) => skill.trim().isNotEmpty)
                        .map(
                          (skill) => Chip(
                            label: Text(skill.trim()),
                            backgroundColor: Colors.blue.withValues(alpha: 0.1),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
