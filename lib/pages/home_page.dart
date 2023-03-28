import 'package:flutter/material.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/pages/history_page.dart';
import 'package:tto_apps/pages/list_exit_form_page.dart';
import 'package:tto_apps/widgets/layout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Widget body(BuildContext context2) {
    print('context 2  ' + context2.toString());
    switch (selectedIndex) {
      case 0:
        return ListExitFormPage(
          context2: context2,
        );
      case 1:
        return Builder(builder: (context) {
          return HistoryPage();
        });
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: eerieBlack,
          unselectedItemColor: culturedWhite,
          selectedItemColor: orangeAccent,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.description,
              ),
              label: 'Surat Izin',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'Transaksi Selesai',
            ),
          ],
        ),
      ),
    );
  }
}
