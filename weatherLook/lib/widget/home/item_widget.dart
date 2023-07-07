import 'package:flutter/material.dart';
import 'package:weather_summary/item_model.dart';

class ItemWidget extends StatelessWidget {
  final List<ClothingItem> topsList;
  final List<ClothingItem> outersList;
  final List<ClothingItem> bottomList;
  final List<ClothingItem> otherList;

  const ItemWidget({
    super.key,
    required this.topsList,
    required this.outersList,
    required this.bottomList,
    required this.otherList,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 105,
          ),
          Container(
            width: (MediaQuery.of(context).size.width) / 1.14,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.77), // 배경색 지정
              borderRadius: BorderRadius.circular(40),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(217, 213, 252, 0.70),
                  spreadRadius: 1, // 그림자의 퍼짐 정도
                  blurRadius: 12, // 그림자의 흐림 정도
                  offset: Offset(0, 2), // 그림자의 위치 (x, y)
                ),
              ],
            ),
            child: SizedBox(
              height: (MediaQuery.of(context).size.height) / 2.1,
              width: (MediaQuery.of(context).size.width) / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (final topItem in topsList)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(17.5, 5, 0, 0),
                          child: Column(
                            children: [
                              Image.network(
                                topItem.url,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                              Text(topItem.itemName),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      for (final outerItem in outersList)
                        Padding(
                          padding: const EdgeInsets.only(left: 17.5),
                          child: Column(
                            children: [
                              Image.network(
                                outerItem.url,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                              Text(outerItem.itemName),
                            ],
                          ),
                        ),
                      for (final bottomItem in bottomList)
                        Padding(
                          padding: const EdgeInsets.only(left: 17.5),
                          child: Column(
                            children: [
                              Image.network(
                                bottomItem.url,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                              Text(bottomItem.itemName),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      for (final otherItem in otherList)
                        Padding(
                          padding: const EdgeInsets.only(left: 17.5),
                          child: Column(
                            children: [
                              Image.network(
                                otherItem.url,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                              Text(otherItem.itemName),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
