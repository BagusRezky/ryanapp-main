import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ryanapp/login.dart';

import 'contoh_prov.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => providerDisappear()),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'App chat',
            theme: themeProvider.theme.copyWith(
              appBarTheme: themeProvider.theme.appBarTheme.copyWith(
                backgroundColor: themeProvider.theme == ThemeData.dark()
                    ? Colors.green // Warna Appbar untuk tema gelap
                    : Colors.blue, // Warna Appbar untuk tema terang
              ),
            ),
            home: const Login(),
          );
        },
      ),
    );
  }
}
