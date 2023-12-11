import 'package:efatorh/core/utils/alerts.dart';
import 'package:efatorh/modules/<FTName | snakecase>/domain/model/<FTName | snakecase>_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/data_source/dio.dart';
import '../../../core/utils/injection.dart';
import '../domain/repository/repository.dart';
import 'states.dart';

class <FTName | pascalcase>Cubit extends Cubit<<FTName | pascalcase>States> {
  <FTName | pascalcase>Cubit() : super(<FTName | pascalcase>Initial());
  static <FTName | pascalcase>Cubit get(context) => BlocProvider.of(context);

  <FTName | pascalcase>Repository <FTName | camelcase>Repository = <FTName | pascalcase>Repository(locator<DioService>());
  String search = "";
  PagingController<int, <FTName | pascalcase>> pagingController = PagingController<int, <FTName | pascalcase>>(firstPageKey: 1);

  fetchPage({required int pageKey, bool withSearch = true}) async {
    var newList = await <FTName | camelcase>Repository.list(params: {"search": search, "page": pageKey});

    if (newList != null) {
      var isLastPage = newList.lastPage == pageKey;

      if (isLastPage) {
        // stop
        pagingController.appendLastPage(newList.<FTName | camelcase>s ?? []);
      } else {
        // increase count to reach new page
        var nextPageKey = pageKey + 1;
        pagingController.appendPage(newList.<FTName | camelcase>s ?? [], nextPageKey);
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
    final response = await <FTName | camelcase>Repository.delete(id: id);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
      pagingController.refresh();

    }
  }

  // store

  Future store({required <FTName | pascalcase> <FTName | camelcase>}) async {
    final response = await <FTName | camelcase>Repository.store(<FTName | camelcase>: <FTName | camelcase>);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
            NavigationService.pop();

    }
    return null;
  }

  Future update({required <FTName | pascalcase> <FTName | camelcase>}) async {
    final response = await <FTName | camelcase>Repository.update(<FTName | camelcase>: <FTName | camelcase>);
    if (response != null) {
      Alerts.snack(text: response["message"] ?? "", state: SnackState.success);
            NavigationService.pop();

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
  void emit(<FTName | pascalcase>States state) {
    if (isClosed) return;

    super.emit(state);
  }
}
