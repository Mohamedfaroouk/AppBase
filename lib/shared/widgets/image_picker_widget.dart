import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:flutter/material.dart';

import '../../core/services/media.dart';
import '../../core/utils/Utils.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.onChange, this.image});
  final Function(File) onChange;
  final String? image;
  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
                width: 150,
                height: 150,
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.black38, width: 1)),
                  child: image == null
                      ? Image.network(
                          widget.image ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, exception, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 1,
                  clipBehavior: Clip.hardEdge,
                  shape: const CircleBorder(),
                  color: AppColors.primary,
                  child: InkWell(
                    onTap: () async {
                      final file = await MediaService().pickFile();
                      if (file != null) {
                        //validate image Size
                        double mb = Utils.getSizeOfFile(file);

                        if (mb > 2) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("imageSizeValidate".tr())));
                          return;
                        }
                        image = file;
                        setState(() {});
                        widget.onChange(file);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 29),
                    ),
                  ),
                ))
          ],
        ),
        const SizedBox(height: 3),
        Text("imageSizeValidate".tr())
      ],
    );
  }
}
