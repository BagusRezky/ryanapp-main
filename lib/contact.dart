import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:ryanapp/UI_chat.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/contoh_state_chat.dart';

class Contact extends StatefulWidget {
  final String username;
  const Contact({super.key, required this.username});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: themeProvider.theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: Provider.of<ChatProvider>(context)
              .listPercakapan
              .entries
              .map((chat) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatScreen(chatKey: chat.key)));
              },
              child: SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showProfileDetail(context, chat.value,
                          chat.key), // Use the globally accessible function
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: chat.value.profPic.isNotEmpty
                            ? NetworkImage(chat.value.profPic)
                            : null,
                        child: chat.value.profPic.isEmpty
                            ? const Icon(Icons.person, size: 30)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(chat.value.namaTeman,
                            style: TextStyle(
                                fontSize: 18,
                                color: themeProvider.theme == ThemeData.dark()
                                    ? const Color.fromRGBO(255, 255, 255, 0.7)
                                    : Colors.black))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      backgroundColor: themeProvider.theme.scaffoldBackgroundColor,
    );
  }

  void _showProfileDetail(BuildContext context, Chatting chat, String chatKey) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 300,
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stack for name and profile picture
                Stack(
                  children: [
                    // Profile picture
                    Container(
                      height: 250, // Adjust height as necessary
                      width:
                          double.infinity, // Ensure it fills the dialog width
                      decoration: BoxDecoration(
                        color: Colors.grey, // Default background color
                        image: chat.profPic.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(chat.profPic),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: chat.profPic.isEmpty
                          ? Icon(chat.isGroup ? Icons.group : Icons.person,
                              size: 80)
                          : null,
                    ),
                    // Name in the upper left corner with a darker background
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        color: Colors.black
                            .withOpacity(0.5), // Semi-transparent background
                        child: Text(
                          chat.namaTeman,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Centered chat icon button
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog first
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(chatKey: chatKey),
                      ));
                    },
                    child: const Icon(
                      Icons.chat,
                      size: 50, // Larger icon size for better interaction
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
