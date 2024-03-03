class Endpoint {
  static const String _v = '/v2/';

  /// endpoints - IMAGES
  static final imgList = addV2('list');

  static addV2(String endpoint) => _v + endpoint;
}
