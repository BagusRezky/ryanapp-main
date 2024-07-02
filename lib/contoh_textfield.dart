import 'package:flutter/material.dart';

class CthTextField extends StatefulWidget {
  const CthTextField({super.key});

  @override
  State<CthTextField> createState() => _CthTextFieldState();
}

class _CthTextFieldState extends State<CthTextField> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isError = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: uname,
                onChanged: (val) {
                  setState(() {
                    isError = false;
                    isVisible = false;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                ),
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
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: phone,
                decoration: const InputDecoration(
                  labelText: "Nomor telepon",
                  prefixIcon: Icon(Icons.phone),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: isVisible,
                child: const Text(
                  "Username dan password kosong",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (uname.text == "rivaldi" && pass.text == "123") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => CthButton(),),
                      // );
                    } else if (uname.text.isEmpty || pass.text.isEmpty) {
                      isVisible = true;
                    } else {
                      isError = true;
                      uname.text = "";
                      pass.text = "";
                      phone.text = "";
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                child: const Text("Lanjut"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
