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
              child: Card(
                color: Color.fromARGB(255, 221, 141, 208),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                    ),
                    Text(
                      "Judul Buku                  : ${list[index]["judul_buku"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "ID Buku              : ${list[index]["id_buku"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Tanggal Peminjaman   : ${list[index]["tgl_peminjaman"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Tanggal Pengembalian : ${list[index]["tgl_pengembalian"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
