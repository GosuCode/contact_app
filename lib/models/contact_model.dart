import 'dart:io';

import 'package:hive/hive.dart';
import 'package:new_contact/models/lat_long_model.dart';
part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  File? image;
  // @HiveField(3)
  // LatLngModel position;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    this.image,
    // required this.position
  });
}
