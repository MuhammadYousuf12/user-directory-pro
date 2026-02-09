import 'package:flutter/material.dart';
import 'package:profile_ui_practice/models/user_model.dart';
import 'package:profile_ui_practice/screens/user_details.dart';

class InfoCard extends StatelessWidget {
  final UserModel user;
  final IconData icon; // UI expects IconData here
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InfoCard({
    super.key,
    required this.user,
    required this.icon,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetail(user: user)),
          );
        },
        child: ListTile(
          leading: Icon(icon, size: 30, color: Colors.blue),
          title: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(user.profession),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
