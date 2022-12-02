import '../datapengguna/masukpage.dart';
import 'package:flutter/material.dart';
import '../halamannavigasi/beranda.dart';
import '../halamannavigasi/riwayat.dart';
import '../halamannavigasi/return.dart';
import '../halamannavigasi/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexingPage extends StatefulWidget {
  @override
  _IndexingPageState createState() => _IndexingPageState();
}

class _IndexingPageState extends State<IndexingPage> {
  String id_pengguna = "";
  String nama = "";
  String nim = "";
  String fakultas = "";
  String jurusan = "";
  String prodi = "";
  String domisili = "";
  String no_telp = "";
  int _currentIndex = 0;

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

  final List<Widget> _children = [
    BerandaPage(),
    RiwayatPage(),
    ReturnPage(),
    ProfilePage(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        backgroundColor: const Color(0xffffffff),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "Riwayat",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.wifi_protected_setup), label: "Return"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: "Profile"),
          ],
          backgroundColor: const Color(0xffffffff),
          currentIndex: _currentIndex,
          elevation: 8,
          iconSize: 24,
          selectedItemColor: const Color(0xff3a57e8),
          unselectedItemColor: const Color(0xff9e9e9e),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTabTapped,
        ));
  }
}
