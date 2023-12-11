class ClientEndPoints {
  static const String get = '/getClient';
  static String update(id) => '/editClient/$id';
  static const String add = '/setClient';
  static String delete(id) => '/destroyClient/$id';
  static String show(id) => '/clients/$id';
}
