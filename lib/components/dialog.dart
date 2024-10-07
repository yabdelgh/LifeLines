import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd MMM yyyy \'a\' HH:mm:ss');
  final String formattedDate = formatter.format(dateTime);

  // Manually append timezone offset
  final int offset = dateTime.timeZoneOffset.inHours;
  final String timezone = offset >= 0 ? 'UTC+$offset' : 'UTC$offset';

  return '$formattedDate $timezone';
}

// DatabaseReference ref = FirebaseDatabase.instance.ref('/notes');
final db = FirebaseFirestore.instance;

void create(title, text) async {
  final note = <String, dynamic>{
    "title": title,
    "text": text,
    "date": formatDateTime(DateTime.now()),
    'createdAt': FieldValue.serverTimestamp()
  };
  db.collection('/users/1NgXnWc4PagpCvRh7LFxoFrByMd2/notes').add(note).then(
      (DocumentReference doc) =>
          debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
}

void delete(id) async {
  db
      .collection('/users/1NgXnWc4PagpCvRh7LFxoFrByMd2/notes')
      .doc(id)
      .delete()
      .then(
        (doc) => debugPrint("Document deleted"),
        onError: (e) => debugPrint("Error updating document $e"),
      );
}

void update(id, data) async {
  db
      .collection('/users/1NgXnWc4PagpCvRh7LFxoFrByMd2/notes')
      .doc(id)
      .update(data)
      .then(
        (doc) => debugPrint("Document deleted"),
        onError: (e) => debugPrint("Error updating document $e"),
      );
}

class _NoteFormState extends State<NoteForm> {
  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Container(
        color: const Color(0xFF313338),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark),
                        color: const Color(0xFFFFFFFF),
                        // iconSize: 20,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'New note',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF5865F2),
                          // backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          create(title, text);
                        },
                        child: const Text('save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onChanged: (newValue) => {title = newValue},
                    style: Theme.of(context).textTheme.displaySmall,
                    cursorColor: Colors.white54,
                    decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(18),
                        fillColor: Color(0xFF404249),
                        filled: true,
                        border: OutlineInputBorder(
                          // color: Colors.white,
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF404249),
                          // border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      height: 300,
                      child: TextFormField(
                    style: Theme.of(context).textTheme.displaySmall,
                    cursorColor: Colors.white54,
                        onChanged: (newValue) => {text = newValue},
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Text',
                            contentPadding: EdgeInsets.all(18),
                            fillColor: Color(0xFF404249),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
