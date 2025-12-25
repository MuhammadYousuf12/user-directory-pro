class UserModel {
  final String name;
  final String profession;
  final String? imagePath;

  UserModel({required this.name, required this.profession, this.imagePath});

  // Data save karne ke liye Map mein convert karna
  Map<String, dynamic> toMap() {
    return {'name': name, 'profession': profession, 'imagePath': imagePath};
  }

  // Saved data se wapas object banana
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      profession: map['profession'],
      imagePath: map['imagePath'],
    );
  }
}
