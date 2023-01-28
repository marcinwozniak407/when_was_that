import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } //close searchbar
              else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');

          final results =
              snapshot.data?.docs.where((a) => a['name'].contains(query));

          return ListView(
            children: results!.map<Widget>((a) => Text(a['name'])).toList(),
          );
        });
  }
}
