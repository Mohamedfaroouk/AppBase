import 'package:efatorh/modules/auth/domain/model/user_package.dart';

import 'app_featuers.dart';

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? countryCode;
  int? isBlocked;
  bool? isSubscribed;
  Package? subscription;
  int? higherPackages;
  String? subscriptionEnd;
  int? cityId;
  String? city;
  int? phoneVerified;
  String? emailVerifiedAt;
  String? email;
  String? address;
  String? image;
  String? token;
  int? userType;
  bool? isCompleteProfile;
  bool? isGuest;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.countryCode,
    this.isBlocked,
    this.isSubscribed,
    this.subscription,
    this.subscriptionEnd,
    this.phoneVerified,
    this.city,
    this.cityId,
    this.email,
    this.address,
    this.emailVerifiedAt,
    this.image,
    this.userType,
    this.higherPackages,
    this.isCompleteProfile,
    this.isGuest,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    final data = json['data'];
    id = data['id'];
    name = data['name'];
    phone = data['phone'];
    countryCode = data['country_code'];
    isBlocked = data['is_blocked'];
    isSubscribed = data['is_subscribed'];
    subscriptionEnd = data['end_subscription'];
    isCompleteProfile = data['completed_profile'];
    emailVerifiedAt = data['email_verified_at'];
    cityId = int.tryParse(data['city_id'].toString());
    city = data['city'];

    subscription = data['subscription'] != null
        ? Package.fromJson(data['subscription'])
        : null;
    phoneVerified = data['phone_verified'] is bool
        ? data['phone_verified'] == true
            ? 1
            : 0
        : data['phone_verified'];
    higherPackages = data['higher_packages'];
    email = data['email'];
    address = data['address'];
    image = data['image'];
    userType = data['user_type'];
    isGuest = data['is_guest'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['is_blocked'] = isBlocked;
    data['is_subscribed'] = isSubscribed;
    data['email_verification'] = emailVerifiedAt;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    data['end_subscription'] = subscriptionEnd;
    data['higher_packages'] = higherPackages;
    data['phone_verified'] = 1;
    // data['phone_verified'] = this.phoneVerified;
    data['email'] = email;
    data['address'] = address;
    data['image'] = image;
    data['user_type'] = userType;
    data['completed_profile'] = isCompleteProfile;
    data['is_guest'] = isGuest == true ? 1 : 0;
    return data;
  }

  isFree() {
    return subscription == null;
  }

  hasAccess(AppFeatures feature) {
    // return true;
    if (subscription == null) return false;
    switch (feature) {
      case AppFeatures.reports_on:
        return subscription!.reportsOn;
      case AppFeatures.copy_rights_visible:
        return subscription!.copyRightsVisible;
      case AppFeatures.price_quotation:
        return subscription!.priceQuotation;
      case AppFeatures.purchase_invoices:
        return subscription!.purchaseInvoices;
      case AppFeatures.product_movement:
        return subscription!.productMovement;
      case AppFeatures.refund_purchase:
        return subscription!.refundPurchase;
      case AppFeatures.refund_order:
        return subscription!.refundOrder;
      case AppFeatures.language:
        return subscription!.language;
      case AppFeatures.product_excel:
        return subscription!.productExcel;
      case AppFeatures.product_barcode:
        return subscription!.productBarcode;
      case AppFeatures.stocks:
        return subscription!.stocks;
      case AppFeatures.tax_return:
        return subscription!.taxReturn;
      case AppFeatures.categories:
        return subscription!.categories;
      case AppFeatures.suppliers:
        return subscription!.suppliers;
      default:
        return false;
    }
  }
}
