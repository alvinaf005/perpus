import 'package:perpus/dataadmin/admin.dart';
import 'package:perpus/halamannavigasi/beranda.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;
  EditData({required this.list, required this.index});

  @override
  _EditDataState createState() => _EditDataState();
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
      "id_buku": widget.list[widget.index]['id_buku'],
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
        TextEditingController(text: widget.list[widget.index]['id_buku']);
    controllerJudul =
        TextEditingController(text: widget.list[widget.index]['judul_buku']);
    controllerPengarang =
        TextEditingController(text: widget.list[widget.index]['pengarang']);
    controllerPenerbit =
        TextEditingController(text: widget.list[widget.index]['penerbit']);
    controllerTahun =
        TextEditingController(text: widget.list[widget.index]['tahun_terbit']);
    controllerTempat =
        TextEditingController(text: widget.list[widget.index]['tempat_terbit']);
    controllerRak =
        TextEditingController(text: widget.list[widget.index]['rak']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: controllerID,
              decoration: InputDecoration(hintText: "Barcode", labelText: "ID"),
            ),
            TextField(
              controller: controllerJudul,
              decoration: InputDecoration(
                  hintText: "Judul Buku", labelText: "Judul Buku"),
            ),
            TextField(
              controller: controllerPengarang,
              decoration: InputDecoration(
                  hintText: "Pengarang", labelText: "Pengarang"),
            ),
            TextField(
              controller: controllerPenerbit,
              decoration:
                  InputDecoration(hintText: "Penerbit", labelText: "Penerbit"),
            ),
            TextField(
              controller: controllerTahun,
              decoration: InputDecoration(
                  hintText: "Tahun Terbit", labelText: "Tahun Terbit"),
            ),
            TextField(
              controller: controllerTempat,
              decoration: InputDecoration(
                  hintText: "Tempat Terbit", labelText: "Tempat Terbit"),
            ),
            TextField(
              controller: controllerRak,
              decoration: InputDecoration(hintText: "Rak", labelText: "Rak"),
            ),
            Padding(padding: const EdgeInsets.all(15)),
            RaisedButton(
              child: Text("EDIT"),
              color: Colors.green,
              onPressed: () {
                editData();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AdminPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
