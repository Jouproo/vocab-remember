

abstract class AppLoginStates{

}

class LoginInitialState extends AppLoginStates{}

class ChangePasswordVisibilityState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates
{
   final String  uId ;
   AppLoginSuccessState(this.uId);
}

class AppLoginErrorState extends AppLoginStates
{
  final String error;

  AppLoginErrorState(this.error);
}
class AppUserCreateSuccessState extends AppLoginStates
{}

class AppUserCreateErrorState extends AppLoginStates
{
  final String error;

  AppUserCreateErrorState(this.error);
}