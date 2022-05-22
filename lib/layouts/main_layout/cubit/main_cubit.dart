import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layouts/main_layout/cubit/main_states.dart';
import 'package:path/path.dart';
import 'package:project/shared/network/local/cash_helper.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit() : super(InitState());

  static MainCubit get(context)=> BlocProvider.of(context);

  var addTextController=TextEditingController();
  var editTextController = TextEditingController();


//database dealing ---------------------------------------------------------------------------------

  initSql() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              '''CREATE TABLE Posts 
              (id INTEGER PRIMARY KEY,
               name TEXT
                )''');
        });

  }

  List<Map> postsList=[];

  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');
    Database database = await openDatabase(path);

   await database.rawQuery('SELECT * FROM Posts').then((value){
     postsList=value;
     emit(GetDataSuccessState());
   }).catchError((onError){
     emit(GetDataErrorState());
     print(onError.toString());
   });

    database.close();
  }

  insertData(String name) async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');
    Database database = await openDatabase(path);

    await database.rawInsert(
        'INSERT INTO Posts(name) VALUES(?)',
        ['$name']).then((value){
          emit(InsertDataSuccessState());
    }).catchError((onError){
          emit(InsertDataErrorState());
          print(onError.toString());

    });
database.close();
  }

  removeData(id) async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');
    Database database = await openDatabase(path);

    await database
        .rawDelete('DELETE FROM Posts WHERE id = ?',
        ['$id']).then((value) {
          emit(RemoveDataSuccessState());
    }).catchError((onError){
      emit(RemoveDataErrorState());
      print(onError.toString());

    });

  }

  updateCategory(name,  id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'posts.db');
    Database db = await openDatabase(path);
    await db.rawUpdate(
        ' UPDATE Posts SET name = ? WHERE id = ? ',
        [name, id]).then((value) {
      print(value.toString());
      emit(UpdateDataSuccessState ());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateDataErrorState());
    });
    await db.close();
  }

  //change mode -------------------------------------------------------------------------------------------

  bool isDarkMode=false;



  void changeMode({bool? fromShared}){
    print('chang mode 1');
    if(fromShared != null){
      isDarkMode=fromShared;
      print('chang mode 2');


    }else {
      isDarkMode = !isDarkMode;
      print('chang mode 3');
    }

    CashHelper.putBool(key: 'isDarkMode', value: isDarkMode).then((value) {
      print('chang mode 4');
      print(CashHelper.getBool(key: 'isDarkMode'));

      emit(ChangeModeSuccessState());

    });


  }








}