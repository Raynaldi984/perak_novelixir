import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for stories or people',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (query) {
// Implement search logic here
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildRecentSearchItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://via.placeholder.com/50x50',
        ),
      ),
      title: Text(
        'Recent Search ${index + 1}',
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Author ${index + 1}',
        style: TextStyle(color: Colors.grey[400]),
      ),
      onTap: () {
// Navigate to detailed view or search result page
      },
    );
  }
}
