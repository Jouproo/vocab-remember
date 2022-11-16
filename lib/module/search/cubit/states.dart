

abstract class AppSearchStates{

}

class SearchInitialState extends AppSearchStates{}


class AppGetSWordSuccessState extends AppSearchStates {}



class AppGetSWordErrorState extends AppSearchStates
{
  final String error;

  AppGetSWordErrorState(this.error);
}
