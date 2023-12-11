class StoreSetting {
  String? upperText;
  String? marketName;
  String? taxNumber;
  String? bottomText;
  String? phone;
  String? hotLine;
  String? email;
  String? logo;
  String? address;
  bool? taxOnOff;
  bool? copyRightsVisible;
  String? website;
  bool? subscribe;
  int? noOfBills;
  int? noOfBillsNow;
  StoreSetting(
      {this.upperText,
      this.marketName,
      this.taxNumber,
      this.bottomText,
      this.phone,
      this.hotLine,
      this.logo,
      this.subscribe,
      this.taxOnOff,
      this.noOfBills,
      this.website,
      this.address,
      this.noOfBillsNow,
      this.copyRightsVisible,
      this.email});

  StoreSetting.fromJson(Map<String, dynamic> json) {
    upperText = json['upper_text'];
    marketName = json['market_name'];
    taxNumber = json['tax_number'];
    bottomText = json['bottom_text'];
    phone = json['phone'];
    hotLine = json['hot_line'];
    email = json['email'];
    logo = json['logo'];
    noOfBills = json['no_of_bills'];
    noOfBillsNow = json['no_of_bills_now'];
    website = json['store_url'];
    address = json['address'];
    taxOnOff = (json['tax_on_of'] ?? 1) == 1 ? true : false;
    copyRightsVisible = json['copy_rights_visible'] == 1 ? true : false;
    subscribe = json['subscribe'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['upper_text'] = upperText;
    data['market_name'] = marketName;
    data['tax_number'] = taxNumber;
    data['bottom_text'] = bottomText;
    data['phone'] = phone;
    data['hot_line'] = hotLine;
    data['email'] = email;
    data['logo'] = logo;
    data['no_of_bills'] = noOfBills;
    data['no_of_bills_now'] = noOfBillsNow;
    data['store_url'] = website;
    data['address'] = address;
    data['copy_rights_visibile'] = copyRightsVisible == true ? 1 : 0;
    data['tax_on_of'] = taxOnOff == true ? 1 : 0;
    data['subscribe'] = subscribe == true ? 1 : 0;

    return data;
  }
}
