import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/disappearchat.dart';

class ChatScreen extends StatelessWidget {
  final String chatKey;
  ChatScreen({super.key, required this.chatKey});

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);
    var chats = chatProvider.listPercakapan[chatKey] ??
        chatProvider.listGroupChats[chatKey];

    if (chats == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat not found'),
        ),
        body: const Center(
          child: Text('No chat found for the given key.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(chats.namaTeman),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const disappearChat()));
            },
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.access_time_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          if (chats.isGroup)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  const Text(
                    'Participants: ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: chats.participants.map((participant) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Chip(label: Text(participant)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: chats.daftarChat.map((chat) {
                    return SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: chat.keys.join("") == "Me"
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: chat.keys.join("") == "Me"
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                            child: Text(chat.values.join(""),
                                style: TextStyle(
                                    color: chat.keys.join("") == "Me"
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 270,
                  child: TextField(
                    controller: chatController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    chatProvider.addChat({"Me": chatController.text}, chatKey);
                    chatController.clear();
                  },
                  icon: const Icon(Icons.send),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
