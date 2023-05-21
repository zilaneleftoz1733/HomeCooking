import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagement/models/person.dart';
import 'package:projectmanagement/navigation/navigation_view.dart';
import 'package:projectmanagement/services/user_service.dart';
import 'package:projectmanagement/utils/googlesignin.dart';
import 'package:projectmanagement/views/auth/sign_in/sign_in_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool passwordFormatControl(String passwordA, String passwordB) {
    if (passwordA == passwordB) {
      if (passwordA.length >= 6) return true;
    }
    return false;
  }

  //kullanıcının girdiği email formatının doğruluğu bu fonksiyon ile kontrol ediliyor. If yanlış bir format bulunuyorsa diğer adımlara geçilmiyor.
  bool emailFormatControl(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  //Firebase veritabanından girilen kullanıcı mailine göre user verisi çekiliyor. Eğer çekilen dosya sayısı boş ise null değer dönüyor.
  Future<Personal?> getPersonalByEmail(String userEmail) async {
    final personalRef = FirebaseFirestore.instance.collection('users');
    final querySnapshot = await personalRef.where('email', isEqualTo: userEmail).get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    } else {
      final personalDoc = querySnapshot.docs.first;
      final personal = Personal.fromSnapshot(personalDoc);
      return personal;
    }
  }

  /*Future<User?> connectWithMail(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //print("SONUC: ${user.user}");
      return user.user;
    } catch (e) {
      return null;
    }
  }*/

  //Kullanıcının girdiği bilgiler ile çekilen mail ile girdiği password eşleşiyorsa çekilen kullanıcı verisini currentUser'e atıyoruz. Bu sayede hem giriş yapmayı hem de tekrar yapılacak girişlerde direkt anasayfayı açmayı sağlıyoruz.
  Future<User?> connectWithMail(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //print("SONUC: ${user.user}");
      return user.user;
    } catch (e) {
      return null;
    }
  }

  //cıkıs yapılması halinde lokalde tutulan kullanıcı verisini sıfırlıyoruz. Lokal verileri shared preferences ile tuttuğumuz için ilgili fonksiyonda yine shared preferences paketini kullanarak sıfırlama işlemi yapıyoruz.
  void signOut(context) async {
    await _auth.signOut();
    GoogleSignIn.standard().signOut();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignInPage(),
    ));
  }

  Future<User?> createPerson(String email, String password, String name) async {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore
        .collection("users")
        .doc(user.user?.uid)
        .set({'email': email, 'userID': user.user?.uid, 'userName': name});

    /*await _firestore
        .collection("users")
        .doc(user.user?.uid)
        .set({'email': email, 'password': password, 'userID': user.user?.uid});*/

    return user.user;
  }

  void passwordReset(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  void connectWithGoogle(context) async {
    var user = await signInWithGoogle();

    //await'e gerek yok, arkaplanda islem devam edebilir.
    _firestore
        .collection("users")
        .doc(user.user?.uid)
        .set({'email': user.user?.email, 'userID': user.user?.uid, 'userName': user.user?.displayName});

    goHomePage(context);
  }

  void goHomePage(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const NavigationPageView(),
    ));
  }

  void connectAnonymously(context) async {
    User? user = (await _auth.signInAnonymously()).user;
    if (user != null && user.isAnonymous) {
      _firestore
          .collection("users")
          .doc(user.uid)
          .set({'email': "anonymous@mail.com", 'userID': user.uid, 'userName': "Anonymous"});

      goHomePage(context);
    }
  }
}
