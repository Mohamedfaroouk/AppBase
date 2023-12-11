import 'package:flutter/material.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/searchfeild.dart';
import '../../cubit/cubit.dart';

class <FTName | pascalcase>Header extends StatelessWidget {
  const <FTName | pascalcase>Header({
    super.key,
    required this.cubit,
  });

  final <FTName | pascalcase>Cubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            onSearch: (p0) {
              cubit.search = p0;
              cubit.pagingController.refresh();
            },
          ),
        ),
        ButtonIcon(
          icon: Icons.add,
          onTap: () {
            NavigationService.pushNamed(Routes.add<FTName | pascalcase>);
          },
        )
      ],
    );
  }
}
