import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:appbase/core/data_source/hive_service.dart';

import 'buttons.dart';
import 'customtext.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({
    super.key,
    required this.notifications,
  });
  final List<Map<String, dynamic>> notifications;
  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  int currentPage = 1;
  int lastPage = 1;
  @override
  void initState() {
    lastPage = widget.notifications.length;
    super.initState();
  }

  @override
  void dispose() {
    HiveService.clearNotifications();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomText(
                  "new_notification".tr(),
                  fontSize: 20,
                  align: TextAlign.center,
                ),
              ),
              const Spacer(),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xfff4f4f4),
            elevation: 0,
            child: Column(
              children: <Widget>[
                Column(children: <Widget>[
                  if (widget.notifications.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: currentPage == 1
                                      ? null
                                      : () {
                                          currentPage--;
                                          setState(() {});
                                        },
                                  icon: const Icon(Icons.keyboard_arrow_right)),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    "$currentPage  ",
                                    align: TextAlign.center,
                                    fontSize: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    "from".tr(),
                                    align: TextAlign.center,
                                    fontSize: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    " $lastPage",
                                    align: TextAlign.center,
                                    fontSize: 15,
                                  ),
                                ],
                              )),
                              IconButton(
                                  onPressed: currentPage == lastPage
                                      ? null
                                      : () {
                                          currentPage++;
                                          setState(() {});
                                        },
                                  icon: const Icon(Icons.keyboard_arrow_left)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (widget.notifications.isNotEmpty)
                    SizedBox(
                      child: CustomText(
                        widget.notifications[currentPage - 1]["title"] ?? "",
                        fontSize: 15,
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(
                    child: CustomText(
                      widget.notifications[currentPage - 1]["body"] ?? "",
                      fontSize: 15,
                      align: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )

                  // if (widget.notifications.isNotEmpty)
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              Expanded(
                  child: DefaultButton(text: "ok".tr(), onTap: () async {})),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
