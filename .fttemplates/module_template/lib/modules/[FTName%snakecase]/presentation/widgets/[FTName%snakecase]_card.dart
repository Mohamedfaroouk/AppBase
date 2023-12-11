import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/shared/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/are_u_sure_dialog.dart';
import '../../../../shared/widgets/two_part_text.dart';
import '../../cubit/cubit.dart';
import '../../domain/model/<FTName | snakecase>_model.dart';

class <FTName | pascalcase>Card extends StatelessWidget {
  const <FTName | pascalcase>Card({
    Key? key,
    required this.<FTName | camelcase>,
  }) : super(key: key);

  final <FTName | pascalcase> <FTName | camelcase>;

  @override
  Widget build(BuildContext context) {
    final cubit = <FTName | pascalcase>Cubit.get(context);
    return
    Card(
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
                title: '<FTName | camelcase>Name'.tr(),
                value: <FTName | camelcase>.name ?? '',
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
                      NavigationService.pushNamed(Routes.edit<FTName | pascalcase>,
                      extra: {'<FTName | camelcase>': <FTName | camelcase>}
                      );
                    },
                    background: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SmallButton(
                    title: 'delete'.tr(),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AreYouSureDialog(
                            title: 'areYouSureDelete<FTName | pascalcase>'.tr(),
                            onConfirm: () {
                              Navigator.pop(context);
                              cubit.delete(id: <FTName | camelcase>.id ?? 0);
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

