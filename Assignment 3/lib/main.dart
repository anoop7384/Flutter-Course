import 'package:flutter/material.dart';
import 'package:flutter_tut/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tut/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Login(),
    );
  }
}

class RemoteService {
  Future<List<Result>?> getTrendingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=8c692efc1e229d91375320c81f8b7bd7&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }

  Future<List<Result>?> getTopRatedMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=8c692efc1e229d91375320c81f8b7bd7&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }

  Future<List<Result>?> getNowPlayingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=8c692efc1e229d91375320c81f8b7bd7&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Result>? trending;
  List<Result>? topRated;
  List<Result>? nowPlaying;
  var isLoaded = false;
  var isLoaded2 = false;
  var isLoaded3 = false;
  String imgURL = 'https://image.tmdb.org/t/p/w500';
  String searchURL =
      'https://api.themoviedb.org/3/search/movie?8c692efc1e229d91375320c81f8b7bd7';

  @override
  void initState() {
    super.initState();

    getTrending();
    getRated();
    getPlaying();
  }

  getTrending() async {
    trending = (await RemoteService().getTrendingMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  getRated() async {
    topRated = (await RemoteService().getTopRatedMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded2 = true;
      });
    }
  }

  getPlaying() async {
    nowPlaying = (await RemoteService().getNowPlayingMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded3 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Visibility(
          visible: isLoaded3,
          replacement: const Center(

            child: CircularProgressIndicator(
            ),

          ),
          child: SingleChildScrollView(
            child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 260,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          title: TextField(
                            // controller: controller,
                            style: TextStyle(color: Colors.white),
                            // onChanged: (value) => result = value,
                            decoration: InputDecoration(
                              hintText: "What's New",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                          tileColor: Colors.grey,
                          textColor: Colors.white,
                          leading: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(), //<-- SEE HERE
                            padding: EdgeInsets.all(10),
                          ),
                          child: const Icon(Icons.search))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Trending Movies",
                        style: TextStyle(fontSize: 28),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // Horizontal ListView
                    // width: 180,
                    height: 240,

                    child: ListView.builder(
                      itemCount: trending?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            alignment: Alignment.center,
                            // color: Colors.blue[(index % 9) * 100],
                            width: 150,
                            child: Column(
                              children: [
                                Image.network(
                                  imgURL + trending![index].posterPath,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(trending![index].title)
                              ],
                            )
                            // Text(trending![index].title),

                            );
                      },
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Top Rated Movies",
                          style: TextStyle(fontSize: 28))),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // Horizontal ListView
                    height: 240,
                    child: ListView.builder(
                      itemCount: topRated?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            alignment: Alignment.center,
                            // color: Colors.blue[(index % 9) * 100],
                            width: 150,
                            child: Column(
                              children: [
                                Image.network(
                                  imgURL + topRated![index].posterPath,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(topRated![index].title)
                              ],
                            )
                            // Text(trending![index].title),

                            );
                      },
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("Now Playing", style: TextStyle(fontSize: 28))),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // Horizontal ListView
                    height: 240,
                    child: ListView.builder(
                      itemCount: nowPlaying?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            alignment: Alignment.center,
                            // color: Colors.blue[(index % 9) * 100],
                            width: 150,
                            child: Column(
                              children: [
                                Image.network(
                                  imgURL + nowPlaying![index].posterPath,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(nowPlaying![index].title)
                              ],
                            )
                            // Text(trending![index].title),

                            );
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text("Logout"))
                ],
              ),
            ),
          ),
        )));
  }
}
