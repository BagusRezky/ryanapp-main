import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/login.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Color(0xffF1FADA), fontSize: 20),
        ),
        backgroundColor: themeProvider.theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 60, right: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: themeProvider.theme == ThemeData.dark(),
                  onChanged: (val) {
                    themeProvider
                        .toogleTheme(val); // Menggunakan toogleTheme dengan "g"
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Text Size'),
              ),
            ),
            Slider(
              min: 10.0,
              max: 100.0,
              divisions: 10,
              label: themeProvider.textSize.round().toString(),
              value: themeProvider.textSize,
              onChanged: (double value) {
                themeProvider.setTextSize(value);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Log Out'),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: const Icon(Icons.logout, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
