import 'package:contact_api/controller/controller.dart';
import 'package:contact_api/view/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: ContactList()),
    );
  }
}