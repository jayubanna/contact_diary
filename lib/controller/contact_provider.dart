import 'package:flutter/material.dart';

import '../model/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void addContact(String name, String lastname, String number, String email) {
    contactList.add(ContactModel(
        name: name, lastname: lastname, number: number, email: email));
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(
      int index, String name, String lastname, String number, String email) {
    contactList[index] = ContactModel(name: name, number: number);
    notifyListeners();
  }
}
