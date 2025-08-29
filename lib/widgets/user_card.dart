import 'package:flutter/material.dart';
import 'package:practical_task/models/UserListModel.dart';
import 'package:practical_task/utils/comman.dart';

class UserCard extends StatelessWidget {
  final Data user;
  final VoidCallback onTap;

  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child:Row(
        children: [
          Container(
            width: 70,
            height: 70,margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(user.picture!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${user.title} ${user.firstName} ${user.lastName}",
                  style: const TextStyle(fontWeight: FontWeight.bold,color: color020057110,fontSize: 15)),
              Text("(ID: ${user.id})",style: const TextStyle(color: Colors.grey)),
            ],
          )),SizedBox(width: 8,),


          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)),
              child: const Text("Get profile",style: TextStyle(color: Colors.white),)/*ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, foregroundColor: Colors.white),
                child: ,
              )*/,
            ),
          ),
        ],
      )

      /*ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(user.picture!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text("${user.title} ${user.firstName} ${user.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold,color: color020057110)),
        subtitle: Text("ID: ${user.id}"),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
          child: const Text("Get profile"),
        ),
      )*/,
    );
  }
}