import 'package:go_router/go_router.dart';

import '../../../core/Router/Router.dart';
import '../presentation/client.dart';
import '../presentation/edit_add/edit_add_client.dart';

abstract class ClientRouter {
  static final routes = GoRoute(
      parentNavigatorKey: mobileRouteKey,
      path: "/clients",
      name: Routes.client,
      pageBuilder: (context, state) => Routes.pageBuilder(context, state, child: const ClientScreen()),
      routes: [
        GoRoute(
          path: "add",
          name: Routes.addClient,
          pageBuilder: (context, state) => Routes.pageBuilder(context, state, child: const EditAddClient()),
        ),
        GoRoute(
          path: "edit",
          name: Routes.editClient,
          redirect: (context, state) {
            state.extra == null ? Routes.client : null;
            return null;
          },
          pageBuilder: (context, state) => Routes.pageBuilder(
            context,
            state,
            child: EditAddClient(
              client: (state.extra as Map?)?['client'],
            ),
          ),
        ),
      ]);
}
