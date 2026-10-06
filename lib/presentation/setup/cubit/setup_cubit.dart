
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rally/core/base/base_cubit.dart';
import 'package:rally/core/constant/app_constant.dart';
import 'package:rally/domain/use_case/use_case.dart';
import 'package:rally/presentation/setup/cubit/setup_state.dart';


@singleton
class SetupCubit extends BaseCubit<SetupState, SetupAction, SetupNavigation>{
  SetupCubit(this._useCase) : super(SetupState());

  final EventlyUseCase _useCase;

  @override
  Future<void> doAction(SetupAction action) async{
    switch (action) {

      case ChangeLanguage():
        {
          _changeLanguage(action.language);
        }
      case ChangeThemeMode():{
        _changeThemeMode(action.mode);
      }
      case GoToOnboardingScreen():
        _goToOnboardingScreen();

    }
  }

  void _changeLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void _changeThemeMode(ThemeMode mode){
    emit(state.copyWith(mode: mode));
  }

  Future<void> _goToOnboardingScreen() async{
    await _useCase.saveDataInSharedPreferences(KeysConstant.setupKey, true);
    emitNavigation(NavigateToOnboardingScreen());
  }

}