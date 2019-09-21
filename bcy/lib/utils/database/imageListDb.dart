import 'DB.dart';

class ImageListDb{
  static const String _tableName='imageList';
  static Future<List<String>> getListByBaseUrl(String baseUrl) async {
    var db = await DB.getDb();
    // await db.query('select image from imageList where baseUrl = ?',[baseUrl]);
    List<Map> list= await db.query(_tableName,columns:['image'],where:'baseUrl = ?',whereArgs:[baseUrl]);
    await db.close();
    List<String> l=new List();
    for (var item in list) {
      l.add(item['image']);
    }
    return l;
  }
  static Future addListByBaseUrl(String baseUrl,List<String> list) async {
    var db = await DB.getDb();

    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(_tableName,where:'baseUrl = ?',whereArgs:[baseUrl]);
      for (var item in list) {
        var map = new Map<String,String>();
        map['baseUrl']=baseUrl;
        map['image']=item;
        batch.insert(_tableName,map);
      }
      await batch.commit();
    });
    await db.close();
  }
}