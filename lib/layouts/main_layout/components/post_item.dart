import 'package:flutter/material.dart';
import 'package:project/layouts/main_layout/cubit/main_cubit.dart';

Widget postItem(context1 ,id,goalName,) =>InkWell(
  onTap: (){
    showDialog(
        barrierDismissible: true,
        context: context1,
        builder: (_) => AlertDialog(
          backgroundColor: MainCubit.get(context1).isDarkMode?   Colors.blue:Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0))),
          content: Builder(
            builder: (context) {
              MainCubit.get(context1).editTextController.text=goalName;
              return Container(
                height: 160,
                // width: double.infinity/1.5,
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue[900],
                      width: double.infinity,
                      height: 30,
                      child: const Center(
                        child: Text('Editting',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 55,
                      child: TextFormField(

                        controller: MainCubit.get(context1).editTextController,
                        validator:(String? val) {
                          if(val!.isEmpty){
                            return 'Write your Post';
                          }
                        },

                        decoration: InputDecoration(
                          label: Text('Write Here....'),
                          floatingLabelBehavior:
                          FloatingLabelBehavior
                              .never,
                          fillColor: MainCubit.get(context).isDarkMode?
                          Colors.grey[300]:Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          contentPadding: const EdgeInsets.all(8),


                        ),


                      ),
                    ),

                    Expanded(

                      child: Align(
                        alignment:  FractionalOffset.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                  MainCubit.get(context1).updateCategory(
                                      MainCubit.get(context1).editTextController.text.toString(),
                                      id);
                                  Navigator.pop(
                                      context);
                                  MainCubit.get(context1).getData();


                                },
                                child: Text('Edit'),
                                style:ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.teal[800]),
                                ) ,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: (){
                                  MainCubit.get(context1).removeData(id);
                                  Navigator.pop(
                                      context);
                                  MainCubit.get(
                                      context1)
                                      .getData();
                                },
                                child: Text('REMOVE'),
                                style:ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                                ) ,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(

                              onPressed: (){

                                Navigator.pop(
                                    context);

                              },
                              child: Text('Cancel'),
                              style:ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                              ) ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );


            },
          ),
        ));

  },
  child:   Container(

    height: 80,

    margin: const EdgeInsets.all(8),

    decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(20),

        boxShadow: const [

          BoxShadow(

              color: Colors.black,

              blurRadius: 5,

              offset: Offset(

                  2,2

              )

          )

        ],

        gradient: LinearGradient(

            begin: Alignment.bottomRight,

            colors: [

              Colors.blue,

              Colors.blue[900]!,



            ]

        )

    ),

    child:  Center(

      child: Text(

        '$id : $goalName',

        style: TextStyle(

            fontSize: 17,

            color: MainCubit.get(context1).isDarkMode?
            Colors.grey[300]:Colors.white,

            fontWeight: FontWeight.w600



        ),

      ),

    ),

  ),
);