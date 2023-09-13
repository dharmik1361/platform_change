import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/contact.dart';
import '../Provider/contact_provider.dart';
import '../Provider/image_provider.dart';
import '../Provider/theme_povider.dart';
import '../utils/utils.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final chatController = TextEditingController();
  final int hour = DateTime.now().hour;
  String currentTime = 'Pick Time';
  String currentDate = 'Pick Date';
  String image = '';

  final BoxDecoration iosDecoration = BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5));

  InputDecoration androidDecoration(String label, IconData icon) =>
      InputDecoration(
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          labelText: label,
          prefixIcon: Icon(icon));

  void clear() {
    image = '';
    fullNameController.text = '';
    phoneController.text = '';
    chatController.text = '';
    currentTime = 'Pick Time';
    currentDate = 'Pick Date';
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerProvider = Provider.of<ImagePickerProvider>(context);
    Contact contact = Contact(
        image: image,
        fullName: fullNameController.text,
        phone: phoneController.text,
        chat: chatController.text,
        date: currentDate,
        time: currentTime);
    final provider = Provider.of<ThemeProvider>(context).Platform;
    if (provider) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await imagePickerProvider.pickImage();
                      // Update UI or do something with the selected image
                    },
                    child: imagePickerProvider.pickedImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                                File(imagePickerProvider.pickedImage!.path)),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.camera),
                          ),
                  )),
              CupertinoTextFormFieldRow(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: fullNameController,
                placeholder: 'Full Name',
                prefix: const Icon(CupertinoIcons.person),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                controller: phoneController,
                placeholder: 'Phone Number',
                prefix: const Icon(CupertinoIcons.phone),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                onChanged: (value) {
                  chatController.text = value;
                },
                controller: chatController,
                placeholder: 'Chat Conversation',
                prefix: const Icon(CupertinoIcons.chat_bubble_text),
                decoration: iosDecoration,
              ),
              CupertinoTextFormFieldRow(
                controller: TextEditingController(text: currentDate),
                readOnly: true,
                prefix: const Icon(CupertinoIcons.calendar),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 190,
                      child: CupertinoDatePicker(
                        showDayOfWeek: true,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) {
                          setState(() {
                            currentDate =
                                '${value.day}/${value.month}/${value.year}';
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              CupertinoTextFormFieldRow(
                controller: TextEditingController(text: currentTime),
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 190,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          currentTime = '${value.hour}:${value.minute}';
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
                prefix: const Icon(CupertinoIcons.time),
              ),
              CupertinoButton(
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<ContactProvider>(context, listen: false)
                        .addContact(contact);
                  },
                  child: const Text('SAVE'))
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () async {
                    final pickedImage = await Utils().pickImage();
                    if (pickedImage.isNotEmpty) {
                      setState(() {
                        image = pickedImage;
                      });
                    }
                  },
                  child: image.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(image)),
                          radius: 50,
                        )
                      : CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.add_a_photo_outlined),
                        ),
                ),
              ),
              TextField(
                  controller: fullNameController,
                  decoration:
                      androidDecoration('Full Name', Icons.person_2_outlined)),
              const SizedBox(height: 10),
              TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: androidDecoration('Phone Number', Icons.call)),
              const SizedBox(height: 10),
              TextField(
                  controller: chatController,
                  decoration: androidDecoration(
                      'Chat Conversation', Icons.chat_outlined)),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton.icon(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2050))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              currentDate =
                                  '${value.day}/${value.month}/${value.year}';
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.date_range),
                      label: Text(currentDate)),
                  TextButton.icon(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              currentTime =
                                  '${value.hour}:${value.minute} ${value.period.name}';
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.access_time_outlined),
                      label: Text(currentTime)),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  Provider.of<ContactProvider>(context, listen: false)
                      .addContact(contact);
                  clear();
                },
                child: const Text('SAVE'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
