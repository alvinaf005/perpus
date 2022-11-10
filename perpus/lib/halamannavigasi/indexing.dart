import 'package:flutter/material.dart';
import 'package:perpus/DataBuku/detailbuku.dart';
import 'package:perpus/halamannavigasi/beranda.dart';
import 'package:perpus/halamannavigasi/riwayat.dart';
import 'package:perpus/halamannavigasi/return.dart';
import 'package:perpus/halamannavigasi/profile.dart';
import 'package:perpus/DataBuku/adddata.dart';

class IndexingPage extends StatefulWidget {
  const IndexingPage({Key? key}) : super(key: key);
  @override
  _IndexingPageState createState() => _IndexingPageState();
}

class _IndexingPageState extends State<IndexingPage> {
  int _currentIndex = 0;
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

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              leading: Text("$index"), title: Text("Number $index"));
        },
      ),
    );
  }
}
