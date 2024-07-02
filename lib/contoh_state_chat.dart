import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/disappearchat.dart';

class ChatScreen extends StatelessWidget {
  final String chatKey;

  ChatScreen({super.key, required this.chatKey});

  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);
    // Attempt to get the chat data; handle null if not found.
    Chatting? chats = chatProvider.listPercakapan[chatKey] ?? chatProvider.listGroupChats[chatKey];

    // If chats is null, we can't proceed; show an error or redirect
    if (chats == null) {
      // Example: Return to a previous screen or show an error message.
      Future.microtask(() => Navigator.of(context).pop());
      return Scaffold(
        body: Center(child: Text("No chat data available for this chat.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(chats.namaTeman),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const disappearChat()));
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: chats.daftarChat.map((chat) {
              
              return Column(
                crossAxisAlignment: chat.keys.first == "Me" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.keys.first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: chat.keys.first == "Me" ? Colors.blue : Colors.green,
                      fontSize: Provider.of<ThemeProvider>(context, listen: false)
                              .textSize,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: chat.keys.first == "Me" ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: chat.keys.first == "Me" ? Colors.blue : Colors.grey.shade300,
                            
                          ),
                          child: Row(
                            children: [
                              if (chat.values.first is String &&
                                  chat.values.first
                                      .startsWith("Message will appear on"))
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: chat.keys.first == "Me"
                                            ? Colors.white
                                            : Colors.black),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              Text(chat.values.first is String ? chat.values.first : "Message will appear on ${chat.values.first}",
                                  style: TextStyle(
                                      color: chat.keys.first == "Me" ? Colors.white : Colors.black, fontSize: Provider.of<ThemeProvider>(context, listen: false).textSize)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: chatController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (chatController.text.isNotEmpty) {
                  chatProvider.addChat({"Me": chatController.text}, chatKey);
                  chatController.clear();
                }
              },
              onLongPress: () async {
                final DateTime? scheduleTime = await _selectDateTime(context);
                if (scheduleTime != null && chatController.text.isNotEmpty) {
                  chatProvider.addChat(
                    {"Me": chatController.text},
                    chatKey,
                    scheduleTime: scheduleTime,
                  );
                  chatController.clear();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(14),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,

        );
      }
    }
    return null;
  }
}
