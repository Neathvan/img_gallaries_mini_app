import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/service/config.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/img_card.dart';
import 'package:img_gallaries_mini_app/ui/component/k_builder/k_builder_component.dart';

import '../util/igm_enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GallaryController gallaryController =
      Get.put<GallaryController>(GallaryController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(IGMConfig.appName.capitalizeFirst!,
              style: Get.textTheme.black13)),
      body: GetBuilder<GallaryController>(
          autoRemove: false,
          init: gallaryController,
          initState: (state) => gallaryController.getList(),
          builder: (controller) {
            return EasyRefresh(
              header: const MaterialHeader(clamping: false),
              footer: const MaterialFooter(clamping: false),
              onRefresh: () => controller.getList(),
              onLoad: () => controller.getList(loadMore: true),

              /// read image from box
              child: ValueListenableBuilder<Box<IGMImage>>(
                  valueListenable: controller.gallaryBox.listenable(),
                  builder: (context, box, child) {
                    /// all value from box
                    List<IGMImage>? gallary = (box.values).toList();
                    Rx<ApiStatus> apiStatus =
                        controller.gallariesResult.apiStatus;

                    /// update api status
                    bool isError =
                        (apiStatus.value == ApiStatus.connectionError ||
                            apiStatus.value == ApiStatus.error);

                    /// wtih local data
                    if (isError && gallary.isNotEmpty) {
                      apiStatus(ApiStatus.loaded);
                    }

                    return LayoutBuilder(builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: IntrinsicHeight(
                            child: KBuilderComponent(
                                apiStatus: apiStatus,
                                onError: () async => await controller.getList(),
                                builder: (context, status) {
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: gallary
                                            .map((e) => ImgCard(image: e))
                                            .toList()),
                                  );
                                }),
                          ),
                        ),
                      );
                    });
                  }),
            );
          }),
    );
  }
}
