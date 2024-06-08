import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:reis_imovel_app/screens/explore_screen.dart';
import 'package:reis_imovel_app/screens/favorite_screen.dart';
import 'package:reis_imovel_app/screens/home_screen.dart';
import 'package:reis_imovel_app/screens/profile_screen.dart';
import 'package:reis_imovel_app/screens/reservation_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Home', 'screen': const HomeScreen()},
      {'title': 'Explorar', 'screen': const ExploreScreen()},
      {'title': 'Reservas', 'screen': const ReservationScreen()},
      // {'title': 'Favoritos', 'screen': FavoriteScreen()},
      {'title': 'Perfil', 'screen': const ProfileScreen()},
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  TextStyle getSalomonBottomBarItemTextStyle() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectedScreenIndex]['title'] as String),
      // ),
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   elevation: 0,
      //   flexibleSpace: AppBarGeneric(),
      // ),
      body: SafeArea(child: _screens[_selectedScreenIndex]['screen'] as Widget),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedScreenIndex,
        onTap: (i) => setState(() => _selectedScreenIndex = i),
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        unselectedItemColor: const Color(0xFF687553),
        items: [
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.house, size: 24),
            title: Text("Home", style: getSalomonBottomBarItemTextStyle()),
            selectedColor: const Color(0xFF687553),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 24),
            title: Text("Explorar", style: getSalomonBottomBarItemTextStyle()),
            selectedColor: const Color(0xFF687553),
          ),
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.fileInvoice, size: 24),
            title: Text("Reservas", style: getSalomonBottomBarItemTextStyle()),
            selectedColor: const Color(0xFF687553),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const FaIcon(FontAwesomeIcons.user, size: 24),
            title: Text("Perfil", style: getSalomonBottomBarItemTextStyle()),
            selectedColor: const Color(0xFF687553),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectScreen,
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   unselectedItemColor: Theme.of(context).colorScheme.primary,
      //   selectedItemColor: const Color(0xFF2486F9),
      //   currentIndex: _selectedScreenIndex,
      //   type: BottomNavigationBarType.shifting,
      //   items: [
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).colorScheme.secondary,
      //       icon: Icon(Icons.home),
      //       label: 'Home'
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).colorScheme.secondary,
      //       icon: Icon(Icons.search),
      //       label: 'Explorar'
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).colorScheme.secondary,
      //       icon: Icon(Icons.list),
      //       label: 'Reservas'
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).colorScheme.secondary,
      //       icon: Icon(Icons.favorite),
      //       label: 'Favoritos'
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).colorScheme.secondary,
      //       icon: Icon(Icons.account_circle_outlined),
      //       label: 'Perfil'
      //     ),
      //   ],
      // ),
    );
  }
}
