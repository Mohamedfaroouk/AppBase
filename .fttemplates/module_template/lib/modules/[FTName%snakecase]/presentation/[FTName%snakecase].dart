import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/modules/<FTName | snakecase>/domain/model/<FTName | snakecase>_model.dart';
import 'package:efatorh/modules/<FTName | snakecase>/presentation/widgets/<FTName | snakecase>_card.dart';
import 'package:efatorh/modules/<FTName | snakecase>/presentation/widgets/<FTName | snakecase>_header.dart';
import 'package:efatorh/shared/widgets/errorWidget.dart';
import 'package:efatorh/shared/widgets/myLoading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../cubit/cubit.dart';

class <FTName | pascalcase>Screen extends StatefulWidget {
  const <FTName | pascalcase>Screen({Key? key}) : super(key: key);

  @override
  State<<FTName | pascalcase>Screen> createState() => _<FTName | pascalcase>ScreenState();
}

class _<FTName | pascalcase>ScreenState extends State<<FTName | pascalcase>Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  
    BlocProvider(
      create: (context) => <FTName | pascalcase>Cubit()..addPageListers(),
     child:Builder(builder: (context) {
      final cubit = <FTName | pascalcase>Cubit.get(context);
      return Scaffold(
          appBar: AppBar(
            title: Text('<FTName | camelcase>s'.tr()),
          ),
          body: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
          Column(
            children: [
              <FTName | pascalcase>Header(cubit: cubit),
              const SizedBox(
                  height: 10,
                ),
              Expanded(  child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.pagingController.refresh();
                      },
              
              child: PagedGridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 600, mainAxisExtent: 150),
                pagingController: cubit.pagingController,
                builderDelegate: PagedChildBuilderDelegate<<FTName | pascalcase>>(
                                          padding: const EdgeInsets.symmetric(vertical: 20),

                  firstPageProgressIndicatorBuilder: (context) => Center(
                    child: MyLoading.loadingWidget(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => Center(
                    child: Text('no<FTName | pascalcase>s'.tr()),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => ErrorWidgetWithTryAgain(
                    onTryAgain: () {
                      cubit.pagingController.refresh();
                    },
                  ),
                  itemBuilder: (context, item, index) {
                    return <FTName | pascalcase>Card(
                      <FTName | camelcase>: item,
                    );
                  },
                ),
              )))
            ],
          )));
    }));
  }
}
