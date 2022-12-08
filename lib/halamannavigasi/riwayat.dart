import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatPage extends StatefulWidget {
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  String nim = "";
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nim = pref.getString("nim")!;
      print(nim);
    });
  }

  Future<List> getdata() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2/bukuperpus/getriwayat.php"), body: {
      'nim': '${nim}',
    });
    print(nim);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 4,
              centerTitle: true,
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              title: const Text(
                "Riwayat ",
                // ignore: unnecessary_const
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Color(0xfff9f9f9),
                ),
              ),
            ),
            body: FutureBuilder<List>(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ItemList(
                        list: snapshot.data!,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailRiwayat(list: list, index: index))),
              child: Card(
                shadowColor: Color(0xff000000),
                elevation: 8,
                color: Color.fromARGB(255, 68, 227, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "${list[index]["judul_buku"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class DetailRiwayat extends StatefulWidget {
  List list;
  int index;
  DetailRiwayat({required this.index, required this.list});

  @override
  _DetailRiwayatState createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  void deleteData() {
    var url = Uri.parse('http://10.0.2.2/bukuperpus/pengembalianbuku.php');
    http.post(url, body: {'id_buku': widget.list[widget.index]['id_buku']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Riwayat : ${widget.list[widget.index]['judul_buku']}')),
      body: Container(
        height: 270,
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
            ],
          )),
        ),
      ),
    );
  }
}
