import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:perpus/dataadmin/adddata.dart';
import 'package:perpus/datapengguna/masukpage.dart';
import 'package:perpus/dataadmin/detailbuku.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future<List> getdata() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2/bukuperpus/getdata.php'));
    print(response.body);
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
                "Pengelola Buku (Admin)",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Color(0xfff9f9f9),
                ),
              ),
              actions: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MasukPage()),
                            (route) => false);
                      },
                      icon: Icon(Icons.logout,
                          color: Color(0xffffffff), size: 26),
                      label: Text(""),
                    )),
              ],
            ),
            floatingActionButton: new FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new AddData(),
              )),
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
                title: Text(
                    "${list[index]["judul_buku"]}   ( ${list[index]['pinjam']} )"),
                leading: Icon(Icons.book),
                subtitle: Text("${list[index]['pengarang']} "),
              )),
            ));
      },
    );
  }
}
