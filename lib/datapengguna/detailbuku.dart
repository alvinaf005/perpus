import '../halamannavigasi/indexing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailBuku extends StatefulWidget {
  List list;
  int index;
  DetailBuku({required this.index, required this.list});

  @override
  _DetailBukuState createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  String nama = "";
  String nim = "";
  String jurusan = "";
  TextEditingController tgl_pinjam = TextEditingController();
  TextEditingController tgl_kembali = TextEditingController();
  @override
  void initState() {
    tgl_pinjam.text = "";
    tgl_kembali.text = "";
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nama = pref.getString("nama")!;
      nim = pref.getString("nim")!;
      jurusan = pref.getString("jurusan")!;
    });
  }

  void pinjam() {
    String id_buku = "${widget.list[widget.index]['id_buku']}";
    String judul_buku = "${widget.list[widget.index]['judul_buku']}";
    var url = Uri.parse('http://10.0.2.2/bukuperpus/pinjam.php');
    http.post(url, body: {
      "nim": '${nim}',
      "judul_buku": '${judul_buku}',
      "buku_id": '${id_buku}',
      "tgl_peminjaman": tgl_pinjam.text,
      "tgl_pengembalian": tgl_kembali.text,
    });
    print('${nim} ${id_buku} ${tgl_pinjam.text} ${tgl_kembali.text}');
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Apakah anda yakin ingin meminjam :"),
        Text("Nama       : ${nama} "),
        Text("NIM        : ${nim} "),
        Text("Jurusan    : ${jurusan} "),
        Text("Judul Buku : ${widget.list[widget.index]['judul_buku']} "),
        Text("ID Buku    : ${widget.list[widget.index]['id_buku']} "),
        TextField(
            controller: tgl_pinjam,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Tanggal Peminjaman"),
            readOnly: true,
            onTap: () async {
              DateTime? pinjamDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));
              if (pinjamDate != null) {
                print(pinjamDate);
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pinjamDate);
                print(formattedDate);
                setState(() {
                  tgl_pinjam.text = formattedDate;
                });
              } else {
                print("Pilih Tanggal terlebih dahulu!");
              }
            }),
        TextField(
            controller: tgl_kembali,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Tanggal Pengembalian"),
            readOnly: true,
            onTap: () async {
              DateTime? kembaliDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));
              if (kembaliDate != null) {
                print(kembaliDate);
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(kembaliDate);
                print(formattedDate);
                setState(() {
                  tgl_kembali.text = formattedDate;
                });
              } else {
                print("Pilih Tanggal terlebih dahulu!");
              }
            }),
        RaisedButton(
            child: Text(
              "Yakin",
              style: TextStyle(color: Colors.black),
            ),
            color: Color.fromARGB(255, 0, 166, 255),
            onPressed: () {
              pinjam();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => IndexingPage(),
              ));
            }),
        RaisedButton(
            child: Text("Kembali", style: TextStyle(color: Colors.black)),
            color: Colors.green,
            onPressed: () => Navigator.pop(context))
      ],
    ));
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.list[widget.index]['judul_buku']}')),
      body: Container(
        height: 270,
        padding: EdgeInsets.all(15),
        child: Card(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 25)),
              Text(
                widget.list[widget.index]['judul_buku'],
                style: TextStyle(fontSize: 14),
              ),
              Text(
                widget.list[widget.index]['tahun_terbit'],
                style: TextStyle(fontSize: 14),
              ),
              Text(
                widget.list[widget.index]['tempat_terbit'],
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Barcode : ${widget.list[widget.index]['id_buku']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Pengarang : ${widget.list[widget.index]['pengarang']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Penerbit : ${widget.list[widget.index]['penerbit']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Rak : ${widget.list[widget.index]['rak']}",
                style: TextStyle(fontSize: 14),
              ),
              Padding(padding: const EdgeInsets.only(top: 25)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Pinjam"),
                    color: Colors.blue,
                    onPressed: () => confirm(),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
