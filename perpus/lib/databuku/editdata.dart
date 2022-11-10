import 'package:perpus/halamannavigasi/beranda.dart';
import 'package:perpus/main.dart';
import 'package:perpus/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;
  EditData({required this.list, required this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerID;
  late TextEditingController controllerJudul;
  late TextEditingController controllerPengarang;
  late TextEditingController controllerPenerbit;
  late TextEditingController controllerTahun;
  late TextEditingController controllerTempat;
  late TextEditingController controllerRak;

  void editData() {
    var url = Uri.parse('http://10.0.2.2/bukuperpus/editdata.php');
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "judul_buku": controllerJudul.text,
      "pengarang": controllerPengarang.text,
      "penerbit": controllerPenerbit.text,
      "tahun_terbit": controllerTahun.text,
      "tempat_terbit": controllerTempat.text,
      "rak": controllerRak.text
    });
  }

  @override
  void initState() {
    controllerID =
        new TextEditingController(text: widget.list[widget.index]['id']);
    controllerJudul = new TextEditingController(
        text: widget.list[widget.index]['judul_buku']);
    controllerPengarang =
        new TextEditingController(text: widget.list[widget.index]['pengarang']);
    controllerPenerbit =
        new TextEditingController(text: widget.list[widget.index]['penerbit']);
    controllerTahun = new TextEditingController(
        text: widget.list[widget.index]['tahun_terbit']);
    controllerTempat = new TextEditingController(
        text: widget.list[widget.index]['tempat_terbit']);
    controllerRak =
        new TextEditingController(text: widget.list[widget.index]['rak']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Data Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: new ListView(
          children: <Widget>[
            new TextField(
              controller: controllerID,
              decoration:
                  new InputDecoration(hintText: "Barcode", labelText: "ID"),
            ),
            new TextField(
              controller: controllerJudul,
              decoration: new InputDecoration(
                  hintText: "Judul Buku", labelText: "Judul Buku"),
            ),
            new TextField(
              controller: controllerPengarang,
              decoration: new InputDecoration(
                  hintText: "Pengarang", labelText: "Pengarang"),
            ),
            new TextField(
              controller: controllerPenerbit,
              decoration: new InputDecoration(
                  hintText: "Penerbit", labelText: "Penerbit"),
            ),
            new TextField(
              controller: controllerTahun,
              decoration: new InputDecoration(
                  hintText: "Tahun Terbit", labelText: "Tahun Terbit"),
            ),
            new TextField(
              controller: controllerTempat,
              decoration: new InputDecoration(
                  hintText: "Tempat Terbit", labelText: "Tempat Terbit"),
            ),
            new TextField(
              controller: controllerRak,
              decoration:
                  new InputDecoration(hintText: "Rak", labelText: "Rak"),
            ),
            new Padding(padding: const EdgeInsets.all(15)),
            new RaisedButton(
              child: new Text("EDIT"),
              color: Colors.green,
              onPressed: () {
                editData();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new BerandaPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
