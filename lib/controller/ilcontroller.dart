import 'package:get/get.dart';

class IllerController extends GetxController {
  // ignore: prefer_final_fields
  RxString secilenIl = 'Kahramanmaraş'.obs;

  secIl(var key) {
    secilenIl = key;
  }
}
