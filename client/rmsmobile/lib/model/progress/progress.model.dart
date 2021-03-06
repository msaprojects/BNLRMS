import 'dart:convert';

class ProgressModel {
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
      due_date,
      nama;

  ProgressModel(
      {this.idprogress,
      this.keterangan,
      this.created,
      this.edited,
      this.flag_selesai,
      this.next_idpengguna,
      this.idpengguna,
      this.idpermintaan,
      this.permintaan,
      this.kategori,
      this.due_date,
      this.nama});

  factory ProgressModel.fromJson(Map<dynamic, dynamic> map) {
    return ProgressModel(
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
        due_date: map["due_date"],
        nama: map["nama"]
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "keterangan": keterangan,
      "idpermintaan": idpermintaan,
      // "tipe": tipe
    };
  }

  @override
  String toString() {
    return 'idprogress: $idprogress, keterangan: $keterangan, created: $created, edited:$edited, flag_selesai: $flag_selesai, next_idpengguna: $next_idpengguna, due_date: $due_date, permintaan: $permintaan, kategori: $kategori, nama: $nama';
  }
}

List<ProgressModel> ProgressModelFromJson(String dataJson) {
  final data = json.decode(dataJson);
  return List<ProgressModel>.from(
      data["data"].map((item) => ProgressModel.fromJson(item)));
}

String ProgressModelToJson(ProgressModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
