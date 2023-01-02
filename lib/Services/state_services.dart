import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/world_states_model.dart';
import 'Utilities/app_url.dart';


class StatesServices{

  Future<WorldStatesModel> fetchWorldStates() async{
    final response=await http.get(Uri.parse(AppUrl.worldUrl));


    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else
      {
        throw Exception('Error');
      }


  }

  Future<List<dynamic>> countriesListApi() async{

    var data;

    final response=await http.get(Uri.parse(AppUrl.countryList));


    print('get api');

    if(response.statusCode==200){
      data = jsonDecode(response.body);

return data;
       } else
    {
      return data;
    }
  }
}