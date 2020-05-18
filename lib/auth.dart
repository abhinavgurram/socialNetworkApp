import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //auth change user stream
  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;


      return true;
    }catch (e) {
      print(e.toString());
      return false;
    }
  }
  Future signOut() async {
    try {
      await googleSignIn.signOut();
    }catch (e) {
      print(e);
    } finally {
      await _auth.signOut();
    }
  }
  //sign in and out email password

  Future signInEmailPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      return false;
    }
  }
  //sign in and out facebook
  //sign in and out twitter
  //register email and password
  Future registerEmailPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      return false;
    }
  }


}






