import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chatting {
  String namaTeman;
  String profPic;
  List<Map<String, dynamic>> daftarChat;
  bool isGroup;
  List<String> participants;

  Chatting({
    required this.namaTeman,
    required this.profPic,
    required this.daftarChat,
    this.isGroup = false,
    this.participants = const [],
  });

  get key => null;
}

class ChatProvider extends ChangeNotifier {
  Map<String, Chatting> listPercakapan = {
    "abc123": Chatting(namaTeman: "Budi", profPic: "", daftarChat: [
      {"Budi": "Hi"},
      {"Me": "Hi juga"},
      {"Budi": "apa maksudmu?"},
    ]),
    "abc124": Chatting(
        namaTeman: "Yanto",
        profPic:
            "https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/04/2023/09/26/Cuplikan-layar-2023-09-26-132148-4020702659.png",
        daftarChat: [
          {"Yanto": "Hi"},
          {"Me": "Mabar kuy"},
          {"Yanto": "Gaskeun"}
        ]),
    "abc125": Chatting(
        namaTeman: "Nazwa",
        profPic:
            "https://media.licdn.com/dms/image/D4E03AQFjvF8zy49GRA/profile-displayphoto-shrink_800_800/0/1690856807208?e=2147483647&v=beta&t=z8JwwmPu1QiIZXPQct6SWX9AwbcO94s4bePvdR4jFf8",
        daftarChat: []),
    "abc126": Chatting(
        namaTeman: "Chinta Roboth",
        profPic:
            "https://jurnal6.com/wp-content/uploads/2019/10/IMG-20191021-WA0049.jpg",
        daftarChat: []),
    "abc127": Chatting(
        namaTeman: "Jerome Polin",
        profPic:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_xuhATvyRKQW84xILJE2HtUt9KsfNLR0yh1Y47sSqsA&s",
        daftarChat: []),
  };

  Map<String, Chatting> listGroupChats = {
    "group123": Chatting(
      namaTeman: "Paguyuban Bola Club",
      profPic:
          "https://c8.alamy.com/comp/BB2TB1/a-homeless-girl-sleeping-in-the-streets-of-manila-BB2TB1.jpg",
      daftarChat: [
        {"Asep": "Minggu ni Arema VS Persija"},
        {"Epan": "Gass otw kesana"},
        {"Pulu": "Sipp brayy"}
      ],
      isGroup: true,
      participants: ["Asep", "Epan", "Pulu"],
    ),
    "group124": Chatting(
      namaTeman: "Grub diskusi OKOC",
      profPic: "",
      daftarChat: [
        {"Ucok": "Gimana gais? "},
        {"Mei": "Amannn udh dikerjain"},
        {"Tedi": "Mantap"}
      ],
      isGroup: true,
      participants: ["Ucok", "Mei", "Tedi"],
    ),
  };

  // void addChat(Map<String, String> chat, String chatKey) {
  //   if (listPercakapan.containsKey(chatKey)) {
  //     listPercakapan[chatKey]!.daftarChat.add(chat);
  //   } else if (listGroupChats.containsKey(chatKey)) {
  //     listGroupChats[chatKey]!.daftarChat.add(chat);
  //   }
  //   notifyListeners();
  // }

    void addChat(Map<String, dynamic> chat, String chatKey,
      {DateTime? scheduleTime}) {
    if (scheduleTime != null) {
       final formattedDate =
          DateFormat('dd MMM yyyy HH:mm').format(scheduleTime);
      final placeholderText = "Message will appear on $formattedDate";
      _actualAddChat({"Me": placeholderText}, chatKey);
      Future.delayed(scheduleTime.difference(DateTime.now()), () {
        _actualReplaceChat(placeholderText, chat, chatKey);
      });
    } else {
      _actualAddChat(chat, chatKey);
    }
  }

  void _actualAddChat(Map<String, dynamic> chat, String chatKey) {
    if (listPercakapan.containsKey(chatKey)) {
      listPercakapan[chatKey]!.daftarChat.add(chat);
    } else if (listGroupChats.containsKey(chatKey)) {
      listGroupChats[chatKey]!.daftarChat.add(chat);
    }
    notifyListeners();
  }

  void _actualReplaceChat(
      String placeholderText, Map<String, dynamic> chat, String chatKey) {
    if (listPercakapan.containsKey(chatKey)) {
      var chatList = listPercakapan[chatKey]!.daftarChat;
      var index = chatList
          .indexWhere((element) => element.values.first == placeholderText);
      if (index != -1) {
        chatList[index] = chat;
      }
    } else if (listGroupChats.containsKey(chatKey)) {
      var chatList = listGroupChats[chatKey]!.daftarChat;
      var index = chatList
          .indexWhere((element) => element.values.first == placeholderText);
      if (index != -1) {
        chatList[index] = chat;
      }
    }
    notifyListeners();
  }

  void deleteChat(String chatKey) {
    if (listPercakapan.containsKey(chatKey)) {
      listPercakapan.remove(chatKey); // Delete chat from personal chats
    } else if (listGroupChats.containsKey(chatKey)) {
      listGroupChats.remove(chatKey); // Delete chat from group chats
    }
    notifyListeners(); // Notify all listeners about the change
  }

  Map<String, Chatting> getAllChats() {
    return {...listPercakapan, ...listGroupChats};
  }
}

class providerDisappear extends ChangeNotifier {
  int groupVal = 3;

  void changeVal(int val) {
    groupVal = val;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.light();
  ThemeData get theme => _theme;
  double _textSize = 16.0;
  double get textSize => _textSize;
  void toogleTheme(bool val) {
    final isDark = _theme == ThemeData.light();
    if (isDark) {
      _theme = ThemeData.dark();
    } else {
      _theme = ThemeData.light();
    }
    notifyListeners();
  }

  void setTextSize(double size) {
    _textSize = size;
    notifyListeners();
  }
}
