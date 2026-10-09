import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/features/auth/screen/login_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> list = [];




  @override
  void initState() {
    callEndpoint();
    super.initState();
  }

  Future<void> callEndpoint() async {
    var urlForTopHeadlines = Uri.https('newsapi.org', '/v2/top-headlines', {
      'apiKey': 'bfb87654ac474a14b20e54c7d4522c6a',
      'country': 'us',
    });

    final http.Response response = await http.get(urlForTopHeadlines);

    Map<String, dynamic> result =
        jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          list = result['articles'] as List<dynamic>;
        });

    ///print('Response from API: $result[totalResults]');









    final preferenceManager = PreferenceManager();

    final isLoggedIn = await preferenceManager.getBoolean('is_logged_in');

    if (!isLoggedIn) {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> logout() async {
    final preferenceManager = PreferenceManager();

    await preferenceManager.setBoolean('is_logged_in', false);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newst App'),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),

      body: Column(
        children: [
          Expanded(

            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final article = list.length > index ? list[index] : null;
                return ListTile(
                  title: Text(article?['title'] ?? 'No Title'),
                  subtitle: Text(article?['description'] ?? 'No Description'),
                );
              },
            ),
          ),
        ],
      ),
   /*
      const Center(
        child: Text(
          'Welcome to Newst App!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),  */
    );
  }
}
