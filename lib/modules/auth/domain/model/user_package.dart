class Package {
  int? id;
  String? title;
  String? description;
  int? employeeCount;

  num? price;
  num? pricePercent;
  num? linePrice;
  int? period;
  List<Features>? features;
  String? createdAt;
  bool reportsOn = false;
  bool copyRightsVisible = false;
  bool priceQuotation = false;
  bool purchaseInvoices = false;
  bool productMovement = false;
  bool refundPurchase = false;
  bool refundOrder = false;
  bool language = false;
  bool productExcel = false;
  bool productBarcode = false;
  bool stocks = false;
  bool taxReturn = false;
  bool categories = false;
  bool suppliers = false;
  Package({this.id, this.title, this.description, this.employeeCount, this.price, this.period, this.features, this.createdAt});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    employeeCount = json['employee_count'];
    reportsOn = json['reports_on'];
    copyRightsVisible = json['copy_rights_visible'];
    priceQuotation = json['price_quotation'];
    purchaseInvoices = json['purchase_invoices'];
    productMovement = json['product_movement'];
    refundPurchase = json['refund_purchase'];
    refundOrder = json['refund_order'];
    language = json['language'];
    productExcel = json['product_excel'];
    productBarcode = json['product_barcode'];
    stocks = json['stocks'];
    taxReturn = json['tax_return'];
    categories = json['categories'];
    suppliers = json['suppliers'];
    pricePercent = json['discount_percent'] ?? 0;
    linePrice = json['list_price'] ?? 0;

    price = json['price'];
    period = json['period'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['employee_count'] = employeeCount;
    data['reports_on'] = reportsOn == 1 ? true : false;
    data['copy_rights_visible'] = copyRightsVisible == 1 ? true : false;
    data['price'] = price;
    data['period'] = period;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Features {
  Title? title;

  Features({this.title});

  Features.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title!.toJson();
    }
    return data;
  }
}

class Title {
  String? ar;

  Title({this.ar});

  Title.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    return data;
  }
}
