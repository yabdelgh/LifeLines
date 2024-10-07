import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const reactionsList = {
  'love': Icon(Icons.favorite, color: Colors.red),
  // 'like': Icon(Icons.thumb_up, color: Colors.blue),
  'sad':  IconButton(
              onPressed: null,
              icon: Image(image: AssetImage('lib/triste.png')),
              color: Colors.yellow),
  'happy': 
          IconButton(
              onPressed: null,
              icon: Image(image: AssetImage('lib/happy.png')),
              color: Colors.yellow),
  'angry': IconButton(
              onPressed: null,
              iconSize: 100,
              icon: Image(image: AssetImage('lib/en-colere.png')),
              color: Colors.yellow),
};

class MyReaction extends StatelessWidget {
  final String id;
  final data;

  const MyReaction({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return ReactionButton<String>(
      itemSize: const Size(40, 40),
      boxColor: Colors.black,
      onReactionChanged: (Reaction<String>? reaction) {
        debugPrint('Selected value: ${reaction?.value} id: $id');
      },
      isChecked: true,
      selectedReaction: Reaction<String>(
          value: data['feeling'],
          icon: reactionsList[data['feeling']] ?? const Icon(Icons.favorite, color: Colors.red),
        ),
      reactions: reactionsList.entries.map((val) => 
        Reaction<String>(
          value: val.key,
          icon: val.value,
        ),
      
      ).toList(),
      // reactions: const <Reaction<String>>[
      //   if (0 == 0)
      //   Reaction<String>(
      //     value: 'love',
      //     icon: Icon(Icons.favorite, color: Colors.red),
      //   ),
      //   Reaction<String>(
      //     value: 'love',
      //     icon: Icon(Icons.favorite, color: Colors.red),
      //   ),
      //   Reaction<String>(
      //     value: 'like',
      //     icon: Icon(
      //       Icons.thumb_up,
      //       color: Colors.blue,
      //     ),
      //   ),
      //   Reaction<String>(
      //     value: 'happy',
      //     icon: 
      //   ),
      //   Reaction<String>(
      //     value: 'love',
      //     icon: 
      //     IconButton(
      //         onPressed: null,
      //         icon: Image(image: AssetImage('lib/en-colere.png')),
      //         color: Colors.yellow),
      //   ),
      //   Reaction<String>(
      //     value: 'trist',
      //     icon: IconButton(
      //         onPressed: null,
      //         icon: Image(image: AssetImage('lib/triste.png')),
      //         color: Colors.yellow),
      //   ),
      // ],

    // selectedReaction: const Reaction<String>(
    //     value: 'like_fill',
    //     icon: Icon(Icons.favorite, color: Colors.blue),
    // ),
    );
  }
}
