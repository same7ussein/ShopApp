import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/web_view/web_view.dart';
import 'package:shop_app/shared/styles/color.dart';
Widget myDivider() => Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);

void navigateTo(context,widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route)=>false
);
void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
///build search and favorites

Widget buildListProducts( model,context , {bool isOldPrice = false}) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(model['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Container(

      height: 120.0,

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          Stack(

            alignment: AlignmentDirectional.bottomStart,

            children: [

              Image(

                image: NetworkImage('${model.image}'),

                height: 120.0,

                // fit: BoxFit.cover,

                width: 120.0,

              ),



              ///if discount == 0 Hide and opposite

              if (model.discount != 0 && isOldPrice)

                Container(

                  padding: EdgeInsets.symmetric(horizontal: 5),

                  color: Colors.red,

                  child: Text(

                    'DISCOUNT',

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 9,

                    ),

                  ),

                ),

            ],

          ),

          const SizedBox(

            width: 20,

          ),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  '${model.name}',

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(

                      height: 1.1,

                      color: Colors.black,

                      fontWeight: FontWeight.w700),

                ),

                Spacer(),

                Row(

                  children: [

                    Text(

                      '${model.price}',

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(

                        color: defaultColor,

                      ),

                    ),

                    const SizedBox(

                      width: 10,

                    ),



                    /// if discount == 0 Hide and opposite

                    if (model.discount != 0 && isOldPrice)

                      Text(

                        '${model.oldPrice}',

                        maxLines: 2,

                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(

                            color: Colors.grey,

                            fontWeight: FontWeight.w700,

                            decoration: TextDecoration.lineThrough),

                      ),

                    Spacer(),

                  ],

                ),

              ],

            ),

          ),

        ],

      ),

    ),

  ),
);
