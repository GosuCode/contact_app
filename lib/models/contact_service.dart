import 'package:hive/hive.dart';
import 'package:new_contact/models/contact_model.dart';

class ContactService {
  // final String _boxName = "contactBox";
  Future<Box<ContactModel>> get _box async =>
      await Hive.openBox<ContactModel>("contactBox");

  Future<void> addContact(ContactModel contactModel) async {
    var box = await _box;
    await box.add(contactModel);
  }

  Future<List<ContactModel>> getAllContact() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteContact(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}
