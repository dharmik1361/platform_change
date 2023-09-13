import 'package:flutter/cupertino.dart';
import '../Model/contact.dart';

class ContactProvider extends ChangeNotifier{
  final List<Contact> _contactList = [];

  List<Contact> get contactList => _contactList;

  void addContact(Contact contact){
    _contactList.add(contact);
    notifyListeners();
  }

  void deleteChat(Contact contact){
    _contactList.removeWhere((element) => element == contact);
    notifyListeners();
  }

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final chatController = TextEditingController();

  TextEditingController get fullName => fullNameController;

}