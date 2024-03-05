import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Widget which handle widget base on [ApiStatus]

class KBuilderComponent extends StatelessWidget {
  final Rx<ApiStatus> apiStatus;
  final Widget Function(BuildContext, ApiStatus) builder;
  final VoidCallback? onError;
  final VoidCallback? onEmpty;
  final VoidCallback? loading;
  const KBuilderComponent(
      {Key? key,
      required this.apiStatus,
      required this.builder,
      this.onError,
      this.onEmpty,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String msg = apiStatus.value.msg;

      switch (apiStatus.value) {
        case ApiStatus.empty:
          return _retryWidget(msg);
        case ApiStatus.error:
        case ApiStatus.connectionError:
          return _retryWidget(msg);
        case ApiStatus.loaded:
          return builder.call(context, apiStatus.value);

        default:
          return loadingComponent(msg);
      }
    });
  }

  Center loadingComponent(String msg) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        16.height,
        LoadingAnimationWidget.inkDrop(size: 40, color: AppColor.black),
      ],
    ));
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

  _retryWidget(String msg) => Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msg),
              16.height,
              ElevatedButton(onPressed: onError, child: const Text('Retry'))
            ]),
      );
}

/// Responsible network connection by [Connectivity] streamming
class NetworkConnectionWidget extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  const NetworkConnectionWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged
          ..listen((event) {
            EasyLoading.showError(event.name);
          }),
        builder: (context, AsyncSnapshot<ConnectivityResult> snap) {
          // print(snap.data);

          return builder(context);
        });
  }

  handleLayoutOfConnection(AsyncSnapshot<ConnectivityResult> snap) {
    switch (snap.connectionState) {
      case ConnectionState.active:
        final ConnectivityResult state = snap.data!;
        // print(state);
        switch (state) {
          case ConnectivityResult.none:
          // EasyLoading.showError(ApiStatus.connectionError.msg);
          default:
            return;
        }
      default:
        return;
    }
  }
}
