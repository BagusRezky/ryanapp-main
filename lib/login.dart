import 'package:flutter/material.dart';
import 'package:ryanapp/homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isError = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xff1fff455),
                radius: 60,
                child: Icon(
                  Icons.chat,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: phone,
                onChanged: (val) {
                  setState(() {
                    isError = false;
                    isVisible = false;
                  });
                },
                decoration: InputDecoration(
                  errorText: isError ? "Wrong Phone Number" : null,
                  labelText: "Nomor telepon",
                  prefixIcon: const Icon(Icons.phone),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: pass,
                onChanged: (val) {
                  setState(() {
                    isError = false;
                    isVisible = false;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: isError ? "Wrong password" : null,
                  prefixIcon: const Icon(Icons.lock),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2)),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                ),
                obscureText: true,
                // validator: (value){
                //   if (value!.length < 6) { // Minimum 6 characters
                //     return 'Password minimal 6 karakter';
                //   } return null;
                // },
              ),
              const SizedBox(height: 30),

              Visibility(
                visible: isVisible,
                child: const Text(
                  "Nomor Telepon/Password salah",
                  style: TextStyle(color: Colors.red),
                ),
              ),

              // SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (phone.text == "123" && pass.text == "123") {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Home()));
                    }
                    // else if(uname.text.isEmpty || pass.text.isEmpty){
                    //   isVisible = true;
                    // }
                    else {
                      isError = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xff1fff455)),
                child: const Text("Log in"),
              ),
              const SizedBox(height: 10),
              const Text("OR"),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                ),
                child: const Text(
                  "Log in with email",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
