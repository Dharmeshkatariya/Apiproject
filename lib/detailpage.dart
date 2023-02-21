import 'package:flutter/material.dart';
import 'package:userdataapi/model/userdats.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.userData});

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Detail Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        userData.url,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Text(
                "Id : ${userData.id}",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Text(
                "Tittle : ${userData.title}",
                maxLines: 5,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Albid : ${userData.albumId}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
