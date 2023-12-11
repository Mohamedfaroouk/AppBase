import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/shared/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/are_u_sure_dialog.dart';
import '../../../../shared/widgets/two_part_text.dart';
import '../../cubit/cubit.dart';
import '../../domain/model/client_model.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    final cubit = ClientCubit.get(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          )),
      child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  runSpacing: 10,
                  spacing: 25,
                  children: <Widget>[
                    TwoPartsText(
                      title: 'clientName'.tr(),
                      value: client.name ?? '',
                    ),
                    TwoPartsText(
                      title: 'taxNumber'.tr(),
                      value: client.taxNumber ?? '',
                    ),
                    TwoPartsText(
                      title: 'phone'.tr(),
                      value: client.phone ?? '',
                    ),
                    TwoPartsText(
                      title: 'address'.tr(),
                      value: client.address ?? '',
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  SmallButton(
                    title: 'edit'.tr(),
                    onTap: () {
                      NavigationService.pushNamed(Routes.editClient, extra: {'client': client});
                    },
                    background: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (Utils.user?.userType == 0)
                    SmallButton(
                      title: 'delete'.tr(),
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AreYouSureDialog(
                              title: 'areYouSureDeleteClient'.tr(),
                              onConfirm: () {
                                Navigator.pop(context);
                                cubit.delete(id: client.id ?? 0);
                              })),
                      background: AppColors.error,
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
