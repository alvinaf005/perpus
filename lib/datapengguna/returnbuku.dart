import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'mobile.dart';

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
  String id_pengguna = "";
  String nama = "";
  String nim = "";
  String fakultas = "";
  String jurusan = "";
  String prodi = "";
  String domisili = "";
  String no_telp = "";
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id_pengguna = pref.getString("id_pengguna")!;
      nama = pref.getString("nama")!;
      nim = pref.getString("nim")!;
      fakultas = pref.getString("fakultas")!;
      jurusan = pref.getString("jurusan")!;
      prodi = pref.getString("prodi")!;
      domisili = pref.getString("domisili")!;
      no_telp = pref.getString("no_telp")!;
    });
  }

  @override
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
        content: Text(
            "Anda telat mengembalikan buku selama $difference hari\n"
            "Total Charge Rp $totalCharge",
            style: TextStyle(fontSize: 18)),
        actions: <Widget>[
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              textColor: Color(0xffffffff),
              child: Text("Bayar"),
              color: Color.fromARGB(255, 255, 0, 0),
              onPressed: () {
                deleteData();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IndexingPage();
                }));
              }),
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              textColor: Color(0xffffffff),
              child: Text("Kembali"),
              color: Colors.green,
              onPressed: () => Navigator.pop(context))
        ],
      );

      showDialog(builder: (context) => kenaCharge, context: context);
    } else {
      AlertDialog kenaCharge = AlertDialog(
        content: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Masih tersisa $difference hari \nuntuk mengembalikan buku, Apakah anda Yakin mengembalikan buku",
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: <Widget>[
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              textColor: Color(0xffffffff),
              child: Text("Yakin"),
              color: Color.fromARGB(255, 255, 0, 0),
              onPressed: () {
                deleteData();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => IndexingPage(),
                ));
              }),
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              textColor: Color(0xffffffff),
              child: Text("Kembali"),
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
        "Apakah anda yakin ingin mengembalikan '${widget.list[widget.index]['judul_buku']}'",
        style: TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textColor: Color(0xffffffff),
            child: Text("Yakin"),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: () {
              checkReturn();
            }),
        RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textColor: Color(0xffffffff),
            child: Text("Kembali"),
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
        height: 340,
        padding: EdgeInsets.all(15),
        child: Card(
          color: Color.fromARGB(255, 68, 227, 255),
          shadowColor: Color(0xff000000),
          elevation: 8,
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "Judul Buku",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "${widget.list[widget.index]['judul_buku']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "Barcode",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "${widget.list[widget.index]['id_buku']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "Tanggal Peminjaman",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "${widget.list[widget.index]['tgl_peminjaman']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "Tanggal Pengembalian",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Text(
                      "${widget.list[widget.index]['tgl_pengembalian']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      textColor: Color(0xffffffff),
                      child: Text(
                        "Kembalikan Buku",
                      ),
                      color: Color.fromARGB(255, 255, 118, 64),
                      onPressed: () => confirm(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ))),
                      child: Text('Cetak PDF'),
                      onPressed: _createPDF,
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 50;
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;

    page.graphics.drawString(
        'Peminjaman Buku ', PdfStandardFont(PdfFontFamily.helvetica, 24),
        bounds: Rect.fromLTWH(290, 0, 390, 130));
    page.graphics.drawString('Librarys Books',
        PdfStandardFont(PdfFontFamily.helvetica, 30, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(278, 34, 390, 130));
    page.graphics.drawString(
        'Jl.Babatan, Kel.Wiyung, Kota Surabaya, Jawa Timur',
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(180, 80, 0, 0));
    page.graphics.drawString(
        '______________________________________________________________________________',
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(0, 90, 0, 0));
    page.graphics.drawString(
        'Data Peminjam :', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(0, 120, 0, 0));
    page.graphics.drawString(
        '- Nama       : ${nama}', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 150, 0, 0));
    page.graphics.drawString(
        '- NIM          : ${nim}', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 180, 0, 0));
    page.graphics.drawString('- Fakultas     : ${fakultas}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 210, 0, 0));

    page.graphics.drawString('- Jurusan      : ${jurusan}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(400, 150, 0, 0));
    page.graphics.drawString('- Prodi        : ${prodi}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(400, 180, 0, 0));
    page.graphics.drawString('- Domisili     : ${domisili}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(400, 210, 0, 0));
    page.graphics.drawString('- No. Telp     : ${no_telp}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(400, 240, 0, 0));
    page.graphics.drawString(
        '______________________________________________________________________________',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(0, 260, 0, 0));
    page.graphics.drawString(
        'Data Buku', PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(0, 290, 0, 0));
    page.graphics.drawString(
        '- Barcode Buku           : ${widget.list[widget.index]['id_buku']}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 320, 0, 0));
    page.graphics.drawString(
        '- Judul Buku             : ${widget.list[widget.index]['judul_buku']}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 350, 0, 0));
    page.graphics.drawString(
        '- Tanggal Peminjaman     : ${widget.list[widget.index]['tgl_pengembalian']}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 380, 0, 0));

    page.graphics.drawString(
        '- Tanggal Pengembalian     : ${widget.list[widget.index]['tgl_pengembalian']}',
        PdfStandardFont(PdfFontFamily.helvetica, 20),
        bounds: Rect.fromLTWH(40, 410, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes,
        '${widget.list[widget.index]['judul_buku']}-${nama}-${widget.list[widget.index]['tgl_pengembalian']}.pdf');
  }
}
