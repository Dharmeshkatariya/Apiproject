import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userdataapi/model/userdats.dart';

import 'detailpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});git add .

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserData> userList = [];
  List<UserData> searchList = [];
   final _searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  _getData() async {
    var client = http.Client();
    var url = "https://jsonplaceholder.typicode.com/photos";
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> uList = jsonDecode(response.body);

      for (int i = 0; i < uList.length; i++) {
        Map<String, dynamic> userMap = uList[i];
        UserData userData = UserData.fromJson(userMap);
        userList.add(userData);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: userList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: const Text(
                      "Employee Detail",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  _textInput(),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      padding: const EdgeInsets.all(8),
                      itemCount: _searchController.text.isEmpty? userList.length : searchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _containerData(index);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _containerData(int index) {
    UserData userData = _searchController.text.isEmpty? userList[index] : searchList[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DetailPage(userData: userData,)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  userData.url,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Id : ${userData.id}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Tittle : ${userData.title}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "AlbId : ${userData.albumId}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
  Widget _textInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.name,
        controller: _searchController,
        onChanged: (value){
         _search(value);
        },
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: const Icon(Icons.search,color: Colors.green,),
          labelText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
        ),
      ),
    );
  }
  _search(String search){
    searchList.clear();
    if(search.isNotEmpty){
      for(int i=0;i<userList.length;i++){
       if(userList[i].title.toLowerCase().contains(search.toLowerCase())){
         searchList.add(userList[i]);
       }
      }
      setState(() {

      });
    }
  }
}
