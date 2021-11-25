import 'dart:convert';

class ProgressModelAdd {
  var idprogress,
  keterangan,
  created,
  edited,
  flag_selesai,
  next_idpengguna,
  idpengguna,
  idpermintaan,
  permintaan,
  kategori,
  due_date;

  ProgressModelAdd(
      {
        this.idprogress,
      this.keterangan,
      this.created,
      this.edited,
      this.flag_selesai,
      this.next_idpengguna,
      this.idpengguna,
      this.idpermintaan,
      this.permintaan,
      this.kategori,
      this.due_date
      });

  factory ProgressModelAdd.fromJson(Map<dynamic, dynamic> map) {
    return ProgressModelAdd(
        idprogress: map["idprogress"],
        keterangan: map["keterangan"],
        created: map["created"],
        edited: map["edited"],
        flag_selesai: map["flag_selesai"],
        next_idpengguna: map["next_idpengguna"],
        idpengguna: map["idpengguna"],
        idpermintaan: map["idpermintaan"],
        permintaan: map["permintaan"],
        kategori: map["kategori"],
        due_date: map["due_date"]
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "keterangan": keterangan,
      "idpermintaan": idpermintaan,
    };
  }

  @override
  String toString() {
    return 'keterangan: $keterangan, created: $created, edited:$edited, due_date: $due_date, flag_selesai: $flag_selesai, next_idpengguna: $next_idpengguna, permintaan: $permintaan, kategori: $kategori';
  }
}

List<ProgressModelAdd> ProgressModelAddFromJson(String dataJson) {
  final data = json.decode(dataJson);
  return List<ProgressModelAdd>.from(
      data["data"].map((item) => ProgressModelAdd.fromJson(item)));
}

String ProgressModelAddToJson(ProgressModelAdd data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}