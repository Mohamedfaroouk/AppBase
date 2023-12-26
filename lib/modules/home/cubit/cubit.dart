import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio.dart';
import '../../../core/utils/injection.dart';
import '../domain/repository/repository.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  HomeRepository homeRepository = HomeRepository(locator<DioService>());

  @override
  void emit(HomeStates state) {
    if (isClosed) return;

    super.emit(state);
  }
}
