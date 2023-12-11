class GeneralSettings {
  String? androidVersion;
  String? iosVersion;
  String? updateTitle;
  String? updateDescription;
  String? freeBillsAllowed;
  String? appImage;
  String? introPdf;
  String? introVideo;
  bool? isInAppReview;
  bool? maintenanceMode;
  double? taxValue;
  double? extraUserSubscriptionPrice;
  GeneralSettings({
    this.androidVersion,
    this.iosVersion,
    this.updateTitle,
    this.updateDescription,
    this.freeBillsAllowed,
    this.appImage,
    this.isInAppReview,
    this.maintenanceMode,
    this.taxValue,
  });
  GeneralSettings.fromJson(List<dynamic> json) {
    for (var value in json) {
      if (value["key"] == "app_version_andriod") {
        androidVersion = value["value"];
      } else if (value["key"] == "app_version_ios") {
        iosVersion = value["value"];
      } else if (value["key"] == "title") {
        updateTitle = value["value"];
      } else if (value["key"] == "description") {
        updateDescription = value["value"];
      } else if (value["key"] == "free_package_allowed_bills") {
        freeBillsAllowed = value["value"];
      } else if (value["key"] == "tax") {
        taxValue = double.tryParse(value["value"]) ?? 0.0;
      } else if (value["key"] == "free_package_allowed_bills") {
        freeBillsAllowed = value["value"];
      } else if (value["key"] == "app_image") {
        appImage = value["value"];
      } else if (value["key"] == "is_in_app_review") {
        isInAppReview = value["value"].toString() == "1" ? true : false;
      } else if (value["key"] == "maintenance") {
        maintenanceMode = value["value"].toString() == "1" ? true : false;
      } else if (value["key"] == "extra_user_subscription_price") {
        extraUserSubscriptionPrice = double.tryParse(value["value"]) ?? 0.0;
      } else if (value["key"] == "intro_pdf") {
        introPdf = value["value"];
      } else if (value["key"] == "intro_video") {
        introVideo = value["value"];
      }
    }
  }
}
