

abstract class AppRegisterStates {}

class AppRegisterInitialState extends AppRegisterStates {}

class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates
{}

class AppRegisterErrorState extends AppRegisterStates
{
  final String error;
  AppRegisterErrorState(this.error);
}
class AppUserCreateSuccessState extends AppRegisterStates
{}

class AppUserCreateErrorState extends AppRegisterStates
{
  final String error;

  AppUserCreateErrorState(this.error);
}

class AppRegisterChangePasswordVisibilityState extends AppRegisterStates {}