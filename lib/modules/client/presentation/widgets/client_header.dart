import 'package:flutter/material.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/searchfeild.dart';
import '../../cubit/cubit.dart';

class ClientHeader extends StatelessWidget {
  const ClientHeader({
    super.key,
    required this.cubit,
  });

  final ClientCubit cubit;

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
            NavigationService.pushNamed(Routes.addClient).then((value) {
              cubit.pagingController.refresh();
            });
          },
        )
      ],
    );
  }
}
