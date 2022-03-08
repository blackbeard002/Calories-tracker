import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool loginReg = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){setState(() {
                  loginReg = true;
                });}, child: Text('login')),
                TextButton(onPressed: (){setState(() {
                  loginReg = false;
                });}, child: Text('register'))
              ],
            ),
            Container(
              child: loginReg
                  ?Padding(padding: const EdgeInsets.all(25), child: loginForm(),)

                  :Padding(padding: const EdgeInsets.all(25), child: registerForm(),),
            )
          ],
        )
      )
    );
  }
}


class loginForm extends StatefulWidget {
  const loginForm({Key? key}) : super(key: key);

  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  String uid = 'sample';
  String uname = 'sample';
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            onChanged: (value){
              uid = value;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'User ID',
              errorText: errorText,
            ),
          ),
          SizedBox(height: 30.0,),
          GestureDetector(
            onTap: () async {
              //steps
              // 1 - Check if username exists
              // 2 - Set the username into the shared preferences.
              if(await unameCheck(uid)){
                errorText = null;
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool('first_launch', false);
                sp.setString('uid', uid);
                //todo: read below
                //get the user's actual name from DB and store it locally as well
                //uncomment last line after this is done.
                //uname =
                //sp.setString('uname',uname);
                Navigator.of(context).pushNamed('/home');
              }
              else{
                setState(() {
                  print('text setting error text');
                  errorText = 'User name does not exist';
                });
              }
            },
            child: Container(
              color: Colors.purpleAccent,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Back on the Saddle'),
              ),
            ),
          )
        ],
      )
    );
  }


  Future<bool> unameCheck(String uname) async
  {
    //todo: database fucntions here to check username
    //check if user  name already exists here
    // is it does return true
    
    if(uname.length > 5) {return true;}
    else{return false;}
  }
}

class registerForm extends StatefulWidget {
  const registerForm({Key? key}) : super(key: key);

  @override
  _registerFormState createState() => _registerFormState();
}

class _registerFormState extends State<registerForm> {
  String uname = 'sample';
  String uid = 'sample';
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            onChanged: (value){uname = value;},
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Your Name'
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            onChanged: (value){uid = value;},
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.star),
              hintText: 'New User ID',
              errorText: errorText,
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () async{
              if(await register(uname, uid)){
                errorText = null;
                SharedPreferences sp = await SharedPreferences.getInstance();
                await sp.setBool('first_launch', false);
                await sp.setString('uname', uname);
                await sp.setString('uid', uid);
                Navigator.of(context).pushNamed('/home');
              }
              else{
                setState(() {
                  errorText = 'Choose a unique User ID';
                });
              }
            },
            child: Container(
              color: Colors.purpleAccent,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Lets Go!'),
              ),
            ),
          )
        ],
      ),
    );
  }

  //registration page
  Future<bool> register(String un, String ui) async
  {
    //todo: use this function to do database related stuff for registering user
    //check validate if the uid variable is unique in the database
    //if unique then insert into the db and return true, the rest is taken care.
    //else return false, and the error text will pop up automatically

    if(un.length > 5){return true;}
    else{return false;}
  }
}
