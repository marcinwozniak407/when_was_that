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

          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            children: [
              for (final document in documents)
                Padding(
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
                          child: Text(
                            document['name'],
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(document['date'].toString(),
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 15, color: Colors.black)),
                        Container(
                          decoration:
                              const BoxDecoration(color: Colors.white70),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(5),
                          child: Text(document['comment'],
                              style: GoogleFonts.greatVibes(
                                fontSize: 25,
                                color: Colors.black,
                              )),
                        ),
                        Text(document['rating'].toString(),
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
