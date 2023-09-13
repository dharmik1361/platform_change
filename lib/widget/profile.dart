import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../main.dart';

class Profile extends StatefulWidget {
  final bool visible;
  final bool platform;

  const Profile({
    super.key,
    required this.visible,
    required this.platform,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController =
  TextEditingController(text: pref.getString('name') ?? '');
  final bioController =
  TextEditingController(text: pref.getString('bio') ?? '');
  String imagePath = ''; // Added to store the selected image path

  Future<void> pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path; // Save the selected image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await pickImage(); // Open image picker
            },
            child: imagePath.isNotEmpty
                ? CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(File(imagePath)),
            )
                : const CircleAvatar(
              radius: 50,
              child: Icon(CupertinoIcons.camera),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: widget.platform
                ? Column(
              children: [
                CupertinoTextField(
                  controller: nameController,
                  decoration: const BoxDecoration(),
                  textAlign: TextAlign.center,
                  placeholder: 'Enter your name...',
                ),
                CupertinoTextField(
                  controller: bioController,
                  decoration: const BoxDecoration(),
                  textAlign: TextAlign.center,
                  placeholder: 'Enter your bio...',
                )
              ],
            )
                : Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Enter your name...'),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: bioController,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Enter your bio...'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      bioController.text.isNotEmpty) {
                    pref.setString('name', nameController.text);
                    pref.setString(('bio'), bioController.text);
                    // Save the selected image path along with name and bio
                    pref.setString('imagePath', imagePath);
                  }
                },
                child: const Text('SAVE'),
              ),
              TextButton(
                onPressed: () {
                  nameController.text = '';
                  bioController.text = '';
                  imagePath = ''; // Clear the selected image path
                  pref.remove('name');
                  pref.remove('bio');
                  pref.remove('imagePath'); // Remove the saved image path
                },
                child: const Text('CLEAR'),
              )
            ],
          )
        ],
      ),
    );
  }
}
