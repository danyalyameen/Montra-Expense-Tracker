import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  googleAuth() async {
    GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
    if (userAccount == null) {
      return;
    }
    GoogleSignInAuthentication? auth = await userAccount.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return await _auth.signInWithCredential(credentials);
  }

  addUserDetails({required String id, required String name}) async {
    await _database
        .collection('users')
        .doc(id)
        .set(PersonData(name: name).receive());
  }

  User? getUser() {
    return _auth.currentUser;
  }

  sendEmailVerificationLink() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  sendPasswordResetLink(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
