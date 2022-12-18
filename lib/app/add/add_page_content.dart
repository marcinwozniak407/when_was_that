import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPageContent extends StatefulWidget {
  const AddPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPageContent> createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  var categoryOfEvent = '';
  var eventName = '';
  var comment = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (newValue) {
              setState(() {
                categoryOfEvent = newValue;
              });
            },
            decoration: InputDecoration(
              hintText: "category of event",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (newValue) {
              setState(() {
                eventName = newValue;
              });
            },
            decoration: InputDecoration(
              hintText: "name of event",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (newValue) {
              setState(() {
                comment = newValue;
              });
            },
            decoration: InputDecoration(
              hintText: "add a comment to this event if you want",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Slider(
            value: rating,
            onChanged: (newValue) {
              setState(() {
                rating = newValue;
              });
            },
            min: 1.0,
            max: 6.0,
            divisions: 10,
            label: rating.toString(),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('events').add({
                  'category': categoryOfEvent,
                  'name': eventName,
                  'comment': comment,
                  'rating': rating,
                });
              },
              child: const Text('Add event'),
            ),
          )
        ],
      ),
    );
  }
}
