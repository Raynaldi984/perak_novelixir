import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/book.dart'; // Import model untuk Book dan Chapter

class ContentPage extends StatefulWidget {
  final List<Chapter> chapters;
  final int currentChapterIndex;
  final String author;

  const ContentPage({
    Key? key,
    required this.chapters,
    required this.currentChapterIndex,
    required this.author,
  }) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isReading = false;

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleReadAloud(String text) async {
    if (isReading) {
      await _flutterTts.stop();
      setState(() {
        isReading = false;
      });
    } else {
      await _flutterTts.setSpeechRate(0.5); // Kecepatan membaca
      await _flutterTts.setPitch(1.0); // Nada suara
      await _flutterTts.setLanguage("en-US"); // Bahasa
      await _flutterTts.speak(text);
      setState(() {
        isReading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentChapter = widget.chapters[widget.currentChapterIndex];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(currentChapter.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size),
            onPressed: () {
              // Implement font size adjustment
            },
          ),
          IconButton(
            icon: Icon(isReading ? Icons.stop : Icons.volume_up),
            onPressed: () => _toggleReadAloud(currentChapter.content),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Implement additional options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentChapter.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: ${widget.author}",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Reads: ${currentChapter.reads}, Votes: ${currentChapter.votes}",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              currentChapter.content,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: widget.currentChapterIndex > 0
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(
                              chapters: widget.chapters,
                              currentChapterIndex:
                                  widget.currentChapterIndex - 1,
                              author: widget.author,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
              Text(
                'Chapter ${currentChapter.number} of ${widget.chapters.length}',
                style: TextStyle(color: Colors.grey[400]),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.white,
                onPressed:
                    widget.currentChapterIndex < widget.chapters.length - 1
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentPage(
                                  chapters: widget.chapters,
                                  currentChapterIndex:
                                      widget.currentChapterIndex + 1,
                                  author: widget.author,
                                ),
                              ),
                            );
                          }
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
