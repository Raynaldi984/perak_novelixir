import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);
  static Future<List<Map<String, String>>> fetchBooks() async {
    return [
      {
        'title': 'To Kill a Mockingbird',
        'author': 'Harper Lee',
        'coverUrl': 'https://covers.openlibrary.org/b/id/8225261-L.jpg',
      },
      {
        'title': '1984',
        'author': 'George Orwell',
        'coverUrl': 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      },
      {
        'title': 'The Great Gatsby',
        'author': 'F. Scott Fitzgerald',
        'coverUrl': 'https://covers.openlibrary.org/b/id/7359398-L.jpg',
      },
      {
        'title': 'Moby Dick',
        'author': 'Herman Melville',
        'coverUrl': 'https://covers.openlibrary.org/b/id/8109476-L.jpg',
      },
      {
        'title': 'Pride and Prejudice',
        'author': 'Jane Austen',
        'coverUrl': 'https://covers.openlibrary.org/b/id/8225231-L.jpg',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Library'),
          backgroundColor: Colors.grey[850],
          bottom: _buildTabBar(),
        ),
        body: _buildTabBarView(),
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(text: 'Current Reads'),
        Tab(text: 'Archive'),
        Tab(text: 'Reading Lists'),
      ],
      indicatorColor: Colors.orange,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        _buildLibraryFuture(),
        _buildLibraryFuture(),
        _buildLibraryFuture(),
      ],
    );
  }

  Widget _buildLibraryFuture() {
    return FutureBuilder<List<Map<String, String>>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Error loading books',
                  style: TextStyle(color: Colors.white)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No books available',
                  style: TextStyle(color: Colors.white)));
        }
        final books = snapshot.data!;
        return _buildLibraryGrid(books);
      },
    );
  }

  Widget _buildLibraryGrid(List<Map<String, String>> books) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book['coverUrl']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book['author']!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
