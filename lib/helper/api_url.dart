class ApiUrl {
  static const String baseUrl = 'http://192.168.18.32:8080/'; // Ganti dengan IP lokal Anda
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listInventaris = baseUrl + '/inventaris';
  static const String createInventaris = baseUrl + '/inventaris';

  static String updateInventaris(int id) {
    return baseUrl + '/inventaris/' + id.toString();
  }

  static String showInventaris(int id) {
    return baseUrl + '/inventaris/' + id.toString();
  }

  static String deleteInventaris(int id) {
    return baseUrl + '/inventaris/' + id.toString();
  }
}