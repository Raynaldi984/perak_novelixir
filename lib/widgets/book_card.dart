import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/read_page.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final List<Chapter> chapters;

  const BookCard({
    Key? key,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.chapters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (chapters.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReadPage(
                chapters: chapters,
                currentChapterIndex: 0,
                author: author,
                coverUrl: coverUrl,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        width: 120,
        height: 200,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCoverImage(),
          _buildBookInfo(),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return Expanded(
      flex: 4,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Image.network(
          coverUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildImageError(),
        ),
      ),
    );
  }

  Widget _buildImageError() {
    return Container(
      color: Colors.grey[700],
      child: const Center(
        child: Icon(
          Icons.broken_image,
          color: Colors.grey,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 2),
            _buildAuthor(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAuthor() {
    return Text(
      author,
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: 11,
        height: 1.2,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
