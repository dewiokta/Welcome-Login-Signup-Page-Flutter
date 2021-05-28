import 'package:flutter/material.dart';
import 'package:flutter_auth/model/pet.dart';
import 'package:flutter_auth/pages/admin/pet/form.dart';
import 'package:flutter_auth/pages/admin/petfood/page.dart';
import 'package:flutter_auth/pages/admin/accessories/page.dart';
import 'package:flutter_auth/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class PetPage extends StatefulWidget {
  @override
  PetState createState() => PetState();
}

class PetState extends State<PetPage> {
  int getId = 0;

  tampilKonfirmHapus() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Yakin ingin menghapus item ini?"),
            actions: [
              RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Ya"),
                onPressed: () async {
                  int result = await dbHelper.delete(getId);
                  if (result > 0) {
                    updateListView();
                  }
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Tidak"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Pet> itemList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateListView());
    String ItemArgs = ModalRoute.of(context).settings.arguments;
    if (itemList == null) {
      itemList = List<Pet>();
    }

    return Scaffold(
      backgroundColor: Colors.indigo[200],
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          child: Text('Pet Food'),
                          color: Colors.indigo,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FdPage()));
                          },
                        ),
                        RaisedButton(
                          child: Text('Accessories'),
                          color: Colors.indigo,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AcPage()));
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RaisedButton(
                          child: Text('Tambah Item'),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () async {
                            var pet = await navigateToPetForm(context, null);
                            if (pet != null) {
                              int result = await dbHelper.insert(pet);
                              if (result > 0) {
                                updateListView();
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: createListView(),
            ),
          ],
        ),
      ),
    );
  }

  Future<Pet> navigateToPetForm(BuildContext context, Pet pet) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return PetForm(pet);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      this.itemList[index].gambar,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        return Padding(
                          padding: EdgeInsets.all(1.0),
                          child: child,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.itemList[index].nama,
                              style: textStyle,
                            ),
                            Text(this.itemList[index].detail,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Rp. ' + this.itemList[index].price.toString(),
                        style: TextStyle(fontSize: 15)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Stok', style: TextStyle(fontSize: 15)),
                        Text(this.itemList[index].stok.toString(),
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text('Hapus'),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      getId = itemList[index].id;
                      tampilKonfirmHapus();
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  RaisedButton(
                      child: Text('Edit'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        var pet = await navigateToPetForm(
                            context, this.itemList[index]);
                        if (pet != null) {
                          int result = await dbHelper.update(pet);
                          if (result > 0) {
                            updateListView();
                          }
                        }
                      }),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Pet>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
