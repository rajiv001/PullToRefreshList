import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test22list/model/userModel.dart';
import 'package:http/http.dart' as http;


void main() {
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'users List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var jsonList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchUserdata();
    getData();

  }


  // Future<userModel> fetchUserdata() async {
  //   var client = http.Client();
  //
  //   final response = await client.get('https://jsonplaceholder.typicode.com/posts' as Uri);
  //   print("response here >>>> ");
  //   print(response);
  //   if (response.statusCode == 200) {
  //
  //     return userModel.fromJson((response.body) as Map<String, dynamic>);
  //
  //
  //   } else {
  //     throw Exception('Failed to load stations');
  //   }
  // }

  Future getData() async {
    try {
      var response = await Dio()
          .get('https://jsonplaceholder.typicode.com/posts');
      print(response);
      if(response.statusCode == 200){

        setState(() {
          jsonList = response.data as List;

        });

        print("jsonList.length  ???>>>>> ");

        print(jsonList.length);

      }else{

      }
      return jsonList;
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: (jsonList == null) ? 0 : jsonList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                    title: Text(jsonList[index]['title'],style: TextStyle(fontSize: 18,
                        color: Colors.black, //font color
                        fontStyle: FontStyle.normal),),
                    subtitle: Text(jsonList[index]['body']),
                  ));
            }),
          onRefresh: () => getData(),

      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
