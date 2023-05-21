import 'package:cloud_firestore/cloud_firestore.dart';

class Personal {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String companyID;
  final String companyName;
  final String userID;
  final int remainingDay;
  Map<String, bool> companyFeaturesMap;

  Personal(this.surname, this.companyID, this.companyName, this.userID, this.name, this.email, this.password,
      this.remainingDay, {this.companyFeaturesMap = const {'announcements':true,'events': false, 'foodList': false, 'leaveRequests': false, 'nearMiss': false, 'news': false, 'payroll': false, 'services':true}});

  factory Personal.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Personal(
      data['surname'],
      data['companyID'],
      data['companyName'],
      data['userID'],
      
      data['name'],
      data['email'],
      data['password'],
      data['remainingDay'],
    );
  }
}
