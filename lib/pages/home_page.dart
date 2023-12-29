import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_contact/models/contact_model.dart';
import 'package:new_contact/models/lat_long_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  clearField() {
    image = null;
    nameController.clear();
    phoneController.clear();
  }

  selectAnImage(ImageSource source, Function(void Function()) setState) async {
    Navigator.of(context).pop();
    try {
      XFile? pickedImage = await picker.pickImage(source: source);
      // print(pickedImage!.path);
      setState(() {
        image = File(pickedImage!.path);
      });
    } catch (err) {
      log(err.toString());
    }
  }

  List<ContactModel> contacts = [];

  final ImagePicker picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    // double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.calculate),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Contacts",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    // isDismissible: false,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, setState) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              // height: deviceHeight * 0.5,
                              color: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close))
                                      ],
                                    ),
                                    Text(
                                      'Add Contact',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2)),
                                            child: image == null
                                                ? IconButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "Choose the Source"),
                                                                    content: Text(
                                                                        "Camera or Gallery"),
                                                                    actions: [
                                                                      TextButton
                                                                          .icon(
                                                                        onPressed:
                                                                            () {
                                                                          selectAnImage(
                                                                              ImageSource.camera,
                                                                              setState);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.camera),
                                                                        label: Text(
                                                                            "Camera"),
                                                                      ),
                                                                      TextButton
                                                                          .icon(
                                                                        onPressed:
                                                                            () {
                                                                          selectAnImage(
                                                                              ImageSource.gallery,
                                                                              setState);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.photo),
                                                                        label: Text(
                                                                            "Gallery"),
                                                                      )
                                                                    ],
                                                                  ));
                                                    },
                                                    icon: Icon(
                                                      Icons.add_a_photo,
                                                      size: 30,
                                                    ))
                                                : Image.file(image!)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TextFormField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                labelText: 'Full Name'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                                labelText: 'Phone Number'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        this.setState(() {
                                          contacts.add(ContactModel(
                                              name: nameController.text,
                                              phoneNumber: phoneController.text,
                                              image: image,
                                              position: LatLngModel(
                                                  latitude: 12.2,
                                                  longitude: 23.12)));
                                        });
                                        clearField();
                                      },
                                      child: Text("Add Contact"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 38,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: contacts[index].image == null
                      ? Icon(Icons.person)
                      : Image.file(
                          contacts[index].image!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].phoneNumber),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.phone),
              ),
            );
          }),
    );
  }
}
