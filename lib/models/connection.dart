import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:project2/models/user_model.dart';
import 'package:project2/screens/navigationcontroller.dart';

// Connection Constants

const Mongo_url = "mongodb+srv://project2:project2@pickabookdata.es9jtrh.mongodb.net/pickabook?retryWrites=true&w=majority";

// Collections
const userdata = "Users";
const books = "bookdata";

final Fireuser = FirebaseAuth.instance.currentUser!;




class MongoDatabase{

  static var db, userCollection, bookCollection;

  static connect() async{

    db = await Db.create(Mongo_url);

    await db.open();
    inspect(db);
    bookCollection = db.collection(books);
    userCollection = db.collection(userdata);
  }

  // Functions

  static Future<String> adduser(Usermap data) async{
    try{
      var results = await userCollection.insertOne(data.toJson());
      if(results.isSuccess){
        return "data inserted";
      }
      else{
        return "Something went wrong";
      }
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> fetchbooks() async
  {
    final result = await bookCollection.find(where.eq('book_average_rating', 3.5).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchnewbooks() async
  {
    final result = await bookCollection.find(where.gte('publication_year',2017).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchtopratedbooks() async
  {
    final result = await bookCollection.find(where.gte('book_average_rating',4.8)).toList();
    return result;
  }
  static Future<List<Map<String, dynamic>>> fetchtrendbooks() async
  {
    final result = await bookCollection.find(where.gte('book_average_rating',4).gte('ratings_count', 1000).limit(100)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchmarvelbooks() async
  {
    final result = await bookCollection.find(where.eq("publisher","Marvel")).toList();
    return result;
  }


  static Future<List<Map<String, dynamic>>> fetchRomancebooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Romance").limit(50)).toList();
    return result;
  }
  static Future<List<Map<String, dynamic>>> fetchComicbooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Comic").gte('book_average_rating', 4).ne('publisher','Marvel' ).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchComicwithMarvelbooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Comic").gte('book_average_rating', 4).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchMysterybooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Mystery Thriller & Crime").gte('book_average_rating', 4).ne('publisher','Marvel').limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchFantbooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Fantasy & Paranormal").gte('book_average_rating', 4).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchYoungadultbooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Young Adult").gte('book_average_rating', 4).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchscholasticbooks() async
  {
    final result = await bookCollection.find(where.eq('publisher','Scholastic Inc').gt('book_average_rating', 3.7).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchChildrenbooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Children").gt('book_average_rating', 3.6).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchfantasybooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Fantasy & Paranormal").gt('book_average_rating', 3.6).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchHistorybooks() async
  {
    final result = await bookCollection.find(where.eq("genre","History & Biography").gt('book_average_rating', 3.6).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

  static Future<List<Map<String, dynamic>>> fetchPoetrybooks() async
  {
    final result = await bookCollection.find(where.eq("genre","Poetry").gt('book_average_rating', 3.6).gt('ratings_count', 500).limit(50)).toList();
    return result;
  }

      // .eq("genre","Poetry").gt('book_average_rating', 3.6).gt('ratings_count', 500).
  static Future<Map<String, dynamic>> fetchUserData() async
  {
    final result = await userCollection.findOne(where.eq("uid", Fireuser.uid));
    return result;
  }



// static Future<String> getName() async{
//   final result = await userCollection.findOne(where.eq("uid", Fireuser.uid));
//   final user_name = result["name"] as String;
//   return user_name;
// }



}