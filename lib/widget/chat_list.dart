import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/contact_provider.dart';
import '../Provider/theme_povider.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ContactProvider, ThemeProvider>(
      builder: (context, value, platform, child) {
        if (value.contactList.isEmpty) {
          return const Center(child: Text('No any chats yet...'));
        }
        return ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            var data = value.contactList[index];
            if (platform.Platform) {
              return CupertinoListTile(
                leading: CircleAvatar(
                  backgroundImage: data.image.isNotEmpty
                      ? FileImage(File(data.image))
                      : null, 
                  radius: 20, 
                ),
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.chat ?? '098'),
                trailing: Text('${data.date},${data.time}'),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                        color: Colors.white,
                        child: CupertinoActionSheet()),
                  );
                },
              );
            } else {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: data.image.isNotEmpty
                      ? FileImage(File(data.image))
                      : null, 
                  radius: 20, 
                ),
                title: Text(data.fullName ?? ''),
                subtitle: Text(data.chat ?? '098'),
                trailing: Text('${data.date},${data.time}'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(radius: 50),
                            const SizedBox(height: 5),
                            Text(value.contactList[index].fullName??'',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            Text(value.contactList[index].chat ?? '',maxLines: 2),
                            const SizedBox(height: 10),
                            Consumer<ContactProvider>(
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            value.deleteChat(data);
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  );
                                }
                            ),
                            OutlinedButton(onPressed: (){}, child: const Text('Cancel'))
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
