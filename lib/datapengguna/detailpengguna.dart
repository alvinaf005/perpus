import 'package:perpus/halamannavigasi/beranda.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPengguna extends StatefulWidget {
  List list;
  int index;
  DetailPengguna({required this.index, required this.list});

  @override
  _DetailPenggunaState createState() => _DetailPenggunaState();
}

class _DetailPenggunaState extends State<DetailPengguna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff3a57e8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xfff9f9f9),
          ),
        ),
      ),
      body: Container(
        height: 270,
        padding: EdgeInsets.all(15),
        child: Card(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 25)),
              Text(
                "Nama : ${widget.list[widget.index]['nama']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "NIM : ${widget.list[widget.index]['nim']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Fakultas : ${widget.list[widget.index]['fakultas']}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Program Studi : ${widget.list[widget.index]['prodi']}",
                style: TextStyle(fontSize: 14),
              ),
              Padding(padding: const EdgeInsets.only(top: 25)),
            ],
          )),
        ),
      ),
    );
  }
}
