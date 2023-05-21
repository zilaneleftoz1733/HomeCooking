import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  static String userID = FirebaseAuth.instance.currentUser!.uid;
  static bool isAdminAccount = FirebaseAuth.instance.currentUser!.uid == 'VeURlAcmgqdhCfNECSQ8QpZyFhc2';
  static String userName = FirebaseAuth.instance.currentUser!.displayName ?? "Anonymous";
  static String userEmail = FirebaseAuth.instance.currentUser!.email ?? "unknownemail@gmail.com";
  static String userPhotoUrl = FirebaseAuth.instance.currentUser!.photoURL ??
      "https://firebasestorage.googleapis.com/v0/b/supercookpad.appspot.com/o/profilepicture.png?alt=media&token=2264f5eb-cd2c-4173-b8f7-1ff68625b75f";

  UserController() {
    isAdminAccount = FirebaseAuth.instance.currentUser!.uid == 'VeURlAcmgqdhCfNECSQ8QpZyFhc2';
    userID = FirebaseAuth.instance.currentUser!.uid;
    userName = FirebaseAuth.instance.currentUser!.displayName ?? "Anonymous";
    userEmail = FirebaseAuth.instance.currentUser!.email ?? "unknownemail@gmail.com";
    userPhotoUrl = FirebaseAuth.instance.currentUser!.photoURL ??
        "https://firebasestorage.googleapis.com/v0/b/supercookpad.appspot.com/o/profilepicture.png?alt=media&token=2264f5eb-cd2c-4173-b8f7-1ff68625b75f";
  }

  String getUserID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  String getUserName() {
    return FirebaseAuth.instance.currentUser!.displayName ?? "Anonymous";
  }

  String getUserEmail() {
    return FirebaseAuth.instance.currentUser!.email ?? "unknownemail@gmail.com";
  }

  bool isUserAnAdmin() {
    return FirebaseAuth.instance.currentUser!.uid == 'VeURlAcmgqdhCfNECSQ8QpZyFhc2';
  }
}
