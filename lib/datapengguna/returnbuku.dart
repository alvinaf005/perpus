import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../halamannavigasi/indexing.dart';

class ReturnBuku extends StatefulWidget {
  List list;
  int index;
  ReturnBuku({required this.index, required this.list});

  @override
  _ReturnBukuState createState() => _ReturnBukuState();
}

class _ReturnBukuState extends State<ReturnBuku> {
  void deleteData() {
    var url = Uri.parse('http://10.0.2.2/bukuperpus/pengembalianbuku.php');
    http.post(url, body: {'id_buku': widget.list[widget.index]['id_buku']});
  }

  void checkReturn() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    final dt2 =
        DateTime.parse("${widget.list[widget.index]['tgl_pengembalian']}");
    final dt1 = DateTime.now();
    final difference = daysBetween(dt2, dt1);

    final chargeHarga = 10000;
    final totalCharge = chargeHarga * difference;
    if (dt1.compareTo(dt2) > 0) {
      AlertDialog kenaCharge = AlertDialog(
        content: Text("Anda telat mengembalikan buku selama $difference hari\n"
            "Total Charge Rp $totalCharge"),
        actions: <Widget>[
          RaisedButton(
              child: Text("Bayar"),
              onPressed: () {
                deleteData();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IndexingPage();
                }));
              }),
          RaisedButton(
              child: Text("Kembali", style: TextStyle(color: Colors.black)),
              color: Colors.green,
              onPressed: () => Navigator.pop(context))
        ],
      );

      showDialog(builder: (context) => kenaCharge, context: context);
    } else {
      AlertDialog kenaCharge = AlertDialog(
        content: Text(
            "Masih tersisa $difference hari untuk mengembalikan buku, Apakah anda Yakin mengembalikan buku"),
        actions: <Widget>[
          RaisedButton(
              child: Text("Yakin"),
              onPressed: () {
                deleteData();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => IndexingPage(),
                ));
              }),
          RaisedButton(
              child: Text("Kembali", style: TextStyle(color: Colors.black)),
              color: Colors.green,
              onPressed: () => Navigator.pop(context))
        ],
      );
      showDialog(builder: (context) => kenaCharge, context: context);
    }
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah anda yakin ingin mengembalikan '${widget.list[widget.index]['judul_buku']}'"),
      actions: <Widget>[
        RaisedButton(
            child: Text(
              "Yakin",
              style: TextStyle(color: Colors.black),
            ),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: () {
              checkReturn();
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
                widget.list[widget.index]['id_buku'],
                style: TextStyle(fontSize: 14),
              ),
              Padding(padding: const EdgeInsets.only(top: 25)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Kembalikan Buku"),
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
