import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/util/config.dart';
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
  Rx<GallaryView> gallaryView = GallaryView.grid.obs;

  @override
  void initState() {
    gallaryController.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(IGMConfig.appName, style: Get.textTheme.black13)),
      body: GetBuilder<GallaryController>(
          init: gallaryController,
          builder: (controller) {
            return EasyRefresh(
              header: const MaterialHeader(clamping: false),
              footer: const MaterialFooter(clamping: false),
              onRefresh: () => controller.getList(),
              onLoad: () async {
                return await controller.getList(loadMore: true);
              },

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

                    /// recheck wtih local data
                    if (isError && gallary.isNotEmpty) {
                      apiStatus(ApiStatus.loaded);
                    }

                    return LayoutBuilder(builder: (context, constraint) {
                      return Obx(() {
                        /// update layout and icon btn
                        Widget layout;
                        Icon icon;
                        switch (gallaryView.value) {
                          case GallaryView.list:
                            icon = const Icon(Icons.list);
                            layout = _listLayout(gallary);

                          case GallaryView.grid:
                            icon = const Icon(Icons.grid_3x3);
                            layout = _gridLayout(gallary);
                        }

                        ///
                        return Stack(
                          children: [
                            _layout(constraint, apiStatus, controller, layout)
                                .marginOnly(top: 25),
                            _viewBtn(icon),
                          ],
                        );
                      });
                    });
                  }),
            );
          }),
    );
  }

  Positioned _viewBtn(Icon icon) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
          color: Colors.transparent,
          child: ElevatedButton.icon(
                  onPressed: () {
                    GallaryView view;
                    if (gallaryView.value == GallaryView.grid) {
                      view = GallaryView.list;
                    } else {
                      view = GallaryView.grid;
                    }

                    gallaryView(view);
                  },
                  icon: icon,
                  label: Text(gallaryView.value.reversName.capitalizeFirst!))
              .marginSymmetric(horizontal: 32)),
    );
  }

  SingleChildScrollView _layout(BoxConstraints constraint,
      Rx<ApiStatus> apiStatus, GallaryController controller, Widget layout) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraint.maxHeight),
        child: IntrinsicHeight(
          child: KBuilderComponent(
              apiStatus: apiStatus,
              onError: () async => await controller.getList(),
              builder: (context, status) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [16.height, layout]);
              }),
        ).marginOnly(top: 16),
      ),
    );
  }

  Align _gridLayout(List<IGMImage> gallary) {
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: gallary.map((e) => ImgCard(image: e)).toList()),
    );
  }

  Align _listLayout(List<IGMImage> gallary) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
          children: gallary
              .map((e) => ImgCard(image: e, view: gallaryView.value))
              .toList()),
    );
  }
}
