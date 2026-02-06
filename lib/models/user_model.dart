class UserModel {
  final String name;
  final String profession;
  final String email;
  final String skills;
  final String phone;
  final String icon; // Storing icon name as text (e.g., "person")

  UserModel({
    required this.name,
    required this.profession,
    required this.email,
    required this.skills,
    required this.phone,
    required this.icon,
  });

  // Converts the UserModel into a Map so it can be saved as JSON text.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profession': profession,
      'email': email,
      'skills': skills,
      'phone': phone,
      'icon': icon,
    };
  }

  // Converts the Map back into a UserModel object when loading from storage.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      profession: map['profession'],
      email: map['email'],
      skills: map['skills'],
      phone: map['phone'],
      icon: map['icon'] ?? 'person', // Default to person if icon is missing
    );
  }
}
