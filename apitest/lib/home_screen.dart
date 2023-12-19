import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:apitest/Models/PostsModel.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostsModel> postList =[];
  Future<List<PostsModel>> getPostApi() async {
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASHIF'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Text('Loading');
                  }
                  else{
                      return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Serial No: ${postList[index].id}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff008000),
                                ),),
                                const Text('Title: ',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                ),),
                                Text(postList[index].title.toString()),
                                const Text('Description: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),),
                                Text(postList[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                  }
                }),
          )
        ],
      ),
    );
  }
}
