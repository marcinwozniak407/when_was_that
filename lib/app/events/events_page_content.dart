import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:when_was_that/app/events/cubit/events_cubit.dart';

class EventsPageContent extends StatelessWidget {
  const EventsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(),
      child: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
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
                    child: CircularProgressIndicator(),
                  );
                }

                final documents = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Container(
                    height: 140,
                    decoration: const BoxDecoration(color: Colors.green),
                    margin: const EdgeInsets.all(10),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      children: [
                        for (final document in documents) ...[
                          Text(document['category'].toUpperCase(),
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.white)),
                          Text(document['name'],
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 18, color: Colors.white)),
                          Text(document['date'].toString(),
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 15, color: Colors.white)),
                          Text(document['comment'],
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 15, color: Colors.white)),
                          Text(document['rating'].toString(),
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 15, color: Colors.white)),
                        ],
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
