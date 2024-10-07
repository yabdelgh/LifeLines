import 'package:LifeLines/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  final UserCredential toto =
      await FirebaseAuth.instance.signInWithCredential(credential);
  // debugPrint('User signed in: $toto');
  return toto;
}

// Function to sign in with GitHub
Future<UserCredential?> signInWithGitHub() async {
  final githubProvider = GithubAuthProvider();
  UserCredential? userCredential;
  try {
    userCredential =
        await FirebaseAuth.instance.signInWithProvider(githubProvider);
    // debugPrint('User signed in: ${userCredential.toString()}');
  } catch (e) {

    debugPrint('----------------- Error signing in with GitHub: $e');
  }
  return userCredential;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome!',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              'To get started, sign in to your account',
                            style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          side: const BorderSide(width: 1.0, color: Colors.white),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        // onPressed: () => signInWithGoogle(),
                        onPressed: () => signInWithGoogle(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage('lib/Logo-google-icon-PNG.png'),
                                height: 25,
                                width: 25),
                            SizedBox(width: 10),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          side: const BorderSide(width: 1.0, color: Colors.black),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        onPressed: () => signInWithGitHub(),
                        // onPressed: () => {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage('lib/github-mark.png'),
                                height: 25,
                                width: 25),
                            SizedBox(width: 10),
                            Text(
                              'Sign in with Github',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ]),
            );
          }
          return const MyHomePage(); 
        });
  }
}
