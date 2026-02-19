import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Enter Name"),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Name is required"
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: professionController,
                decoration: const InputDecoration(
                  labelText: "Enter Profession",
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Profession is required"
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Enter Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (!EmailValidator.validate(value)) {
                    return "Please enter valid Email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PhoneInputFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: "Enter Phone Number",
                  hintText: "0300 1234567",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (value.length < 11) return "Enter valid phone number";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: skillsController,
                decoration: const InputDecoration(labelText: "Enter Skills"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    if (text.length > 11) text = text.substring(0, 11);

    var newString = "";
    for (int i = 0; i < text.length; i++) {
      newString += text[i];
      if (i == 3 && text.length > 4) {
        newString += " ";
      }
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
