import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryanapp/contoh_prov.dart';

class disappearChat extends StatelessWidget {
  const disappearChat({super.key});

  @override
  Widget build(BuildContext context) {
    var groupVal = Provider.of<providerDisappear>(context).groupVal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disappearing Message',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: const Color(0xff1fff455),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InkWell(
              child:
                  Icon(Icons.timelapse, color: Color(0xff1fff455), size: 150),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Make messages in the chat disappear",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                          "For more privacy and storage, new messages will disappear from this chat for everyone after the selected duration except when kept. Anyone in the chat can change this setting"),
                    ],
                  ),
                )
              ],
            ),
            const Row(
              children: [
                Text(
                  "Message timer",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RadioListTile(
              value: 0,
              groupValue: groupVal,
              onChanged: (value) {
                Provider.of<providerDisappear>(context, listen: false)
                    .changeVal(value!);
              },
              title: const Text("24 hours"),
            ),
            RadioListTile(
              value: 1,
              groupValue: groupVal,
              onChanged: (value) {
                Provider.of<providerDisappear>(context, listen: false)
                    .changeVal(value!);
              },
              title: const Text("7 days"),
            ),
            RadioListTile(
              value: 2,
              groupValue: groupVal,
              onChanged: (value) {
                Provider.of<providerDisappear>(context, listen: false)
                    .changeVal(value!);
              },
              title: const Text("90 days"),
            ),
            RadioListTile(
              value: 3,
              groupValue: groupVal,
              onChanged: (value) {
                Provider.of<providerDisappear>(context, listen: false)
                    .changeVal(value!);
              },
              title: const Text("Off"),
            ),
          ],
        ),
      ),
    );
  }
}
