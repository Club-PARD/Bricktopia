import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_model.dart';

void fetchClothingItems(
    DocumentReference matchingTemperatureDoc,
    Function(List<ClothingItem>) updateTops,
    Function(List<ClothingItem>) updateOuters,
    Function(List<ClothingItem>) updateBottoms,
    Function(List<ClothingItem>) updateAccessories) {
  final topsCollection = matchingTemperatureDoc.collection('top');
  topsCollection.get().then((snapshot) {
    final topsData = snapshot.docs.map((doc) => doc.data()).toList();
    updateTops(topsData
        .map((data) => ClothingItem(
              itemName: data['item_name'],
              url: data['url'],
            ))
        .toList());
  });

  final outersCollection = matchingTemperatureDoc.collection('outer');
  outersCollection.get().then((snapshot) {
    final outersData = snapshot.docs.map((doc) => doc.data()).toList();
    updateOuters(outersData
        .map((data) => ClothingItem(
              itemName: data['item_name'],
              url: data['url'],
            ))
        .toList());
  });

  final bottomCollection = matchingTemperatureDoc.collection('bottom');
  bottomCollection.get().then((snapshot) {
    final bottomData = snapshot.docs.map((doc) => doc.data()).toList();
    updateBottoms(bottomData
        .map((data) => ClothingItem(
              itemName: data['item_name'],
              url: data['url'],
            ))
        .toList());
  });

  final otherCollection = matchingTemperatureDoc.collection('other');
  otherCollection.get().then((snapshot) {
    final otherData = snapshot.docs.map((doc) => doc.data()).toList();
    updateAccessories(otherData
        .map((data) => ClothingItem(
              itemName: data['item_name'],
              url: data['url'],
            ))
        .toList());
  });
}
