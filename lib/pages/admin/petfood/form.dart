import 'package:flutter/material.dart';
import 'package:flutter_auth/model/petfood.dart';

class FdForm extends StatefulWidget {
  final Petfood petfood;

  FdForm(this.petfood);

  @override
  FdFormState createState() => FdFormState(this.petfood);
}

class FdFormState extends State<FdForm> {
  Petfood petfood;

  FdFormState(this.petfood);

  TextEditingController namaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (petfood != null) {
      namaController.text = petfood.nama;
      gambarController.text = petfood.gambar;
      detailController.text = petfood.detail;
      priceController.text = petfood.price.toString();
      stokController.text = petfood.stok.toString();
    }

    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: petfood == null ? Text('Tambah') : Text('Ubah'),
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
                  labelText: 'Petfood Name',
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
                  labelText: 'Petfood Detail',
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
                        if (petfood == null) {
                          //insert data pada petfood
                          petfood = Petfood(
                            namaController.text,
                            gambarController.text,
                            detailController.text,
                            int.parse(priceController.text),
                            int.parse(stokController.text),
                          );
                        } else {
                          //mengubah data pada petfood
                          petfood.nama = namaController.text;
                          petfood.gambar = gambarController.text;
                          petfood.detail = detailController.text;
                          petfood.price = int.parse(priceController.text);
                          petfood.stok = int.parse(stokController.text);
                        }
                        Navigator.pop(context, petfood);
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
