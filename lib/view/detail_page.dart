import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/contact_provider.dart';

class DetailPage extends StatefulWidget {
  int? index;

  DetailPage({super.key, this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int ci = 0;
  TextEditingController namecontrollor = TextEditingController();
  TextEditingController lastnamecontrollor = TextEditingController();
  TextEditingController phonecontrollor = TextEditingController();
  TextEditingController emailcontrollor = TextEditingController();

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.index != null) {
      var nameVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .name ??
          "";
      var lastVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .lastname ??
          "";
      var numberVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .number ??
          "";
      var emailVal = Provider.of<ContactProvider>(context, listen: false)
              .contactList[widget.index!]
              .email ??
          "";
      namecontrollor.text = nameVal;
      lastnamecontrollor.text = lastVal;
      phonecontrollor.text = numberVal;
      emailcontrollor.text = emailVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          widget.index != null ? "Edit" : "Add",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.index != null) {
                Provider.of<ContactProvider>(context, listen: false)
                    .editContact(
                  widget.index!,
                  namecontrollor.text,
                  lastnamecontrollor.text,
                  phonecontrollor.text,
                  emailcontrollor.text,
                );
              } else {
                Provider.of<ContactProvider>(context, listen: false).addContact(
                  namecontrollor.text,
                  lastnamecontrollor.text,
                  phonecontrollor.text,
                  emailcontrollor.text,
                );
              }

              // Navigate back
              Navigator.pop(context);
            },
            icon: Icon(Icons.check, size: 30),
          )
        ],
      ),
      body: Column(
        children: [
          Stepper(
            currentStep: ci,
            onStepTapped: (index) {
              ci = index;
              setState(() {});
            },
            onStepContinue: () {
              bool isValid = true;
              if (ci == 0) {
                isValid = namecontrollor.text.isNotEmpty;
              } else if (ci == 1) {
                isValid = lastnamecontrollor.text.isNotEmpty;
              } else if (ci == 2) {
                isValid = phonecontrollor.text.isNotEmpty;
              } else if (ci == 3) {
                isValid = emailcontrollor.text.isNotEmpty;
              }

              if (isValid) {
                if (ci < 3) {
                  ci++;
                  setState(() {});
                }
              }
            },
            onStepCancel: () {
              if (ci > 0) {
                ci--;
                setState(() {});
              }
            },
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(details.currentStep == 3 ? "Submit" : "Next"),
                  ),
                  SizedBox(width: 10),
                  if (details.currentStep != 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: Text("Back"),
                    )
                ],
              );
            },
            steps: [
              Step(
                title: Text("First name"),
                content: TextFormField(
                  controller: namecontrollor,
                  decoration: InputDecoration(
                    hintText: "Enter your first name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                isActive: 0 <= ci,
              ),
              Step(
                title: Text("Last name"),
                content: TextFormField(
                  controller: lastnamecontrollor,
                  decoration: InputDecoration(
                    hintText: "Enter your last name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                isActive: 1 <= ci,
              ),
              Step(
                title: Text("Phone number"),
                content: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phonecontrollor,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                isActive: 2 <= ci,
              ),
              Step(
                title: Text("Email"),
                content: TextFormField(
                  controller: emailcontrollor,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                isActive: 3 <= ci,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
