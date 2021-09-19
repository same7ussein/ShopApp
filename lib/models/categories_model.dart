class CategoriesModel
{
  bool? status ;
  CategoriesDataModel? data ;

  CategoriesModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'] ;
    data = CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel
{
  int? currentPag;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String , dynamic> json)
  {
    currentPag = json['current_page'] ;
    json['data'].forEach((element)
    {
      data.add(DataModel.fromJson(element));
    });
  }

}


class DataModel {
  int? id ;
  String? name;
  String? image;

  DataModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'] ;
    name = json['name'] ;
    image = json['image'] ;
  }

}