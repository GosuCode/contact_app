import 'package:flutter/material.dart';
import 'package:new_contact/models/contact_model.dart';
import 'package:new_contact/models/lat_long_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ContactModel> contacts = [
    ContactModel(
        name: "Alu",
        phoneNumber: "9804406944",
        image: "https://avatars.githubusercontent.com/u/104659592?v=4",
        position: LatLngModel(latitude: 27.686386, longitude: 83.432426)),
    ContactModel(
        name: "Layla",
        phoneNumber: "9867725022",
        image:
            "https://i.pinimg.com/originals/3a/c3/ed/3ac3edd7dc47205a016e7e2897c4b100.jpg",
        position: LatLngModel(latitude: 52.25685, longitude: 83.432426)),
    ContactModel(
        name: "Noelle",
        phoneNumber: "9804406944",
        image:
            "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2020/12/Noelle-Upclose-Genshin_impact-Cropped.png",
        position: LatLngModel(latitude: 27.686386, longitude: 99.6258)),
  ];
  @override
  Widget build(BuildContext context) {
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
                    context: context,
                    builder: (_) => BottomSheet(
                        onClosing: () {},
                        builder: (_) => Container(
                              height: 100,
                              color: Colors.red,
                            )));
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
                  child: Image.network(
                    contacts[index].image,
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