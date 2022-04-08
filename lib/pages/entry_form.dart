import 'package:flutter/material.dart';
import 'package:flutter_praktikum_7/database/db_helper.dart';
import 'package:flutter_praktikum_7/models/item.dart';

class EntryForm extends StatefulWidget {
  final Item _item;
  final bool _isNew;

  EntryForm(this._item, this._isNew);

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  late Item item;

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  Future insertData() async {
    var db = DBHelper();
    var item = Item(nameController.text, int.parse(priceController.text));
    await db.saveItem(item);
    print('Saved');
  }

  Future updateData() async {
    var db = DBHelper();
    var item = Item(nameController.text, int.parse(priceController.text));
    item.setItemId(this.item.id);
    await db.updateItem(item);
  }

  void _saveData() {
    if (widget._isNew) {
      insertData();
    } else {
      updateData();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if (widget._item != null) {
      item = widget._item;
      nameController.text = item.name;
      priceController.text = item.price.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._isNew ? 'Tambah' : 'Ubah'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: _saveData,
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: const Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
