import 'package:LifeLines/components/card.dart';
import 'package:LifeLines/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});
  @override
  State<Notes> createState() => _NotesState();
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)} ...';
  }
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        final notes = model.notes;
        if (notes.isEmpty) {
          return const Center(child: Text('No notes available.'));
        }
        return Column(
            children: notes
                .map((data) => CustomCard(id: data['id'], data: data['data']))
                .toList());
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
            Container(padding: const EdgeInsets.all(5), child: const Notes()));
  }
}
