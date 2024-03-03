import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:hive/hive.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';

/// allow app to use Hive local storage
/// Register Adapter
/// Open box
class DataStoreService extends GetxService {
  late Box<IGMImage> gallaryBox;

  Future<DataStoreService> init() async {
    Hive.registerAdapter(IGMImageAdapter());
    await Hive.openBox<IGMImage>(IGMImage.boxName);
    return this;
  }

  // Registering the adapter
  registerAdapter() {
    Hive.registerAdapter(IGMImageAdapter());
  }

  // Opening the box
  openBoxes() async {
    gallaryBox = await Hive.openBox<IGMImage>(IGMImage.boxName);
  }
}
