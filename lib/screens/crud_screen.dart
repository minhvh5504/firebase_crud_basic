import 'package:firebase_crud_basic/components/button_custom.dart';
import 'package:firebase_crud_basic/components/text_field.dart';
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

  void createUser() {
    //Logic  CreateUser From Firestore
  }

  void readUsers() {
    //Logic ReadUsers From Firestore
  }

  void updateUser(String docId) {
    //Logic UpdateUser From Firestore
  }

  void deleteUser(String docId) {
    //Logic DeletedUser From Firestore
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
                        title: "Update", onPressed: () => updateUser("doc_id")),
                    ButtonCustom(
                        title: "Delete", onPressed: () => deleteUser("doc_id")),
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
