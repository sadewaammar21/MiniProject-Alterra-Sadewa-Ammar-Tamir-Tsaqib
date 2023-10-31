import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/fetch.dart';
import 'package:newsapp/page/login/login_page.dart';
import 'package:newsapp/page/search_page.dart';
import 'package:newsapp/view/detail.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    // Daftar halaman yang dapat dipilih
    Text('Halaman Beranda'),
    Text('Halaman Pencarian'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
            (route) => false);
      }
    });
  }

  @override
  void initState() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text("Apakah Anda Yakin Ingin Keluar"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return ListView.builder(
            itemCount: newsProvider.posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  color: Colors.grey[200],
                  height: 100,
                  width: 100,
                  child: newsProvider.posts[index]["urlToImage"] != null
                      ? Image.network(
                          newsProvider.posts[index]["urlToImage"],
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Center(),
                ),
                title: Text(
                  "${newsProvider.posts[index]["title"]}",
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${newsProvider.posts[index]["description"]}",
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                onTap: () {
                  // Navigasi ke detail
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => Detail(
                        url: newsProvider.posts[index]['url'],
                        title: newsProvider.posts[index]['title'],
                        content: newsProvider.posts[index]['content'],
                        publishedAt: newsProvider.posts[index]['publishedAt'],
                        author: newsProvider.posts[index]['author'],
                        urlToImage: newsProvider.posts[index]['urlToImage'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
