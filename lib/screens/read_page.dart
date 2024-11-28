import 'package:flutter/material.dart';
import '../models/book.dart'; // Import model untuk Book dan Chapter
import 'content_page.dart'; // Import halaman konten

class ReadPage extends StatelessWidget {
  final List<Chapter> chapters;
  final int currentChapterIndex;
  final String bookTitle; // Menggunakan judul buku yang dinamis
  final String author;
  final String coverUrl;

  const ReadPage({
    Key? key,
    required this.chapters,
    required this.currentChapterIndex,
    required this.bookTitle,
    required this.author,
    required this.coverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChapter = chapters[currentChapterIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          bookTitle, // Menampilkan judul buku secara dinamis
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Header dengan Cover Buku
            Container(
              color: Colors.grey[800],
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      coverUrl,
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          width: 80,
                          height: 120,
                          child: const Icon(Icons.broken_image,
                              color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookTitle, // Menggunakan judul buku
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "By $author",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.visibility,
                                size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              "${currentChapter.reads} Reads",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.star,
                                size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              "${currentChapter.votes} Votes",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bagian Deskripsi Singkat Buku (Statis)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi Singkat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Ini adalah cerita tentang perjalanan hidup yang penuh tantangan, cinta, dan pengorbanan. Buku ini akan membawa Anda ke dalam dunia yang penuh makna dan emosi mendalam.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Start Reading
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman konten dengan chapter pertama
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(
                              chapters: chapters,
                              currentChapterIndex:
                                  0, // Mulai dari chapter pertama
                              author: author,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Start Reading',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            // Bagian List Chapter
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chapters",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      return ListTile(
                        title: Text(
                          "Chapter ${chapter.number}: ${chapter.title}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "Updated on ${chapter.updatedAt}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Icon(
                          index == currentChapterIndex
                              ? Icons.arrow_forward
                              : Icons.lock_open,
                          color: index == currentChapterIndex
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onTap: () {
                          if (index != currentChapterIndex) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentPage(
                                  chapters: chapters,
                                  currentChapterIndex: index,
                                  author: author,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[850],
        child: const SizedBox
            .shrink(), // Empty widget to remove the bottom navigation bar
      ),
    );
  }
}
