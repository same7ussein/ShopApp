import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data[index].product , context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount:ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
         fallback:(context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );

  }
  Widget buildFavItem(  model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 120.0,
                width: 120,
              ),
              if(model.discount !=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('DISCOUNT',
                    style: TextStyle(
                        fontSize:9.0,
                        color: Colors.white
                    ),),
                ),
            ],
          ),
          SizedBox(width: 20.0,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text
                  (
              '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.1,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount !=0)
                      Text(
                        '${model.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavourites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor: Colors.grey,
                            child: Icon(Icons.favorite_border, size: 14.0,
                              color: Colors.white,))
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
