import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:unicode_app/info_screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> contacts = [];
  List<Contact> search = [];
  final controller = TextEditingController();

  getallcontacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  searchcontacts(String value) {
    setState(() {
      search = contacts
          .where((contact) =>
              contact.displayName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    search = List.from(contacts);
    // TODO: implement initState
    super.initState();
    getallcontacts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                searchcontacts(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: search.length,
                  itemBuilder: (context, index) {
                    Contact contact = search[index];
                    return ListTile(
                      title: Text(contact.displayName ?? ''),
                      leading:
                          (contact.avatar != null && contact.avatar!.length > 0)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar!),
                                )
                              : CircleAvatar(
                                  child: Text(contact.initials()),
                                ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InfoScreen(contact: contact)));
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}




 // try {
    //   List<Contact> _contacts =
    //       await ContactsService.getContacts(withThumbnails: true);
    //   setState(() {
    //     contacts = _contacts;
    //   });
    // } catch (e) {
    //   print('Error accessing contacts: $e');
    //   // Handle the error gracefully, e.g., show a message to the user.
    // }