class Item {
  late int id;
  late String _name;
  late int _price;

  Item(this._name, this._price);

  Item.map(dynamic obj) {
    this._name = obj['name'];
    this._price = obj['price'];
  }

  String get name => _name;
  int get price => _price;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = _name;
    map['price'] = _price;
    return map;
  }

  void setItemId(int id) {
    this.id = id;
  }
}
