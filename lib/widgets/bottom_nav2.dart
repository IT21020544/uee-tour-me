// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/pages/souvenir/payment/paymentHistory.dart';
import 'package:tour_me/pages/souvenir/souvenirShopAdd.dart';

class BottomNav2 extends StatelessWidget {
  final Selections selected;
  static const List<Selections> _selectionList = [
    Selections.home,
    Selections.add,
    Selections.payments,
  ];
  const BottomNav2({
    Key? key,
    this.selected = Selections.home,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
      selectedIndex: _selectionList.indexOf(selected),
      rippleColor: const Color(0xFFFF5A6E),
      hoverColor: const Color(0xFFFF5A6E),
      haptic: true,
      tabBorderRadius: 15,
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 400),
      gap: 5,
      color: const Color.fromARGB(255, 255, 255, 255),
      activeColor: const Color.fromARGB(255, 255, 255, 255),
      iconSize: 32,
      tabBackgroundColor: const Color(0xFFFF5A6E),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      tabs: [
        GButton(
          icon: Icons.home,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          text: 'Home',
          onPressed: () => _navigateToHomePage(context),
        ),
        GButton(
          icon: Icons.add_circle,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          text: 'Add',
          onPressed: () => _navigateToAddPage(context),
        ),
        GButton(
          icon: Icons.payment,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          text: 'Payment',
          onPressed: () => _navigateToPaymentHistory(context),
        ),
      ],
    );
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SouvenirAddPage(),
    ));
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SouvenirHomePage(),
    ));
  }

  void _navigateToPaymentHistory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentHistory(),
    ));
  }
}

enum Selections {
  home,
  add,
  payments,
}
