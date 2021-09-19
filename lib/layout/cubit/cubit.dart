
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens =
  [
    ProtectsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangBottomState());
  }
  HomeModel ? homeModel;
 Map<int,bool> favorites={};
void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url:HOME,
      token:token,
    ).then((value)
    {
      homeModel=HomeModel.fromJason(value.data);
      printFullText(homeModel.toString());
      print(homeModel!.data!.banners[0].image);
      homeModel!.data!.products.forEach((element){
        favorites.addAll(
            {
              element.id!:element.inFavorites!
            }
            );
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    }
    );
}


  CategoriesModel ? categoriesModel;

  void getCategories(){
    DioHelper.getData(
      url:GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    }
    );
  }
  ChangeFavoritesModel ?changeFavoritesModel;

  void changeFavourites(int productId)
  {
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES ,
        data: {
          'product_id':productId,
        },
      lang: 'en',
      token: token,
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }else
        {
          getFavourite();
        }
emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }
    ).catchError((error){
      favorites[productId] =! favorites[productId]!;
      print(error.toString());
      emit(ShopErrorChangeFavoritesState(error));
    });
  }



   FavoritesModel? favoritesModel;

  void getFavourite(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url:FAVORITES,
      token:token,
    ).then((value)
    {
      
      favoritesModel=FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessFavoritesState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorFavoritesState(error));
    }
    );
  }

  ShopLoginModel? userModel;

  void getUserData(){
    emit(ShopLoadingGetProfileState ());
    DioHelper.getData(
      url:PROFILE,
      token:token,
    ).then((value)
    {

      userModel=ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name!);

      emit(ShopSuccessProfileState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProfileState(error));
    }
    );
  }

  //********************************************************************

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      }
    ).then((value)
    {

      userModel=ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProfileState(error));
    }
    );
  }
}