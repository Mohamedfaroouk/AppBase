class TranslationModel {
  String? en;
  String? ar;

  TranslationModel({this.en, this.ar});

  factory TranslationModel.fromJson(Map<String, dynamic> map) {
    return TranslationModel(
      en: map['en'],
      ar: map['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (en != null && en?.isNotEmpty == true) 'en': en,
      if (ar != null && ar?.isNotEmpty == true) 'ar': ar,
    };
  }
}
