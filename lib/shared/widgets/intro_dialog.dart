import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/core/utils/Utils.dart';
import 'package:appbase/shared/widgets/applogo.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:video_player/video_player.dart';

import 'buttons.dart';

class IntroDialog extends StatelessWidget {
  const IntroDialog({super.key, required this.url, required this.isPdf});
  final String url;
  final bool isPdf;
  @override
  Widget build(BuildContext context) {
    log(url);
    return Dialog(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Baseline(
                baselineType: TextBaseline.alphabetic,
                baseline: 20,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Center(
                        child: AppLogo(
                      whiteFont: true,
                    )),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          spreadRadius: 7,
                          blurRadius: 30,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ], borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              ),
              CustomText("welcomeToappbase".tr(),
                  weight: FontWeight.w500, color: Colors.black, fontSize: 20),
              const Divider(),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText("userGuidNote".tr(),
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                        child: DefaultButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      text: "userGuid".tr(),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AppIntroPreview(isPdf: isPdf, url: url)));
                      },
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: DefaultButtonOutLined(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      text: "skip".tr(),
                      color: AppColors.primary,
                      onTap: () {
                        Utils.pref().userGuid = true;
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppIntroPreview extends StatefulWidget {
  const AppIntroPreview({super.key, required this.url, required this.isPdf});
  final String url;
  final bool isPdf;
  @override
  State<AppIntroPreview> createState() => _AppIntroPreviewState();
}

class _AppIntroPreviewState extends State<AppIntroPreview> {
  // check url if pdf or video
  // bool isPdf() {
  //   final check = widget.url.split('.').last;
  //   if (check == 'pdf') {
  //     return true;
  //   }
  //   return false;
  // }

  late ChewieController _chewieController;
  late VideoPlayerController videoPlayerController;
  bool loading = true;
  @override
  void initState() {
    log(widget.url);
    if (widget.isPdf) {
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        widget.url,
      ));
      videoPlayerController.initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
        );
        setState(() {
          loading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText("دليل استخدام التطبيق"),
          elevation: 0,
        ),
        body: widget.isPdf
            ? const PDF().cachedFromUrl(widget.url,
                placeholder: (double progress) => Center(
                        child: CircularProgressIndicator(
                      value: progress / 100,
                    )),
                errorWidget: (dynamic error) =>
                    Center(child: CustomText(error.toString())))
            : Center(
                child: loading
                    ? const CircularProgressIndicator()
                    : AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController)),
              ));
  }
}
