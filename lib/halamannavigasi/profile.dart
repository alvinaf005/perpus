import '../datapengguna/masukpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 4,
              centerTitle: true,
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              title: Text(
                "Data Diri",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Color(0xfff9f9f9),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  child: Center(
                child: Column(children: [
                  Text("Nama : ${nama} "),
                  Text("NIM : ${nim} "),
                  Text("Fakultas : ${fakultas} "),
                  Text("Jurusan : ${jurusan} "),
                  Text("Program Studi : ${prodi} "),
                  Text("Domisili : ${domisili} "),
                  Text("No. : ${no_telp} "),
                  OutlinedButton.icon(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MasukPage()),
                          (route) => false);
                    },
                    icon: Icon(Icons.login),
                    label: Text("Keluar"),
                  )
                ]),
              )),
            )));
  }
}
