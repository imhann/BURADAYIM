import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../db/urunler.dart';

class ListProvider with ChangeNotifier {
  List<Urunler> items = []; // Liste değişkeni

  List<Urunler> listem() {
    return items;
  }

  void addItem(Urunler item) {
    if (!isItemExists(item)) {
      items.add(item);
      notifyListeners();
    }
  }

  bool isItemExists(Urunler item) {
    return items.contains(item);
  }

  void removeItem(Urunler item) {
    items.remove(item);
    notifyListeners();
  }

  void clearList() {
    items = [];
    notifyListeners();
  }
}
