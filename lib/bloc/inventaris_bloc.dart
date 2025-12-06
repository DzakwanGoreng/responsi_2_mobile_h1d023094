import 'dart:convert';
import 'package:responsi_2_mobile_h1d023094/helpers/api.dart';
import 'package:responsi_2_mobile_h1d023094/helpers/api_url.dart';
import 'package:responsi_2_mobile_h1d023094/models/inventaris.dart';

class InventarisBloc {
  static Future<List<Inventaris>> getInventaris() async {
    String apiUrl = ApiUrl.listInventaris;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listInventaris = (jsonObj as Map<String, dynamic>)['data'];
    List<Inventaris> inventaris = [];
    for (int i = 0; i < listInventaris.length; i++) {
      inventaris.add(Inventaris.fromJson(listInventaris[i]));
    }
    return inventaris;
  }

  static Future addInventaris({Inventaris? inventaris}) async {
    String apiUrl = ApiUrl.createInventaris;
    var body = {
      "nama": inventaris!.nama,
      "harga": inventaris.harga.toString(),
      "jumlah": inventaris.jumlah.toString(),
      "tanggal_masuk": inventaris.tanggalMasuk,
      "tanggal_kedaluwarsa": inventaris.tanggalKedaluwarsa
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateInventaris({required Inventaris inventaris}) async {
    String apiUrl = ApiUrl.updateInventaris(int.parse(inventaris.id!));
    var body = {
      "nama": inventaris.nama,
      "harga": inventaris.harga.toString(),
      "jumlah": inventaris.jumlah.toString(),
      "tanggal_masuk": inventaris.tanggalMasuk,
      "tanggal_kedaluwarsa": inventaris.tanggalKedaluwarsa
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteInventaris({int? id}) async {
    String apiUrl = ApiUrl.deleteInventaris(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}