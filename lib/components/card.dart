import 'package:LifeLines/components/notedialog.dart';
import 'package:LifeLines/components/reaction.dart';
import 'package:LifeLines/pages/home.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const CustomCard({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      NoteDialog(id: id, data: data),
                ),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF404249),
                      Color(0xFF404249),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Text(data['title'],
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    // const SizedBox(height: 20),
                    // Text('Created',
                    //     style: Theme.of(context).textTheme.displaySmall),
                    // const SizedBox(height: 7),
                    // Container(
                    //   width: 185,
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.white),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       const Icon(
                    //         Icons.calendar_today_rounded,
                    //         color: Colors.white,
                    //       ),
                    //       const SizedBox(width: 5),
                    //       Text(data['date'].toString().substring(0, 12),
                    //           style: Theme.of(context).textTheme.displaySmall),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(truncateText(data['text'], 60),
                          style: Theme.of(context).textTheme.displaySmall),
                    ),

                    Container(
                        width: 45,
                        height: 35,
                        decoration: BoxDecoration(
                            color: const Color(0xFF313338),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: MyReaction(id: id, data: data))
                  ],
                ))));
  }
}
