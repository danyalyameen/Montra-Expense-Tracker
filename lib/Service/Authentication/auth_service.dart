import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class AuthService {
  // Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  
  // Sign UP User
  Future<UserCredential> signUp(
      {required String email,
      required String password,
      required String name}) async {
    // Sign UP
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Update Database
    await _database
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(PersonData(name: name).receive());
    return userCredential;
  }
  
  // Login User
  Future<UserCredential> login(
      {required String email, required String password}) async {
    // Sign In User
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
  
  // Google Auth
  Future<UserCredential?> googleAuth() async {
    // Open Google
    GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
    if (userAccount == null) {
      return null;
    }
    // Ask For Auth
    GoogleSignInAuthentication? auth = await userAccount.authentication;
    // Get Credentials
    final credentials = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return await _auth.signInWithCredential(credentials);
  }
  
  // Get Current User
  User? getUser() {
    return _auth.currentUser;
  }

  // Sign Out User
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  // Get User Details
  Future<PersonData> getUserDetails() async {
    var data =
        await _database.collection('users').doc(_auth.currentUser!.uid).get();
    return PersonData.store(data.data() as Map<String, dynamic>);
  }
  
  // Send Email Verification Link
  sendEmailVerificationLink() async {
    await _auth.currentUser!.sendEmailVerification();
  }
  
  // Send Password Reset Link
  sendPasswordResetLink(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
