import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/utils/Utils.dart';
import 'package:efatorh/modules/client/domain/model/client_model.dart';
import 'package:efatorh/modules/client/presentation/widgets/client_card.dart';
import 'package:efatorh/modules/client/presentation/widgets/client_header.dart';
import 'package:efatorh/shared/widgets/errorWidget.dart';
import 'package:efatorh/shared/widgets/myLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../layout/presentation/widgets/notification_icon.dart';
import '../cubit/cubit.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientCubit()..addPageListers(),
      child: Builder(builder: (context) {
        final cubit = ClientCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Utils.drawer().currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              actions: const [NotificationIcon()],
              title: Text('clients'.tr()),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ClientHeader(cubit: cubit),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.pagingController.refresh();
                      },
                      child: PagedGridView(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 600, mainAxisExtent: 200),
                        pagingController: cubit.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Client>(
                          firstPageProgressIndicatorBuilder: (context) =>
                              Center(
                            child: MyLoading.loadingWidget(),
                          ),
                          noItemsFoundIndicatorBuilder: (context) => Center(
                            child: Text('noClients'.tr()),
                          ),
                          firstPageErrorIndicatorBuilder: (context) =>
                              ErrorWidgetWithTryAgain(
                            onTryAgain: () {
                              cubit.pagingController.refresh();
                            },
                          ),
                          itemBuilder: (context, item, index) {
                            return ClientCard(
                              client: item,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      }),
    );
  }
}
