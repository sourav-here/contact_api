import 'dart:convert';
import 'package:contact_api/model/model.dart';
import 'package:http/http.dart' as http;

class ContactServices {
  static Future<List<ContactApi>> fetchContact() async {
    final response = await http.get(Uri.parse('https://contacts-management-server.onrender.com/api/contacts'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ContactApi.fromJson(json)).toList();
    } else {
      throw Exception('Unable to load data');
    }
  }

  static Future<bool> deleteContact(String id) async {
    final response = await http.delete(Uri.parse('https://contacts-management-server.onrender.com/api/contacts/$id'));
    return response.statusCode == 200;
  }

  static Future<bool> updateContact(String id, String name, String phone,
      String email, String address) async {
    final response = await http.put(
      Uri.parse('https://contacts-management-server.onrender.com/api/contacts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": name,
        "phone":phone,
        "email": email,
        "address": address
      }),
    );
    return response.statusCode == 200;
  }

  static Future<bool> submitContact(
      String name, String phone, String email, String address) async {
    final response = await http.post(
      Uri.parse('https://contacts-management-server.onrender.com/api/contacts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": name,
        "phone":phone,
        "email": email,
        "address": address
      }),
    );
    return response.statusCode == 201;
  }
}
