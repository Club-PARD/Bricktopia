import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_summary/item_model.dart';

class ItemService {
  static void getMatchingItems(
      String range,
      Function(List<ClothingItem>) updateTops,
      Function(List<ClothingItem>) updateOuters,
      Function(List<ClothingItem>) updateBottoms,
      Function(List<ClothingItem>) updateAccessories) async {
    final CollectionReference temperatureRanges =
        FirebaseFirestore.instance.collection('temperature');
    final matchingTemperatureDoc = temperatureRanges.doc(range);

    matchingTemperatureDoc.get().then((snapshot) {
      if (snapshot.exists) {
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
    });
  }
}
