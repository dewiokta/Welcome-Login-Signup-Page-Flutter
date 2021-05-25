class Accessories {
  int _id;
  String _nama;
  String _gambar;
  String _detail;
  int _price;
  int _stok;

  //method getter untuk id
  int get id => _id;

  //getter setter untuk nama accessories
  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  //getter setter untuk gambar accessories
  String get gambar => this._gambar;
  set gambar(String value) => this._gambar = value;

  //getter setter untuk detail accessories
  String get detail => this._detail;
  set detail(String value) => this._detail = value;

  //getter setter untuk price accessories
  get price => this._price;
  set price(value) => this._price = value;

  //getter setter untuk stok accessories
  get stok => this._stok;
  set stok(value) => this._stok = value;

  Accessories(this._nama, this._gambar, this._detail, this._price, this._stok);

  //konversi dari Map ke accessories
  Accessories.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._gambar = map['gambar'];
    this._detail = map['detail'];
    this._price = map['price'];
    this._stok = map['stok'];
  }

  //konversi dari accessories ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['gambar'] = gambar;
    map['detail'] = detail;
    map['price'] = price;
    map['stok'] = stok;
    return map;
  }
}
