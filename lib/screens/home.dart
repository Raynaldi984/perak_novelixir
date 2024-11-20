import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Book>> _futureBooks;

  @override
  void initState() {
    super.initState();
    _futureBooks = fetchBooks();
  }

  static Future<List<Book>> fetchBooks() async {
    // Simulasi data buku dengan chapters
    return [
      Book(
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        coverUrl: 'https://covers.openlibrary.org/b/id/8225261-L.jpg',
        chapters: [
          Chapter(
            number: 1,
            title: 'Chapter 1: The Beginning',
            content: 'When he was nearly thirteen, my brother Jem got his arm badly broken at the elbow...',
            reads: 1500,
            votes: 350,
          ),
          Chapter(
            number: 2,
            title: 'Chapter 2: School Days',
            content: 'The next morning I awoke to find that summer had turned to autumn overnight...',
            reads: 1200,
            votes: 280,
          ),
        ],
      ),
      Book(
        title: '1984',
        author: 'George Orwell',
        coverUrl: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
        chapters: [
          Chapter(
            number: 1,
            title: 'Chapter 1: Big Brother',
            content: 'It was a bright cold day in April, and the clocks were striking thirteen...',
            reads: 2000,
            votes: 450,
          ),
          Chapter(
            number: 2,
            title: 'Chapter 2: The Party',
            content: 'Winston picked his way up the lane through dappled light and shade...',
            reads: 1800,
            votes: 400,
          ),
        ],
      ),
      Book(
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        coverUrl: 'https://covers.openlibrary.org/b/id/7359398-L.jpg',
        chapters: [
          Chapter(
            number: 1,
            title: 'Chapter 1: The Introduction',
            content: 'In my younger and more vulnerable years my father gave me some advice...',
            reads: 2500,
            votes: 600,
          ),
          Chapter(
            number: 2,
            title: 'Chapter 2: The Party',
            content: 'About halfway between West Egg and New York...',
            reads: 2200,
            votes: 550,
          ),
        ],
      ),
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        coverUrl: 'https://covers.openlibrary.org/b/id/8225231-L.jpg',
        chapters: [
          Chapter(
            number: 1,
            title: 'Chapter 1: A Truth Universally Acknowledged',
            content: 'It is a truth universally acknowledged, that a single man in possession of a good fortune...',
            reads: 3000,
            votes: 750,
          ),
          Chapter(
            number: 2,
            title: 'Chapter 2: The Bennets',
            content: 'Mr. Bennet was among the earliest of those who waited on Mr. Bingley...',
            reads: 2800,
            votes: 700,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Row(
                children: [
                  Image.network(
                    'https://www.wattpad.com/img/logo.png',
                    height: 30,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ],
              ),
              backgroundColor: Colors.grey[850],
            ),
            SliverToBoxAdapter(child: _buildFeaturedStory()),
            SliverToBoxAdapter(child: _buildTrendingSection()),
            SliverToBoxAdapter(child: _buildStoriesForYouSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedStory() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://via.placeholder.com/400x200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Featured Story',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'By Author Name',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Trending Stories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Book>>(
          future: _futureBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildSkeletonLoader();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final books = snapshot.data!;
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: BookCard(
                        title: book.title,
                        author: book.author,
                        coverUrl: book.coverUrl,
                        chapters: book.chapters,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildStoriesForYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Stories for You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Book>>(
          future: _futureBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildSkeletonLoader();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final books = snapshot.data!;
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: BookCard(
                        title: book.title,
                        author: book.author,
                        coverUrl: book.coverUrl,
                        chapters: book.chapters,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildSkeletonLoader() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 150,
              height: 200,
              color: Colors.grey[800],
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
