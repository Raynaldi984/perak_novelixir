import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/search.dart';
import 'screens/write.dart';
import 'screens/library.dart';
import 'screens/profile.dart';
import 'widgets/bottom_nav_bar.dart'; // Impor BottomNavBar

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
  bool _isLoggedIn = true; // Status login, misalnya true setelah login

  final List<Widget> _pages = [
    Home(),
    const SearchPage(),
    const WritePage(),
    const LibraryPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novelixir'),
      ),
      body: _isLoggedIn
          ? _pages[_selectedIndex]
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _isLoggedIn
          ? BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
          : null, // Menampilkan navbar hanya jika login
    );
  }
}
