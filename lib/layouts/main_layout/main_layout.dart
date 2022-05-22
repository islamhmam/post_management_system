import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layouts/main_layout/components/post_item.dart';
import 'package:project/layouts/main_layout/cubit/main_cubit.dart';
import 'package:project/layouts/main_layout/cubit/main_states.dart';

class MainLayout extends  StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit , MainStates>(
      listener: (context, state) {

      },
      builder: (context, state ){
        return Scaffold(
          backgroundColor: MainCubit.get(context).isDarkMode?   Colors.blue[600]:Colors.white,
          appBar: AppBar(
            elevation: 0,
            title:  Text(
              'POSTS',
              style: TextStyle(
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                color: MainCubit.get(context).isDarkMode?
                Colors.grey[300]:Colors.white,
                fontSize: 37,
              ),
            ),
            actions: [
              InkWell(
                onTap: () async{

                  MainCubit.get(context).changeMode();

                },
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.brightness_4_outlined,
                    size: 30,
                    color: MainCubit.get(context).isDarkMode?
                    Colors.grey[300]:Colors.white,

                  ),
                ),
              )
            ],
            backgroundColor: MainCubit.get(context).isDarkMode?
            Colors.blue[900]:Colors.blue[700],
          ),
          body: ListView.builder(
            itemCount: MainCubit.get(context).postsList.length,
            itemBuilder:(context , index)=>postItem(context,
                MainCubit.get(context).postsList[index]['id'],
                MainCubit.get(context).postsList[index]['name'],
            ),

          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: (){
              showDialog(context: context,
                  builder: (_)=>AlertDialog(
                    backgroundColor: MainCubit.get(context).isDarkMode?   Colors.blue:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                    content: Container(
                      height: 140,
                      child: Column(
                        children: [
                          SizedBox(height: 8,),
                          Container(
                            color: Colors.blue[900],
                            height: 30,
                            child: const Center(
                              child: Text('Write your Post:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: MainCubit.get(context).addTextController,
                            decoration:InputDecoration(
                              filled: true,
                              fillColor: MainCubit.get(context).isDarkMode?
                              Colors.grey[300]:Colors.white,

                              label: Text('Write Here...'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ) ,

                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(Colors.red)
                                    ),
                                    onPressed: (){
                                      MainCubit.get(context)
                                          .insertData(
                                          MainCubit.get(context).addTextController
                                          .text.toString(),
                                      );
                                      MainCubit.get(context).addTextController
                                          .text='';
                                      MainCubit.get(context).getData();
                                      Navigator.pop(context);

                                    },
                                    child: Text('ADD')
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(Colors.teal[900])
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);

                                    },
                                    child: Text('Cancel')
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  )

              );

            },
            child: Icon(Icons.add,
              size: 33,
              color: Colors.white,
            ),
          ),
        );

      },

    );

  }
}
