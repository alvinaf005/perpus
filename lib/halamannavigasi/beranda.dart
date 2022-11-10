import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:perpus/halamannavigasi/indexing.dart';
import 'package:perpus/DataBuku/detailbuku.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with AutomaticKeepAliveClientMixin {
  Future<List> getdata() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2/bukuperpus/getdata.php'));
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
              backgroundColor: const Color(0xff3a57e8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              title: const Text(
                "Beranda",
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
                      DetailBuku(list: list, index: index))),
              child: Card(
                  child: ListTile(
                title: Text(list[index]["judul_buku"]),
                leading: Icon(Icons.book),
                subtitle: Text("${list[index]['pengarang']}"),
              )),
            ));
      },
    );
  }
}
