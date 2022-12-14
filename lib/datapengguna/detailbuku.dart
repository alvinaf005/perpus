import 'package:perpus/halamannavigasi/indexing.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "Apakah anda yakin ingin meminjam :",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "Nama             : ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "${nama}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "NIM                : ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "${nim}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "Jurusan         : ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "${jurusan}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "Judul Buku    : ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "${widget.list[widget.index]['judul_buku']}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "ID Buku          : ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  "${widget.list[widget.index]['id_buku']}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  "Kembali",
                ),
                color: Colors.green,
                onPressed: () => Navigator.pop(context),
                textColor: Color(0xffffffff),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  "Yakin",
                ),
                color: Colors.blue,
                onPressed: () {
                  pinjam();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => IndexingPage(),
                  ));
                },
                textColor: Color(0xffffffff),
              ),
            ),
          ],
        ),
      ],
    ));
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Detail Buku",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xfff9f9f9),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(4.0),
                  color: Color.fromARGB(255, 68, 227, 255),
                  shadowColor: Color(0xff000000),
                  elevation: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Judul Buku       : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['judul_buku']}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Tahun Terbit     : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['tahun_terbit']}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Tempat Terbit  : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['tempat_terbit']}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Barcode            : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['id_buku']}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Pengarang        : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['pengarang']}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Text(
                              "Rak                    : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Text(
                              "${widget.list[widget.index]['rak']}",
                              style: TextStyle(
                                fontSize: 18,
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
                              child: Text(
                                "Pinjam",
                              ),
                              color: Color.fromARGB(255, 255, 118, 64),
                              onPressed: () => confirm(),
                              textColor: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
