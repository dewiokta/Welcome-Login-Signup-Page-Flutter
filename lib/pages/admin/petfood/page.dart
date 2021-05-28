import 'package:flutter/material.dart';
import 'package:flutter_auth/model/petfood.dart';
import 'package:flutter_auth/pages/admin/petfood/form.dart';
import 'package:flutter_auth/pages/admin/pet/page.dart';
import 'package:flutter_auth/pages/admin/accessories/page.dart';
import 'package:flutter_auth/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class FdPage extends StatefulWidget {
  @override
  FdState createState() => FdState();
}

class FdState extends State<FdPage> {
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
                  int result = await dbHelper.deleteFd(getId);
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
  List<Petfood> itemList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateListView());
    String ItemArgs = ModalRoute.of(context).settings.arguments;
    if (itemList == null) {
      itemList = List<Petfood>();
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
                          child: Text('Pet'),
                          color: Colors.indigo,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PetPage()));
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
                            var petfood = await navigateToFdForm(context, null);
                            if (petfood != null) {
                              int result = await dbHelper.insertFd(petfood);
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

  Future<Petfood> navigateToFdForm(
      BuildContext context, Petfood petfood) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return FdForm(petfood);
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
                        var petfood = await navigateToFdForm(
                            context, this.itemList[index]);
                        if (petfood != null) {
                          int result = await dbHelper.updateFd(petfood);
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
      Future<List<Petfood>> itemListFuture = dbHelper.getItemListFd();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
