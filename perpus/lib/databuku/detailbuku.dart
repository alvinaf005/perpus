import 'package:perpus/halamannavigasi/beranda.dart';
import 'package:flutter/material.dart';
import 'editdata.dart';
import 'package:http/http.dart' as http;

class DetailBuku extends StatefulWidget {
  List list;
  int index;
  DetailBuku({required this.index, required this.list});

  @override
  _DetailBukuState createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  void deleteData() {
    var url = Uri.parse('http://10.0.2.2/bukuperpus/deletedata.php');
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah anda yakin ingin menghapus file '${widget.list[widget.index]['judul_buku']}'"),
      actions: <Widget>[
        RaisedButton(
            child: Text(
              "Hapus",
              style: TextStyle(color: Colors.black),
            ),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: () {
              deleteData();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BerandaPage(),
              ));
            }),
        RaisedButton(
            child: Text("Kembali", style: TextStyle(color: Colors.black)),
            color: Colors.green,
            onPressed: () => Navigator.pop(context))
      ],
    );
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
                "Barcode : ${widget.list[widget.index]['id']}",
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
                    child: Text("EDIT"),
                    color: Colors.lightBlueAccent,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditData(
                        list: widget.list,
                        index: widget.index,
                      ),
                    )),
                  ),
                  RaisedButton(
                    child: Text("DELETE"),
                    color: Colors.red,
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
