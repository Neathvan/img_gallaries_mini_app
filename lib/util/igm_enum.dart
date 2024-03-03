enum ApiStatus {
  connectionError,
  empty,
  error,
  loaded,
  loading;

  String get msg => switch (this) {
        connectionError => 'No internet connection',
        empty => 'Empty list',
        error => 'Something went wrong!',
        loaded => 'Sucess',
        loading => 'Loading..'
      };
}
