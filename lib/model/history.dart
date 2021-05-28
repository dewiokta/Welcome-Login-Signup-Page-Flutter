class History {
  int _id;
  String _nama;
  String _alamat;
  String _email;
  String _dibeli;
  int _price;

  //method getter untuk id
  int get id => _id;

  //getter setter untuk nama history
  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  //getter setter untuk alamat history
  String get alamat => this._alamat;
  set alamat(String value) => this._alamat = value;

  //getter setter untuk email history
  String get email => this._email;
  set email(String value) => this._email = value;

  //getter setter untuk barang yang dibeli history
  String get dibeli => this._dibeli;
  set dibeli(String value) => this._dibeli = value;

  //getter setter untuk price history
  get price => this._price;
  set price(value) => this._price = value;

  History(this._nama, this._alamat, this._email, this._dibeli, this._price);

  //konversi dari Map ke history
  History.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._alamat = map['alamat'];
    this._email = map['email'];
    this._dibeli = map['dibeli'];
    this._price = map['price'];
  }

  //konversi dari history ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['email'] = email;
    map['dibeli'] = dibeli;
    map['price'] = price;
    return map;
  }
}
