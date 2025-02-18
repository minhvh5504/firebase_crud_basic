import 'package:firebase_crud_basic/components/button_custom.dart';
import 'package:firebase_crud_basic/components/text_field.dart';
import 'package:firebase_crud_basic/service/database_service.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _dbService = DatabaseService();

  void createUser() {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phone = _phoneController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      _dbService.create({
        "name": name,
        "email": email,
        "phone": phone,
      });
      showSnackBar("User created successfully");
    } else {
      showSnackBar("Please fill in all the information");
    }
  }

  void readUsers() async {
    final String name = _nameController.text.trim();

    final users = await _dbService.readUsersByName(name);

    if (users.isNotEmpty) {
      final user = users[0];
      setState(() {
        _nameController.text = user['name'] ?? '';
        _emailController.text = user['email'] ?? '';
        _phoneController.text = user['phone'] ?? '';
      });
      showSnackBar("User found");
    } else {
      showSnackBar("No users found");
    }
  }

  void updateUser() async {
    final String name = _nameController.text.trim();

    final updatedData = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
    };

    await _dbService.updateUsersByName(name, updatedData);

    showSnackBar("User updated successfully");
  }

  void deleteUser() async {
    final String name = _nameController.text.trim();

    await _dbService.deleteUsersByName(name);

    showSnackBar("User deleted successfully");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Firestore",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldCustom(controller: _nameController, hintText: "Name"),
                TextFieldCustom(
                    controller: _emailController, hintText: "Email"),
                TextFieldCustom(
                    controller: _phoneController, hintText: "Phone"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonCustom(title: "Create", onPressed: createUser),
                    ButtonCustom(title: "Read", onPressed: readUsers),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonCustom(
                        title: "Update", onPressed: () => updateUser()),
                    ButtonCustom(
                        title: "Delete", onPressed: () => deleteUser()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
