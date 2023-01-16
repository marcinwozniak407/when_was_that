import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:when_was_that/app/events/cubit/events_cubit.dart';
import 'package:when_was_that/app/search/search.dart';

class EventsPageContent extends StatelessWidget {
  const EventsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit()..start(),
      child: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text("Something went wrong: ${state.errorMessage}"),
            );
          }
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = state.documents;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Events"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: MySearchDelegate());
                  },
                )
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              children: [
                for (final document in documents)
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('events')
                          .doc(document.id)
                          .delete();
                    },
                    background: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 32.0),
                            child: Icon(Icons.delete),
                          )),
                    ),
                    direction: DismissDirection.endToStart,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[300],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(document['category'].toUpperCase(),
                                style: GoogleFonts.roboto(
                                    fontSize: 15, color: Colors.black)),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white70),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      document['name'],
                                      style: GoogleFonts.robotoCondensed(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        document['rating'].toStringAsFixed(0),
                                        style: GoogleFonts.robotoSlab(
                                            fontSize: 25, color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            Text(document['date'].toString(),
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 15, color: Colors.black)),
                            if (document['comment'].isNotEmpty)
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white70),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(5),
                                child: Text(document['comment'].toString(),
                                    style: GoogleFonts.greatVibes(
                                      fontSize: 25,
                                      color: Colors.black,
                                    )),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
