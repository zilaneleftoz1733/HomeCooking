import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class DateService {
  

  String convertTimeStampToString(Timestamp timeStampDate) {
    DateTime dateTime = timeStampDate.toDate();

    //burda UTC+3'e cevirmek icin 3 saat ekleme yaptık.
    //Veriler Firebase veritabanından UTC olarak geliyor.
    dateTime = dateTime.add(const Duration(hours: 3));

    String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);

    return formattedDate;
  }

  String convertTimeStampYearToString(Timestamp timeStampDate) {
    DateTime dateTime = timeStampDate.toDate();

    //burda UTC+3'e cevirmek icin 3 saat ekleme yaptık.
    //Veriler Firebase veritabanından UTC olarak geliyor.
    dateTime = dateTime.add(const Duration(hours: 3));

    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

    return formattedDate;
  }

  //iki timestamp verisini birleştirerek göstermeye yarayan fonksiyon.
  String unionAndConvertStringDoubleTimestamp(Timestamp startDate, Timestamp endDate) {
    DateTime startDateTime = startDate.toDate();
    DateTime endDateTime = endDate.toDate();

    startDateTime = startDateTime.add(const Duration(hours: 3));
    endDateTime = endDateTime.add(const Duration(hours: 3));

    String formattedDate =
        "${DateFormat('dd.MM.yyyy').format(startDateTime)} - ${DateFormat('dd.MM.yyyy').format(endDateTime)}";

    return formattedDate;
  }

 
}
