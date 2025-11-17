import 'package:get_storage/get_storage.dart';

import '../common/storage/local_storage.dart';

class ProfileController{

  var box = GetStorage();
  get firstName => box.read(firstNameIndex);
  get lastName => box.read(lastNameIndex);
}