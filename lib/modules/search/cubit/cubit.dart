import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/state.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/network/end_points.dart';
class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel ;

  void search({
    required String text ,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      lang: 'en',
      data:
      {
        'text':text,
      },
      token: token ,
    ).then((value)
    {

      searchModel = SearchModel.fromJson(value.data);


      emit(SearchSuccessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(SearchErrorState(error.toString()),);
    });
  }
}