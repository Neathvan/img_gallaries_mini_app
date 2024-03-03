import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';

class KBuilderComponent extends StatelessWidget {
  final Rx<ApiStatus> apiStatus;
  final Widget Function(BuildContext, ApiStatus) builder;
  final Widget? error;
  final Widget? empty;
  final Widget? loading;
  const KBuilderComponent(
      {Key? key,
      required this.apiStatus,
      required this.builder,
      this.error,
      this.empty,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (apiStatus.value) {
        case ApiStatus.empty:
          return emptyComponent();
        case ApiStatus.error:
          return errorComponent();
        case ApiStatus.loaded:
          return builder.call(context, apiStatus.value);

        default:
          return loadingComponent();
      }
    });
  }

  Center loadingComponent() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center errorComponent() {
    return Center(
      child: Text(apiStatus.string),
    );
  }

  Center emptyComponent() {
    return Center(
      child: Text(apiStatus.string),
    );
  }
}
