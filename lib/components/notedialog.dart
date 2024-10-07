import 'package:LifeLines/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteDialog extends StatelessWidget {
  final String id;
  final Map<String, dynamic> data;
  const NoteDialog({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: const Color(0xFF313338),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                // height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['title'],
                      style: Theme.of(context).textTheme.displayLarge
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Created',
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.calendar_today_rounded, color: Color(0xFFFFFFFF),),
                          Text(
                            data['createdAt'].toString().substring(0, 12),
                            style: Theme.of(context).textTheme.displaySmall
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: 300,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SingleChildScrollView(
                        child: Text(
                          data['text'],
                            style: Theme.of(context).textTheme.displaySmall
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // const Icon(Icons.face),
                        const Spacer(),
                        IconButton(
                            onPressed: () =>
                                {Navigator.pop(context), delete(id)},
                            icon: const Icon(FontAwesomeIcons.trash, color: Color(0xFFFFFFFF),))
                        // TextButton(onPressed: () {}, child: Text('Delete'))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
