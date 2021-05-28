import 'package:flutter/material.dart';
import 'package:flutter_auth/model/accessories.dart';

class AcForm extends StatefulWidget {
  final Accessories accessories;

  AcForm(this.accessories);

  @override
  AcFormState createState() => AcFormState(this.accessories);
}

class AcFormState extends State<AcForm> {
  Accessories accessories;

  AcFormState(this.accessories);

  TextEditingController namaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (accessories != null) {
      namaController.text = accessories.nama;
      gambarController.text = accessories.gambar;
      detailController.text = accessories.detail;
      priceController.text = accessories.price.toString();
      stokController.text = accessories.stok.toString();
    }

    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: accessories == null ? Text('Tambah') : Text('Ubah'),
        leading: InkWell(
          child: Icon(Icons.keyboard_arrow_left),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //nama
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Accessories Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //gambar
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: gambarController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Link Image',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //detail
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: detailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Accessories Detail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //price
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //stok
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (accessories == null) {
                          //insert data pada accessories
                          accessories = Accessories(
                            namaController.text,
                            gambarController.text,
                            detailController.text,
                            int.parse(priceController.text),
                            int.parse(stokController.text),
                          );
                        } else {
                          //mengubah data pada accessories
                          accessories.nama = namaController.text;
                          accessories.gambar = gambarController.text;
                          accessories.detail = detailController.text;
                          accessories.price = int.parse(priceController.text);
                          accessories.stok = int.parse(stokController.text);
                        }
                        Navigator.pop(context, accessories);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text(
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
