import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_model.dart';
import '../controller/contact_provider.dart';
import '../controller/logic_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      print("My Save Val $themeMode");
      Provider.of<ThemeProvider>(context, listen: false)
          .changeTheme(themeMode ?? 0);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "detail_page");
        },
      ),
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return DropdownButton(
                value: value.themeMode,
                items: [
                  DropdownMenuItem(child: Text("System"), value: 0),
                  DropdownMenuItem(child: Text("Light"), value: 1),
                  DropdownMenuItem(child: Text("Dark"), value: 2),
                ],
                onChanged: (value) async {
                  var instance = await SharedPreferences.getInstance();
                  instance.setInt("themeMode", value ?? 0);

                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value ?? 0);
                  print("value $value");
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              ContactModel contact = value.contactList[index];
              return ListTile(
                leading: CircleAvatar(
                  child:
                      Text("${contact.name ?? ""}"[0].toUpperCase().toString()),
                ),
                title:
                    Text("${contact.name ?? " "} ${contact.lastname ?? " "}"),
                subtitle: Text(contact.number ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'contact_page',
                          arguments: contact,
                        );
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
