
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class ChangeShowDefinition extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class ChangeFavoriteState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppCreateWordLoadingState extends AppStates {}

class AppCreateWordSuccessState extends AppStates {}

class AppCreateWordErrorState extends AppStates {
  String ? error ;
  AppCreateWordErrorState(this.error);

}

class AppCreateWordImageLoadingState extends AppStates {}

class AppCreateWordImageSuccessState extends AppStates {}

class AppCreateWordImageErrorState extends AppStates {}

class AppGetNameSuccessState extends AppStates {}

class AppGetWordSuccessState extends AppStates {}

class AppGetWordErrorState extends AppStates {}

class AppRemoveWordSuccessState extends AppStates {}

class AppRemoveWordErrorState extends AppStates {}

class ChangeSearchState extends AppStates {}

class ChangeSettingState extends AppStates {}

class SinOutSuccessState extends AppStates {}

class SinOutErrorState extends AppStates {

  String error ;
  SinOutErrorState(this.error);
}

class AppImagePickedSuccessState extends AppStates {}

class AppImagePickedErrorState extends AppStates {}

class SocialRemovePostImageState extends AppStates {}
