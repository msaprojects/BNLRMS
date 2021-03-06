import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmsmobile/apiService/apiService.dart';
import 'package:rmsmobile/model/progress/progress.model.dart';
import 'package:rmsmobile/pages/login/login.dart';
import 'package:rmsmobile/pages/progres/progress.network.dart';
import 'package:rmsmobile/pages/progres/progress.tile.dart';
import 'package:rmsmobile/utils/warna.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late SharedPreferences sp;
  String? token = "", username = "", jabatan = "";
  List<ProgressModel> _progress = <ProgressModel>[];
  List<ProgressModel> _progressDisplay = <ProgressModel>[];

  bool _isLoading = true;

  // * ceking token and getting dashboard value from Shared Preferences
  cekToken() async {
    sp = await SharedPreferences.getInstance();
    setState(() {
      token = sp.getString("access_token");
      username = sp.getString("username");
      jabatan = sp.getString("jabatan");
    });
    print(
        'object progress ${ApiService().responseCode.statusCode} ++++ $token');
    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginscreen()));
    }
    fetchProgress(token!).then((value) {
      setState(() {
        _isLoading = false;
        _progress.addAll(value);
        _progressDisplay = _progress;
        print(_progressDisplay.length);
      });
      print('yes bisa ?');
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Maaf, Token anda expired, silahkan melakukan login ulang",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      ApiService().clearshared();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginscreen()));
    });
    ;
  }

  @override
  initState() {
    cekToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Progres',
          style: GoogleFonts.lato(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: thirdcolor,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? _searchBar()
                    : ProgressTile(
                        progress: this._progressDisplay[index - 1],
                        token: token!,
                      );
                // : SiteTile(site: this._sitesDisplay[index - 1]);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            itemCount: _progressDisplay.length + 1,
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _progressDisplay = _progress.where((u) {
              var fNama = u.permintaan.toLowerCase();
              var fKeterangan = u.keterangan.toLowerCase();
              var fkategori = u.kategori.toLowerCase();
              return fNama.contains(searchText) ||
                  fKeterangan.contains(searchText) ||
                  fkategori.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          fillColor: thirdcolor,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Cari Progres',
        ),
      ),
    );
  }
}
