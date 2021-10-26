import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/post.dart';

void main() {
  runApp(MaterialApp(home: Restapi(),
  )
  );
}
class Restapi extends StatefulWidget {
  @override
  _RestapiState createState() => _RestapiState();
}

class _RestapiState extends State<Restapi> {
  late Future<Postlist>data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network =  Network('posts');
    data =  network.loadPosts();            // data is getting stored in data variable
    print (data);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON parsing'),
      ),
     body: Center(
       child: Container(
         child: FutureBuilder(
           future: data,
           builder: (context, AsyncSnapshot<Postlist> snapshot)
           {
             List<Post> allPosts;
             if(snapshot.hasData)
               {
                 allPosts = snapshot.data!.posts;
                 return createView(allPosts, context);
               }else
                 {
                   return CircularProgressIndicator();
                 }
           }
         ),
       ),
     ),
    );
  }
  Widget createView(List<Post>data, BuildContext context){
    return Container(
      child: ListView.builder(itemCount:data.length,itemBuilder: (context, int index)
    {
      return Column(
        children: [
          ListTile(
            title: Text('${data[index].userId}'),
            subtitle: Text('${data[index].body}'),
            leading: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 24.0,
                  child: Text('${data[index].id}'),
                )
              ],
            ),
          )
        ],
      );
    }
      ),
    );
  }
}
class Network{
  final String url;

  Network(this.url);
  Future<Postlist> loadPosts() async{
    final response =  await http.get(Uri.https('jsonplaceholder.typicode.com', url));
    if (response.statusCode == 200)
      {
        print(response.body);
        return Postlist.fromJson(json.decode(response.body));
      }else
        {
          throw Exception('failed to get post');
        }
  }

}
