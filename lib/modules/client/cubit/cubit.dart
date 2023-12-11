import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/utils/alerts.dart';
import 'package:efatorh/modules/client/domain/model/client_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/data_source/dio.dart';
import '../../../core/utils/injection.dart';
import '../domain/repository/repository.dart';
import 'states.dart';

class ClientCubit extends Cubit<ClientStates> {
  ClientCubit() : super(ClientInitial());
  static ClientCubit get(context) => BlocProvider.of(context);

  ClientRepository clientRepository = ClientRepository(locator<DioService>());
  String search = "";
  PagingController<int, Client> pagingController = PagingController<int, Client>(firstPageKey: 1);

  fetchPage({required int pageKey, bool withSearch = true}) async {
    var newList = await clientRepository.list(params: {"search": search, "page": pageKey});

    if (newList != null) {
      var isLastPage = newList.lastPage == pageKey;

      if (isLastPage) {
        // stop
        pagingController.appendLastPage(newList.clients ?? []);
      } else {
        // increase count to reach new page
        var nextPageKey = pageKey + 1;
        pagingController.appendPage(newList.clients ?? [], nextPageKey);
      }
    } else {
      pagingController.error = "error";
    }
  }

  addPageListers() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(
        pageKey: pageKey,
      );
    });
  }

  // delete
  delete({required int id}) async {
    final response = await clientRepository.delete(id: id);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
      pagingController.refresh();
    }
  }

  // store

  Future store({required Client client}) async {
    final response = await clientRepository.store(client: client);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
      NavigationService.pop(client);
    }
    return null;
  }

  Future update({required Client client}) async {
    final response = await clientRepository.update(client: client);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
      NavigationService.pop(Client.fromJson(response["data"]));
    }
    return null;
  }

  @override
  Future<void> close() {
    print("clooose");
    pagingController.dispose();
    return super.close();
  }

  @override
  void emit(ClientStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
