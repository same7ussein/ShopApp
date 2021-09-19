import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangBottomState extends ShopStates {}
/// get Home Data states
class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates
{
  final String error;

  ShopErrorHomeDataState(this.error);
}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates
{
  final String error;

  ShopErrorCategoriesState(this.error);
}
class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates
{
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}
/// Favorites States
class ShopSuccessFavoritesState extends ShopStates {}
class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopErrorFavoritesState extends ShopStates
{
  final String error;

  ShopErrorFavoritesState(this.error);
}

/// Profile States
class ShopSuccessProfileState extends ShopStates {
}
class ShopLoadingGetProfileState extends ShopStates {}
class ShopErrorProfileState extends ShopStates
{
  final String error;

  ShopErrorProfileState(this.error);
}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopLoadingUpdateUserState extends ShopStates {}
class ShopErrorUpdateUserState extends ShopStates
{
  final String error;

  ShopErrorUpdateUserState(this.error);
}


