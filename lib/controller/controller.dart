import 'package:contact_api/model/model.dart';
import 'package:contact_api/services/services.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier{

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  List<ContactApi> contacts = [];

  
  Future<void> fetchContact(BuildContext context)async {
    try {
      final response = await ContactServices.fetchContact();
      if(response.isEmpty){
        throw Exception('unable to fetch');
      }
      contacts = response;
    }
    catch (e) {
      Center(
        child: Text("Error:$e"),
      );
    }
    notifyListeners();
  }

  Future<void> deleteContact(String id)async {
    final fetched = await ContactServices.deleteContact(id);
    if(fetched){
      contacts.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    else{
      throw Exception('Failed to Delete');
    }
  }

  Future<bool> updateContact(String id, String name, String phone, String email, String address) async {
    try{
      await ContactServices.updateContact(id, name, phone, email, address);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> submitContact(String name, String phone, String email, String address) async {
    try {
      await ContactServices.submitContact(name, phone, email, address);
      return true;
    }
    catch(e) {
      return false;
    }
  }

  void clearControllers(){
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    emailController.clear();
    notifyListeners();
  }

}