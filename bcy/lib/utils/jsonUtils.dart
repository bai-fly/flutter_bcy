import 'dart:convert';
class JsonUtils{
  static String toJson(data){
    return JsonEncoder().convert(data);
  }
  static toObject<T>(jsonStr){
    T t= JsonDecoder().convert(jsonStr);
    return t;
  }
}