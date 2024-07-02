import 'package:flutter/material.dart';
import 'package:ryanapp/contoh_state_next.dart';
import 'package:ryanapp/disappearchat.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "user";
  TextEditingController userController = TextEditingController();

  @override
  void initState() {
    print("Halaman login berhasil dibuat");
    super.initState();
  }

  @override
  void dispose() {
    print("Halaman login dibuang");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    username = userController.text;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Home(username: username))
                    );
                    userController.clear();
                  });
                },
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

