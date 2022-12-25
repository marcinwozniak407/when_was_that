import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPageContent extends StatelessWidget {
  const ListPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong..."),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading...'),
            );
          }

          final documents = snapshot.data!.docs;
          return ListView(
            children: [
              for (final document in documents) ...[
                Text(document['category'].toUpperCase()),
                Text(document['name']),
                Text(document['date'].toString()),
                Text(document['comment']),
                Text(document['rating'].toString()),
              ],
            ],
          );
        });
  }
}
