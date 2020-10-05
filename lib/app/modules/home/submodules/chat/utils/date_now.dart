
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DateNow{

  static const String URL = "http://worldtimeapi.org/api/timezone/America/Argentina/Salta";

  static Future<Timestamp> getDate() async {
     final dio = Modular.get<Dio>();
    Response response = await dio
          .get(URL);
    var result = response.data;
    String data = result["datetime"];
    DateTime dataConvertida = DateTime.tryParse(data);
    Timestamp datFinal = Timestamp.fromDate(dataConvertida);
    return datFinal;
  }

}