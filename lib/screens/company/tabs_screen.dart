import 'package:flutter/material.dart';
import 'package:reis_imovel_app/screens/company/announcement_screen.dart';
import 'package:reis_imovel_app/screens/company/contracts_screen.dart';
import 'package:reis_imovel_app/screens/company/scheduling_screen.dart';
import 'package:reis_imovel_app/screens/profile_screen.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class TabsScreenCompany extends StatefulWidget {
  const TabsScreenCompany({super.key});

  @override
  State<TabsScreenCompany> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreenCompany> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Anúncio',
        'screen': const AnnouncementScreen(),
      },
      {
        'title': 'Agendamentos',
        'screen': const SchedulingScreen(),
      },
      {
        'title': 'Contratos',
        'screen': const ContractsScreen(),
      },
      {
        'title': 'Perfil',
        'screen': const ProfileScreen(),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_selectedScreenIndex]['screen'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: whiteColor,
        unselectedItemColor: blackColor40,
        selectedItemColor: primaryColor,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontFamily: 'Avenir',
        ),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.auto_fix_high_sharp),
            ),
            label: 'Anúncio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.calendar_month_outlined),
            ),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.article_outlined),
            ),
            label: 'Contratos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.person_outline_sharp),
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
