import 'dart:io';

import 'package:new_contact/models/lat_long_model.dart';

class ContactModel {
  String name;
  String phoneNumber;
  File? image;
  LatLngModel position;

  ContactModel(
      {required this.name,
      required this.phoneNumber,
      this.image,
      required this.position});
}
