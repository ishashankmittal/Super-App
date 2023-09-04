import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_app/config.dart';

class RecipesHome extends StatefulWidget {
  const RecipesHome({super.key});

  @override
  State<RecipesHome> createState() => _RecipesHomeState();
}

class _RecipesHomeState extends State<RecipesHome> {
  TextEditingController textEditingController=new TextEditingController();
  final apiKey=AppConfig.applicationKey;
  final apiId=AppConfig.applicationId;
  Future<void> getRecipes(String query) async {
    final String url =
        "https://api.edamam.com/search?q=$query&app_id=$apiId&app_key=$apiKey";

    final Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // Handle the successful response here
        print("Response body: ${response.body}");
      } else {
        // Handle any error response here
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any network or HTTP request error here
      print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.1, 0.3, 0.5, 0.9],
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    Colors.indigo[800]!,
                    Colors.indigo[700]!,
                    Colors.indigo[600]!,
                    Colors.indigo[400]!,
                  ],
              )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30,),
                Text("What will you cook today?",style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
                SizedBox(height: 8,),
                Text("Just enter the ingredients and we show the best recipe for you!",style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Enter Ingredients",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width:16,),
                      InkWell(
                        onTap: (){
                          if(textEditingController.text.isNotEmpty){
                            getRecipes(textEditingController.text);
                            print("Just Do It!");
                          }else{
                            print("Not Do It!");
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
