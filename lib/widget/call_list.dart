import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/contact_provider.dart';
import '../Provider/theme_povider.dart';
import '../utils/utils.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ContactProvider, ThemeProvider>(
      builder: (context, value, platform, child) {
        if (value.contactList.isEmpty) {
          return const Center(child: Text('No any calls yet...'));
        }
        return ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            var data = value.contactList[index];
            if (platform.Platform) {
              return CupertinoListTile(
                leading:CircleAvatar(
                  backgroundImage: data.image.isNotEmpty
                      ? FileImage(File(data.image))
                      : null, // Display the contact image if available
                  radius: 20, // You can adjust the radius as needed
                ),
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.phone ?? ''),
                trailing: GestureDetector(
                    onTap: () {
                      Utils().call(data.phone);
                    },
                    child: const Icon(
                      CupertinoIcons.phone_fill,
                      color: Colors.green,
                    )),
              );
            } else {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: data.image.isNotEmpty
                      ? FileImage(File(data.image))
                      : null, // Display the contact image if available
                  radius: 20, // You can adjust the radius as needed
                ),
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.phone ?? ''),
                trailing: IconButton(
                    onPressed: () {
                      Utils().call(data.phone);
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.green,
                    )),
              );
            }
          },
        );
      },
    );
  }
}
