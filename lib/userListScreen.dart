import 'package:flutter/material.dart';
import 'package:user_managment/register.dart';
import 'package:user_managment/user.dart';
import 'package:user_managment/userInfoScreen.dart';
import 'dart:io';
import 'db.dart';


class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of users"),
        leading: const Icon(Icons.person),
      ),
      body: FutureBuilder<List<User>>(
        future: Db.instance.users(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
          if(snapshot.hasData){
            List<User>? users = snapshot.data;
            users = users?.reversed.toList();
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, int index)
              {
                final User user = users![index];
                return buidUserItem(user: user);
              },
            );
          }else
            {
              return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                value: null,
                  backgroundColor: Colors.blue,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              ),
              );
            }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>  Register()
            )
          );
        },
        tooltip: 'Ajouter un Utilisateur',
        child: const Icon(Icons.add),
      ),
    );
  }
}



class buidUserItem extends StatelessWidget
{
  final User user;

   const buidUserItem({Key? key, required this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>  UserInfoScreen(user: user)
          )
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 8,
        child: Row(
          children: <Widget>[
            user.isAsset == 0 ? Image.file(
              File(user.picture),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ) : Image.asset(
              user.picture,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(user.firstname + " " + user.lastname.toUpperCase(), style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Text(user.mail, style: const TextStyle(
                      fontSize: 18
                  ),)
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

}