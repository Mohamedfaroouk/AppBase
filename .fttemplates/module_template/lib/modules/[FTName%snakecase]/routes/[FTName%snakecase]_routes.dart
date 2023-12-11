import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/Router/Router.dart';
import '../cubit/cubit.dart';
import '../presentation/<FTName | camelcase>.dart';
import '../presentation/edit_add/edit_add_<FTName | camelcase>.dart';

abstract class <FTName | pascalcase>Router {
  static final routes =  GoRoute(
                parentNavigatorKey: layoutRouteKey,

            path: "/<FTName | camelcase>",
            name: Routes.<FTName | camelcase>,
            pageBuilder: (context, state) => Routes.pageBuilder(context, state, child: const <FTName | pascalcase>Screen()),
            routes: [
              GoRoute(
                parentNavigatorKey: layoutRouteKey,

                path: "add",
                name: Routes.add<FTName | pascalcase>,
                pageBuilder: (context, state) => Routes.pageBuilder(context, state, child: const EditAdd<FTName | pascalcase>()),
              ),
              GoRoute(
                parentNavigatorKey: layoutRouteKey,

                path: "edit",
                name: Routes.edit<FTName | pascalcase>,
                pageBuilder: (context, state) => Routes.pageBuilder(
                  context,
                  state,
                  child: EditAdd<FTName | pascalcase>(
                    <FTName | camelcase>: (state.extra as Map?)?['<FTName | camelcase>'],
                  ),
                ),
              ),
            ]);

      // routes

//  static const String <FTName | camelcase> = "/<FTName | camelcase>";
//   static const String add<FTName | pascalcase> = "/add<FTName | pascalcase>";
//   static const String edit<FTName | pascalcase> = "/edit<FTName | pascalcase>";
}
