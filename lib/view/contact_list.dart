import 'package:contact_api/controller/controller.dart';
import 'package:contact_api/model/model.dart';
import 'package:contact_api/view/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: fetchDetails(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Consumer<ContactProvider>(
                    builder: (context, contactrovider, child) {
                  return ListView.builder(
                      itemCount: contactrovider.contacts.length,
                      itemBuilder: (context, index) {
                        final ContactApi contact =
                            contactrovider.contacts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: ListTile(
                              title: Text(contact.name.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Phone : ${contact.phone}'),
                                  Text('Email : ${contact.email}'),
                                  Text('Address : ${contact.address}'),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    gotoEdit(context, contact);
                                  } else if (value == 'delete') {
                                    deleteContact(
                                        context, contact.id.toString());
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                        value: 'edit', child: Text('Edit')),
                                    const PopupMenuItem(
                                        value: 'delete', child: Text('Delete'))
                                  ];
                                },
                              )),
                        );
                      });
                });
              }
            },
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoAdd(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchDetails(BuildContext context) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    await provider.fetchContact(context);
  }

  void gotoAdd(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddScreen(),
        )).then((value) {
      if (value != null) {
        final provider = Provider.of<ContactProvider>(context, listen: false);
        provider.fetchContact(context);
      }
    });
  }

  void gotoEdit(BuildContext context, ContactApi contactApi){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen(
      contact: contactApi,
    ),
    )).then((value) {
      if (value != null) {
        final provider = Provider.of<ContactProvider>(context, listen: false);
        provider.fetchContact(context);
      }
    });
  }

  Future <void> deleteContact(BuildContext context,String id) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    try {
      await provider.deleteContact(id);
    }
    catch (e) {
      print("failed to delete");
    }
  }
}
