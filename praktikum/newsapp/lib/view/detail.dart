import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String? url;
  final String? title;
  final String? content;
  final String? publishedAt;
  final String? author;
  final urlToImage;

  Detail(
      {this.url,
      this.title,
      this.content,
      this.publishedAt,
      this.author,
      this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          urlToImage != null
              ? Image.network(urlToImage)
              : Container(
                  height: 250,
                  color: Colors.grey[200],
                ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  publishedAt ?? 'No Date',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(content ?? 'No Content'),
                const Divider(),
                const Text("Author:"),
                Text(author ?? 'No Author'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
