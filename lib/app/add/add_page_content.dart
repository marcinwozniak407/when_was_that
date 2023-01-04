import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:when_was_that/app/events/events_page_content.dart';

class AddPageContent extends StatefulWidget {
  const AddPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddPageContent> createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  var categoryOfEvent = '';
  var eventName = '';
  var comment = '';
  var rating = 3.0;
  final items = ['film', 'performance', 'exhibition', 'concert', 'show'];
  String? value;

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            firstDate: DateTime(1990),
            lastDate: DateTime(2100))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => this.value = value),
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
                maxLength: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _dateTime.toString().substring(0, 10),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _showDatePicker,
                child: const Text(
                  'Choose date of event',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Rate this event:'),
              Slider(
                value: rating,
                onChanged: (newValue) {
                  setState(() {
                    rating = newValue;
                  });
                },
                min: 1.0,
                max: 10.0,
                divisions: 9,
                label: rating.toStringAsFixed(0),
              ),
              const SizedBox(height: 10),
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
                maxLength: 100,
              ),
              const SizedBox(height: 20),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: categoryOfEvent.isEmpty || eventName.isEmpty
                      ? null
                      : () {
                          FirebaseFirestore.instance.collection('events').add({
                            'category': categoryOfEvent,
                            'name': eventName,
                            'comment': comment,
                            'rating': rating,
                            'date': _dateTime.toString().substring(0, 10),
                          });
                          widget.onSave();
                        },
                  child: const Text(
                    'Add event',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
