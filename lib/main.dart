import 'package:perak_novelixir/screens/profile.dart';
import 'package:flutter/material.dart';
// Pastikan halaman loading ada
// Impor halaman Home
import 'screens/home.dart';
import 'screens/search.dart'; // Impor halaman Search
import 'screens/write.dart'; // Impor halaman Write
import 'screens/library.dart'; // Impor halaman Library
// Impor halaman Profile

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
  List<Widget>? _pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pages == null) {
      _pages = [
        Home(), // Ganti dengan widget dari home.dart
        const SearchPage(),
        const WritePage(),
        const LibraryPage(),
        Profile(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pages == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: _pages![_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[850],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Write'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
