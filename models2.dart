class Dersler {

  String? dersAdi;
  String? harfNotu;

  Dersler({
    this.dersAdi,
    this.harfNotu
  });

  Dersler.fromJson(Map<String, dynamic>json){
   dersAdi = json['dersAdi'];
   harfNotu = json['harfNotu'];
  }
}


class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Ders', //
    );
  });
}