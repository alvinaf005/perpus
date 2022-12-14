import 'package:perpus/dataadmin/admin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerID = TextEditingController();
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerPengarang = TextEditingController();
  TextEditingController controllerPenerbit = TextEditingController();
  TextEditingController controllerTahun = TextEditingController();
  TextEditingController controllerTempat = TextEditingController();
  TextEditingController controllerRak = TextEditingController();

  void addData() {
    var url = Uri.parse('http://10.0.2.2/bukuperpus/adddata.php');
    http.post(url, body: {
      "id_buku": controllerID.text,
      "judul_buku": controllerJudul.text,
      "pengarang": controllerPengarang.text,
      "penerbit": controllerPenerbit.text,
      "tahun_terbit": controllerTahun.text,
      "tempat_terbit": controllerTempat.text,
      "rak": controllerRak.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Buku")),
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
              child: Text("ADD"),
              color: Colors.green,
              onPressed: () {
                addData();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AdminPage();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
