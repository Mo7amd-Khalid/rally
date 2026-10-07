
import 'package:injectable/injectable.dart';
import 'package:rally/core/base/base_cubit.dart';
import 'package:rally/data/network/results.dart';
import 'package:rally/domain/use_case/auth_use_case.dart';
import 'package:rally/presentation/forget_password/cubit/forget_password_contract.dart';

@injectable
class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState, ForgetPasswordAction, ForgetPasswordNavigation>{

  ForgetPasswordCubit(this._useCase) : super(ForgetPasswordState());

  final AuthUseCase _useCase;

  // get navigation => null;
  @override
  Future<void> doAction(ForgetPasswordAction action) async{
    switch (action) {

      case SendPasswordResetEmailAction():
        _sendPasswordResetEmail(action.email);
    }
  }

  Future<void> _sendPasswordResetEmail(String email) async{
    emitNavigation(ShowDialogLoadingNavigation());
    var response = await _useCase.sendPasswordResetEmail(email);
    switch (response) {
      case Success<void>():
        {
          emitNavigation(ShowDialogSuccessNavigation());
        }
      case Failure<void>():
        {
          emitNavigation(ShowDialogFailedNavigation(response.message));
        }
    }
  }

}