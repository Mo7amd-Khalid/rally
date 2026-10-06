
import 'package:injectable/injectable.dart';
import 'package:rally/core/base/base_cubit.dart';
import 'package:rally/core/constant/app_constant.dart';
import 'package:rally/domain/use_case/use_case.dart';
import 'package:rally/presentation/onboarding/cubit/onboarding_state.dart';

@injectable
class OnboardingCubit extends BaseCubit<OnboardingState, OnboardingActions, OnboardingNavigation>{
  OnboardingCubit(this._useCase) : super(OnboardingState());

  final EventlyUseCase _useCase;
  @override
  Future<void> doAction(OnboardingActions action) async{
    switch (action) {

      case ChangeIndex():{
        _changeIndex(action.index);
      }
      case GoToLoginScreen():{
        _goToLoginScreen();

      }
    }
  }

  void _changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> _goToLoginScreen() async{
    await _useCase.saveDataInSharedPreferences(KeysConstant.onboardingKey, true);
    emitNavigation(NavigateToLoginScreen());
  }


}