import '../../../../core/utils/Utils.dart';
import '../../../../shared/models/translations.dart';

class ClientModel {
  int lastPage = 1;
  List<Client>? clients;

  //from json
  ClientModel.fromJson(Map<String, dynamic> json) {
    lastPage = json['meta'] != null ? json['meta']['last_page'] : 1;
    clients = json['data'] != null ? List<Client>.from(json['data'].map((x) => Client.fromJson(x))) : null;
  }
}

class Client {
  int? id;
  TranslationModel? translation;
  String? nameApi;
  String? phone;
  String? taxNumber;
  String? address;

  Client({this.id, this.nameApi, this.phone, this.taxNumber, this.address, this.translation});
  String get name {
    return Utils.local == "ar" ? translation?.ar ?? nameApi ?? "" : translation?.en ?? nameApi ?? "";
  }

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameApi = json['name'];
    translation = json['name_json'] != null ? TranslationModel.fromJson(json['name_json']) : null;
    phone = json['phone'];
    taxNumber = json['tax_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = {
      "ar": translation?.ar,
      "en": translation?.en,
    };
    data['phone'] = phone;
    data['tax_number'] = taxNumber;
    data['address'] = address;
    return data;
  }

  @override
  String toString() {
    return name ?? "";
  }
}
