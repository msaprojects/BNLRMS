import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:rmsmobile/model/dashboard/dashboard.model.dart';
import 'package:rmsmobile/model/login/loginModel.dart';
import 'package:rmsmobile/model/login/loginResult.model.dart';
import 'package:rmsmobile/model/pengguna/pengguna.model.dart';
import 'package:rmsmobile/model/pengguna/pengguna.model.gantipassword.dart';
import 'package:rmsmobile/model/progress/progress.edit.selesai.model.dart';
import 'package:rmsmobile/model/progress/progress.model.add.dart';
import 'package:rmsmobile/model/progress/progress.model.dart';
import 'package:rmsmobile/model/request/request.model.dart';
import 'package:rmsmobile/model/request/request.model.edit.dart';
import 'package:rmsmobile/model/response/responsecode.dart';
import 'package:rmsmobile/model/timeline/timeline.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://server.bnl.id:9990/api/v1/";
  Client client = Client();
  String? token = "";

  ResponseCode responseCode = ResponseCode();

  void clearshared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(token.toString());
    preferences.clear();
    late FirebaseMessaging messaging;
    // * adding firebase configuration setup
    messaging = FirebaseMessaging.instance;
    messaging.unsubscribeFromTopic('RMSPERMINTAAN');
    messaging.unsubscribeFromTopic('RMSPROGRESS');
    // print('preference $preferences');
  }

//  LOGIN
  Future<bool> loginIn(LoginModel data) async {
    var url = Uri.parse(baseUrl + 'login');
    var response = await client.post(url,
        headers: {'content-type': 'application/json'}, body: loginToJson(data));

    Map resultLogin = jsonDecode(response.body);
    var loginresult = LoginResult.fromJson(resultLogin);

    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print('Value Login ' + resultLogin.toString());
    print('tes rcode ${response.body}');
    print('tes jcode ${response.statusCode}');
    if (response.statusCode == 200) {
//      Share Preference
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("access_token", "${loginresult.access_token}");
      sp.setString("refresh_token", "${loginresult.refresh_token}");
      sp.setString("username", "${loginresult.username}");
      sp.setString("jabatan", "${loginresult.jabatan}");
      sp.setString("nama", "${loginresult.nama}");
      sp.setBool("notif_permintaan", true);
      sp.setBool("notif_progress", true);
      return true;
    } else {
      return false;
    }
  }

  ///////////////////// MODEL ALL REQUEST : GET, PUT, POST, DEL ////////////////////////////////

  Future<List<RequestModel>?> getListRequest(String token) async {
    var url = Uri.parse(baseUrl + 'permintaan');
    var response = await client.get(url, headers: {
      'content-type': 'application/json',
      // ++ fyi : sending token with BEARER
      'Authorization': 'Bearer ' + token
    });
    // ++ fyi : for getting response message from api
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("Data Komponen : " + response.body);
    if (response.statusCode == 200) {
      return RequestModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("cek masuk dash");
      clearshared();
    } else {
      return null;
    }
  }

  // ! Add Data Request
  Future<bool> addRequest(String token, RequestModel data) async {
    var url = Uri.parse(baseUrl + 'permintaan');
    var response = await client.post(url,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: RequestModelToJson(data));
    print("addrequest");
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print('respon dari api add ${response.statusCode}');
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ubahRequest(
      String token, String idpermintaan, RequestModelEdit data) async {
    var url = Uri.parse(baseUrl + 'permintaan' + '/' + idpermintaan);
    print('hasilurl $url idpermintaannya $idpermintaan');
    var response = await client.put(url,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: RequestModelEditToJson(data));
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hapusRequest(String token, String idpermintaan) async {
    var url = Uri.parse(baseUrl + 'permintaan/' + idpermintaan.toString());
    var response = await client.delete(url, headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    print('url delete $url + "token $token" + idpermintaan $idpermintaan');
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print('responapidelete $responsemessage + ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///////////////////// END MODEL ALL REQUEST : GET, PUT, POST, DEL ////////////////////////////////

  // ! Add Data Request
  Future<bool> addProgres(String token, ProgressModelAdd data) async {
    print("addprogress1");
    var url = Uri.parse(baseUrl + 'progress');
    var response = await client.post(url,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: ProgressModelAddToJson(data));
    print("addprogress");
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print('rescode progress ${response.statusCode}');
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProgressModel>?> getListProgres(String token) async {
    var url = Uri.parse(baseUrl + 'progress');
    var response = await client.get(url, headers: {
      'content-type': 'application/json',
      // ++ fyi : sending token with BEARER
      'Authorization': 'Bearer ' + token
    });
    // ++ fyi : for getting response message from api
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("Data Komponen : " + response.body);
    if (response.statusCode == 200) {
      return ProgressModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("cek masuk dash ${response.statusCode}");
      clearshared();
    } else {
      return null;
    }
  }

  Future<bool> ubahProgresJadiSelesai(
      String token, String idprogress, ProgressModelEdit data) async {
    var url = Uri.parse(baseUrl + 'progress' + '/' + idprogress);
    print('hasilurl $url idprogress $idprogress');
    var response = await client.put(url,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: ProgressModelEditToJson(data));
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PenggunaModel>?> getPengguna(String token) async {
    var url = Uri.parse(baseUrl + 'pengguna');
    var response = await client.get(url, headers: {
      'content-type': 'application/json',
      // ++ fyi : sending token with BEARER
      'Authorization': 'Bearer ' + token
    });
    // ++ fyi : for getting response message from api
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("Data pengguna : " + response.body);
    if (response.statusCode == 200) {
      return PenggunaModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("cek masuk dash");
      clearshared();
    } else {
      return null;
    }
  }

  Future<bool> ubahPassword(String token, ChangePassword data) async {
    var url = Uri.parse(baseUrl + 'pengguna');
    print('hasilurl change pass $url');
    var response = await client.put(url,
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: ChangePasswordToJson(data));
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("hasil respon dari api $responseCode ++ $responsemessage");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<TimelineModel>?> getListTimeline(
      String token, String idpermintaan) async {
    var url = Uri.parse(baseUrl + 'timeline/' + idpermintaan);
    var response = await client.get(url, headers: {
      'content-type': 'application/json',
      // ++ fyi : sending token with BEARER
      'Authorization': 'Bearer ' + token
    });
    // ++ fyi : for getting response message from api
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("Data Site : " + response.body);
    if (response.statusCode == 200) {
      return timelineFromJson(response.body);
    } else if (response.statusCode == 401) {
      print("cek masuk dash");
      clearshared();
    } else {
      return null;
    }
  }

  Future<List<DashboardModel>?> getDashboard(String token) async {
    var url = Uri.parse(baseUrl + 'dashboard');
    var response = await client.get(url, headers: {
      'content-type': 'application/json',
      // ++ fyi : sending token with BEARER
      'Authorization': 'Bearer ' + token
    });
    // ++ fyi : for getting response message from api
    Map responsemessage = jsonDecode(response.body);
    responseCode = ResponseCode.fromJson(responsemessage);
    print("Data Dashbaord : " + response.body);
    print("pesan dari langit!" + response.statusCode.toString());
    if (response.statusCode == 200) {
      return dashboardFromJson(response.body);
      // return compute(parseDashboard, response.body);
    } else if (response.statusCode == 401) {
      print("cek masuk dash");
      clearshared();
    } else {
      return null;
      // throw Exception(response.statusCode);
    }
  }
}
