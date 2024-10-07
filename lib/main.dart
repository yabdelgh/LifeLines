import 'package:LifeLines/pages/calendar.dart';
import 'package:LifeLines/pages/home.dart';
import 'package:LifeLines/pages/login.dart';
import 'package:LifeLines/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LifeLines/components/dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // StreamSubscription<QuerySnapshot>? _usersSubscription;
  // List<DocumentSnapshot> _notes = [];
  List<Map<String, dynamic>> _notes = [];
  // final List<String> _notes = ['yassine', 'abdou', 'sos'];
  AppModel() {
    _init();
  }

  void _init() {
    debugPrint('-------------------init done');
    _firestore
        .collection('/users/1NgXnWc4PagpCvRh7LFxoFrByMd2/notes')
        .orderBy('createdAt', descending: true) 
        .snapshots()
        .listen((snapshot) {
          _notes = snapshot.docs.map((doc) => {"id": doc.id,"data": doc.data()}).toList();
          notifyListeners(); // Notify listeners when data changes
        });
  }

  // Dispose resources when the model is no longer needed
  // @override
  // void dispose() {
  //   _usersSubscription?.cancel(); // Cancel the stream subscription
  //   super.dispose();
  // }

  // Getter for notes to be used by UI
  List<Map<String, dynamic>> get notes => _notes;
  // List<String> get notes => _notes;

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF313338),
        cardTheme: CardTheme(
          color: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.varela(
            color: Colors.white,
            fontSize: 30,
          ),
          titleMedium: GoogleFonts.varela(
            color: Colors.white,
            fontSize: 25,
          ),
          displayMedium: GoogleFonts.varela(
            color: Colors.white,
            fontSize: 25,
          ),
          displaySmall: GoogleFonts.varela(
            color: Colors.white,
            fontSize: 20,
          ),
          labelMedium: GoogleFonts.varela(
            color: Colors.white60,
            fontSize: 15,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, primary: Colors.red, secondary: Colors.red
            // brightness: Brightness.dark,
            ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      home: const LoginPage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  String _title = 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: () {},
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const NoteForm(),
              ),
        backgroundColor: const Color(0xFF5865F2),
        foregroundColor: const Color(0xFFFFFFFF),
        
        child: const Icon(FontAwesomeIcons.fileCirclePlus),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Spacer(),
          SizedBox(
            // width: 70,
            child: IconButton(
              tooltip: 'Open popup menu',
              icon: Icon(
                FontAwesomeIcons.ellipsisVertical,
                size: 25,
                color: Colors.grey[200],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        // color: Colors.red,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Colors.transparent,
              // iconTheme: WidgetStateProperty.resolveWith((states) {
              //   return  IconTheme(
              //     // fontSize: 13.0,
              //     // fontWeight: FontWeight.w700,
              //     // color: Colors.white,
              //     // letterSpacing: 1.0,
              //   );
              // }),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  );
                }
                return const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.0,
                );
              })),
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
                _title = index == 0
                    ? 'Home'
                    : index == 1
                        ? 'Profile'
                        : 'Calendar';
              });
            },
            indicatorColor: const Color(0x405865F2), // Couleur de base
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon:
                    Icon(FontAwesomeIcons.house, color: Color(0xFFFFFFFF)),
                icon: Icon(
                  FontAwesomeIcons.house,
                  color: Color(0xFFFFFFFF),
                ),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon:
                    Icon(FontAwesomeIcons.userLarge, color: Color(0xFFFFFFFF)),
                icon: Icon(FontAwesomeIcons.user, color: Color(0xFFFFFFFF)),
                label: 'Profile',
              ),
              NavigationDestination(
                selectedIcon: Icon(FontAwesomeIcons.solidCalendar,
                    color: Color(0xFFFFFFFF)),
                icon: Icon(FontAwesomeIcons.calendar, color: Color(0xFFFFFFFF)),
                label: 'Calendar',
              ),
           
            ],
          ),
        ),
      ),
      body: <Widget>[
        // const LoginPage(),
        const HomePage(),
        const Profile(),
        Consumer<AppModel>(
      builder: (context, model, child) {
        final notes = model.notes;
        return TableBasicsExample(notes: notes);
       
      })
        
        // const LoginPage(),
      ][currentPageIndex],
    );
  }
}