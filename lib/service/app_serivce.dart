import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppService extends GetxService {
  late DatabaseService databaseService;
  AppService() {
    databaseService = Get.put<DatabaseService>(DatabaseService());
  }
}

class DatabaseService extends GetxService {
  // late Box<Session> session;

  DatabaseService() {
    registerAppAdapter();
    openBox();
  }

  clearData() {
    // session.clear().then((value) => session.add(Session()..authPageType));
  }

  clearAll() {}

  openBox() async {
    // Hive.openBox<Session>(Session.route).then((value) {
    //   session = value;
    //   if (session.isEmpty) {
    //     session.add(Session()..authPageType);
    //   }
    // });
  }

  registerAppAdapter() {
    // Hive.registerAdapter(SessionAdapter());
  }
}
