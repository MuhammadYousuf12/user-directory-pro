import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class StorageServices {
  static const String _key = 'user_list';

  // Saves the list of users to local storage by converting it to a string.
  static Future<void> saveUsers(List<UserModel> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Converting the List of objects into a generic JSON string
    final String encodedData = jsonEncode(users.map((u) => u.toMap()).toList());

    await prefs.setString(_key, encodedData);
  }

  // Loads the list from storage.
  // FIX: Previously it returned empty if data existed. Now it works correctly.
  static Future<List<UserModel>> loadUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_key);

    // If no data is found (first time app run), return an empty list.
    if (encodedData == null) return [];

    // Decode the string back into a List of UserModels
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((item) => UserModel.fromMap(item)).toList();
  }
}
