import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contact.dart';
import 'package:ryanapp/contoh_prov.dart';
import 'package:ryanapp/detail_akun.dart';
import 'package:ryanapp/setting.dart';

import 'contoh_state_chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DetailAkun()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Setting()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ryan Chatting App",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Profile'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Settings'),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: themeProvider.theme.appBarTheme.backgroundColor,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "All Chats"),
            Tab(text: "Groups"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatList(),
          _buildGroupChatList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Contact(username: '')));
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

 Widget _buildChatList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: Provider.of<ChatProvider>(context)
            .getAllChats()
            .entries
            .where((chat) => chat.value.daftarChat.isNotEmpty)
            .map((chat) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(chatKey: chat.key)));
                  },
                  onLongPress: () => _showDeleteDialog(context,
                      chat.value.isGroup, chat.key, chat.value.namaTeman),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _showProfileDetail(context, chat.value, chat.key),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: chat.value.profPic.isNotEmpty
                                ? NetworkImage(chat.value.profPic)
                                : null,
                            child: chat.value.profPic.isEmpty
                                ? Icon(
                                    chat.value.isGroup
                                        ? Icons.group
                                        : Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(chat.value.namaTeman,
                                  style: const TextStyle(fontSize: 18)),
                              Text(chat.value.daftarChat.last.values.join(""),
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

 Widget _buildGroupChatList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: Provider.of<ChatProvider>(context)
            .listGroupChats
            .entries
            .where((chat) => chat.value.daftarChat.isNotEmpty)
            .map((chat) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(chatKey: chat.key)));
                  },
                  onLongPress: () => _showDeleteDialog(context,
                      chat.value.isGroup, chat.key, chat.value.namaTeman),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _showProfileDetail(context, chat.value, chat.key),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: chat.value.profPic.isNotEmpty
                                ? NetworkImage(chat.value.profPic)
                                : null,
                            child: chat.value.profPic.isEmpty
                                ? const Icon(Icons.group,
                                    size: 30, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(chat.value.namaTeman,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(chat.value.daftarChat.last.values.join(""),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, bool isGroup, String chatKey, String chatName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete chat from ${chatName}'),
          content: Text(
              'If you delete this chat, you won’t be able to recover it. Do you want to delete it?'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('DELETE'),
              onPressed: () {
                // Implement your deletion logic here
                Provider.of<ChatProvider>(context, listen: false)
                    .deleteChat(chatKey);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
