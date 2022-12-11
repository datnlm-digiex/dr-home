import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:http/http.dart' as http;

import '../Screens/login_form_screen.dart';

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
    final prefShare = await SharedPreferences.getInstance();
    prefShare.setString('accessToken', '');
    notifyListeners();
    Get.off(LoginScreen());
  }

  Future<String> login(String phone, String password) async {
    final accountController = Get.put(AccountController());
    String statusLogin = "";
    try {
      accountController.isLoading.value = true;
      await FetchAPI.loginWithPhone(phone, password).then(
        (value) => statusLogin = value,
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
      statusLogin = "";
    } finally {
      accountController.isLoading.value = false;
    }
    return statusLogin;
  }
}
