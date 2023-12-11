class ConstKeys {
  static const devEnv = true;
  static const baseUrlDev = "";
  static const baseUrlLive = "";
  static const moyaser = "";
  static String paymentKeyLive = '';
  static String paymentKeyTest = '';

  static String get paymentKey => devEnv ? paymentKeyTest : paymentKeyLive;
  static String get baseUrl => devEnv ? baseUrlDev : baseUrlLive;

  static get baseNoApi {
    return baseUrl.replaceAll("/api", "");
  }
}
