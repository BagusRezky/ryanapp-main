import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/contoh_state_chat.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({super.key, required this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    print("Halaman home dibuat");
    super.initState();
  }

  @override
  void dispose() {
    print("Halaman home dihancurkan");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          children: Provider.of<ChatProvider>(context).listPercakapan.entries.map((chat){
            return InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChatScreen(chatKey: chat.key))
                );
              },
              child: Container(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    chat.value.profPic == "" ?
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      )
                        :
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(chat.value.profPic),
                      ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(chat.value.namaTeman, style: TextStyle(fontSize: 18)),
                        Text(chat.value.daftarChat.last.values.join("")),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}