class Endpoint {
  static const String _v = '/v2/';

  /// endpoints - IMAGES
  static final imgList = addV2('list');
  static String imageDetail(String id) => '/id/$id/info';

  //
  static addV2(String endpoint) => _v + endpoint;

  ///
  static String addPagination(int page, int limit, {required String path}) =>
      path + '?page=$page&limit=$limit';
}
