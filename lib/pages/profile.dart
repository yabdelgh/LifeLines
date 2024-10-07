import 'package:LifeLines/components/card.dart';
import 'package:LifeLines/components/feelingspercentage.dart';
import 'package:LifeLines/components/notedialog.dart';
import 'package:LifeLines/components/reaction.dart';
import 'package:LifeLines/main.dart';
import 'package:LifeLines/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5865F2),
                    Color(0xFF8A2BE2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('lib/einstein.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Albert Einstein',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const Spacer(),
                        Text('Last login: 12 april, 2024',
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.notes_rounded, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('Last entries',
                      style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AppModel>(
              builder: (context, model, child) {
                final notes = model.notes;
                if (notes.isEmpty) {
                  return const Center(child: Text('No notes available.'));
                }
                return Column(
                  children: [
                    Column(
                        children: notes
                            .take(2)
                            .map((data) =>
                                CustomCard(id: data['id'], data: data['data']))
                            .toList()),
                    Container(
                      width: double.infinity,
                      // height: 50,
                      margin:const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.chartPie,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(width: 15),
                          Text('Your feel for your  ${notes.length} entries',
                              style: Theme.of(context).textTheme.displaySmall),
                        ],
                      ),
                    ),
                    FeelingsPercentage(notes: notes)
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            Card(
              // clipBehavior is necessary because, without it, the InkWell's animation
              // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
              // This comes with a small performance cost, and you should not set [clipBehavior]
              // unless you need it.
              // color: Colors.transparent,
              margin: const EdgeInsets.all(0),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                // splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  debugPrint('Card tapped.');
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text('Log out',
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
