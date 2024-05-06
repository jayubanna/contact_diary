import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/contact_provider.dart';
import '../model/contact_model.dart';
import 'detail_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final ContactModel contact =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Text(
                          "${contact.name ?? ""}"[0].toUpperCase().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        maxRadius: 90,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${contact.name ?? " "} ${contact.lastname ?? " "}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              int index = Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .contactList
                                  .indexOf(contact);

                              Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .deleteContact(index);

                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              int index = Provider.of<ContactProvider>(context, listen: false)
                                  .contactList
                                  .indexOf(contact);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(index: index),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 25,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "+91 ${contact.number}",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Email: ${contact.email}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("tel:${contact.number}"));
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Color(0xff08AE2D),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.call),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("sms:${contact.name}"));
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Color(0xffE9AD13),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.message),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("mailto::${contact.email}"));
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Color(0xff01C0DA),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          String con =
                              'Please Use this number ${contact.name ?? ""}:${contact.number ?? ""} ';
                          Share.share(con);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Color(0xffDB8200),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.share),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
