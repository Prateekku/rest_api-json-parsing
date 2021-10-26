class Postlist{             //grabs the value
  final List<Post> posts;

  Postlist(this.posts);
  factory Postlist.fromJson(List<dynamic> parsedJson)
  {
    List<Post> posts =  <Post>[];
    posts = parsedJson.map((data) =>        //data will be fetched one by one
      Post.fromjson(data)).toList();
    return  Postlist(posts);

  }
}

class Post
{
  int userId;
  int id;
  String title;
  String body;

  Post({required this.userId,required this.id,required this.title, required this.body});
   factory Post.fromjson(Map<String, dynamic> json)
   {
     return Post(userId: json['userId'],                   // return the value
         id: json['id'],
         title: json['title'],
         body: json['body']);
   }

}