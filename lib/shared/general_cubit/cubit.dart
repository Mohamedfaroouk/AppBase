import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/shared/data/shared_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efatorh/shared/general_cubit/states.dart';

import '../../core/utils/Utils.dart';

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(GeneralInitial());
  static GeneralCubit get(context) => BlocProvider.of(context);

  changeLang(BuildContext context, Locale locale) {
    context.setLocale(locale);
    Utils.local = locale.languageCode;
    emit(GeneralChangeLangState());
  }

  refreshUserData({bool loading = false}) async {
    final response = await SharedRepository.getUserData(loading: loading);
    if (response != null) {
      Utils.user = response;
      emit(GeneralChangeLangState());
    }
  }
}
