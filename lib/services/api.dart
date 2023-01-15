import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future getSchoolCode(String schoolName, atpt) async {
    final url = Uri.parse(
        'https://open.neis.go.kr/hub/schoolInfo?Type=json&pIndex=1&pSize=100&KEY=94761be062484942bf49541719b7d4ab&SCHUL_NM=$schoolName&ATPT_OFCDC_SC_CODE=$atpt');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);
      return data['schoolInfo'][1]['row'][0]['SD_SCHUL_CODE'];
    }
    throw Error();
  }

  static Future getSchoolMeal(
      String schoolCode, atpt, date, int mealTime) async {
    final url = Uri.parse(
        'https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=100&KEY=94761be062484942bf49541719b7d4ab&SD_SCHUL_CODE=$schoolCode&ATPT_OFCDC_SC_CODE=$atpt&MLSV_YMD=$date');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);
      if (data['mealServiceDietInfo'] == null) {
        return "";
      } else if (data['mealServiceDietInfo'][1]['row'].length == 2 &&
          mealTime == 2) {
        return "";
      } else if (data['mealServiceDietInfo'][1]['row'].length == 1 &&
          (mealTime == 1 || mealTime == 2)) {
        return "";
      } else {
        return data['mealServiceDietInfo'][1]['row'][mealTime]['DDISH_NM'];
      }
    }
    throw Error();
  }
}
