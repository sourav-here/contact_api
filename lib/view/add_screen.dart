import 'package:contact_api/controller/controller.dart';
import 'package:contact_api/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key, this.contact});
  final ContactApi? contact;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final TextEditingController nameController = provider.nameController;
    final TextEditingController phoneController = provider.phoneController;
    final TextEditingController emailController = provider.emailController;
    final TextEditingController addressController = provider.addressController;

    if (contact != null) {
      nameController.text = contact!.name;
      phoneController.text = contact!.phone;
      emailController.text = contact!.email;
      addressController.text = contact!.address;
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('Contact'),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(hintText: 'Enter number'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Enter email'),
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(hintText: 'Enter address'),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                  onPressed: () {
                    submit(context, nameController.text, phoneController.text,
                        emailController.text, addressController.text);
                  },
                  icon: Icon(contact != null ? Icons.edit : Icons.add),
                  label: const Text('save')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submit(BuildContext context, String name, String phone,
      String email, String address) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    if (contact != null) {
      await provider.updateContact(contact!.id, name, phone, email, address);
      provider.clearControllers();
    } else {
      await provider.submitContact(name, phone, email, address);
      provider.clearControllers();
    }
    // ignore: use_build_context_synchronously
    provider.fetchContact(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
