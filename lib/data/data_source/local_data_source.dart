import '../responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() {
    // TODO: implement getHome
    throw UnimplementedError();
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }
}

class CachedItem {
  dynamic data;

  int cachedTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}
