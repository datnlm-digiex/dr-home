import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';

class GoogleSignInController with ChangeNotifier {
  late FirebaseApp firebaseApp;
  late User firebaseUser;
  late FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> initlizeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
  }

  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<String> googleLogin() async {
    final accountController = Get.put(AccountController());
    String statusLogin = "";
    try {
      accountController.isLoading.value = true;
      await initlizeFirebaseApp();
      var idToken;
      firebaseAuth = FirebaseAuth.instance;

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser!.authentication;
        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredentialData =
            await FirebaseAuth.instance.signInWithCredential(credential);
        firebaseUser = userCredentialData.user!;
        idToken = await firebaseUser.getIdToken();
      } else { 
        idToken = await currentUser.getIdToken();
      }
      print(idToken);
      await FetchAPI.loginWithToken(idToken)
          .then((value) => statusLogin = value);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      statusLogin = "";
    } finally {
      accountController.isLoading.value = false;
    }
    return statusLogin;
  }

  logOut() async {
    this._user = await _googleSignIn.signOut();
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    notifyListeners();
  }
}
