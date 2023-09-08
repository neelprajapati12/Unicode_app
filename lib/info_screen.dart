import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final Contact contact;
  InfoScreen({
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  contact.initials(),
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
            ),
          ),
          Text(
            contact.displayName ?? '',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 99, 121, 176),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Info",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: contact.phones!.length,
                            itemBuilder: (context, index) {
                              final phone = contact.phones!.elementAt(index);
                              return Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 28,
                                  ),
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text(
                                    phone.value ?? '',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
