import 'package:flutter/material.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/pages/history_page.dart';
import 'package:tto_apps/pages/list_exit_form_page.dart';
import 'package:tto_apps/widgets/bottom_navbar/tab_item.dart';

class LayoutPage extends StatefulWidget {
  LayoutPage({
    super.key,
    required this.child,
    required this.index,
  });

  Widget? child;
  int? index;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  Widget body(BuildContext context2) {
    print('context 2  ' + context2.toString());
    switch (widget.index) {
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
          currentIndex: widget.index!,
          backgroundColor: eerieBlack,
          unselectedItemColor: culturedWhite,
          selectedItemColor: orangeAccent,
          onTap: (value) {
            setState(() {
              widget.index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.description,
              ),
              label: 'Exit Form',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
