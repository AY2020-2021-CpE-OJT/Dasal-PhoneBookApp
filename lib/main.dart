import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(loginScreen());
}

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Login or Create Account',
      home: _loginPage(),
    );
  }
}

class _loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<_loginPage> {
  final UserName = TextEditingController();
  final Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PhoneBook - Login"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: UserName,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'USERNAME',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: Password,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'PASSWORD',
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => authorizeAccount()),
                  );
                },
                child: Text('Login'),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => createAccount()),
                      );
                    },
                    child: Text('Create Account'),
                  ),
                ))
          ],
        ));
  }
}

// ignore: camel_case_types
class authorizeAccount extends StatefulWidget {
  @override
  authorizeAccountState createState() => authorizeAccountState();
}

// ignore: camel_case_types
class authorizeAccountState extends State<authorizeAccount> {
  // ignore: non_constant_identifier_names
  final code = TextEditingController();

  void addAccount() async {
    String _userName = code.text;

    final response = await http.post(
        Uri.http('dasal-heroku-app.herokuapp.com', '/createuser'),
        body: {'userName': _userName});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PhoneBook - Verification"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: code,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'ENTER CODE',
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      addAccount();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    child: Text('Continue'),
                  ),
                ))
          ],
        ));
  }
}

// ignore: camel_case_types
class createAccount extends StatefulWidget {
  @override
  createAccountState createState() => createAccountState();
}

// ignore: camel_case_types
class createAccountState extends State<createAccount> {
  // ignore: non_constant_identifier_names
  final UserName = TextEditingController();
  // ignore: non_constant_identifier_names
  final Password = TextEditingController();

  void addAccount() async {
    String _userName = UserName.text;
    String _password = Password.text;

    final response = await http.post(
        Uri.http('dasal-heroku-app.herokuapp.com', '/createuser'),
        body: {'userName': _userName, 'password': _password});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PhoneBook - Create Account"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: UserName,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'USERNAME',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: Password,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'PASSWORD',
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      addAccount();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _loginPage()),
                      );
                    },
                    child: Text('Create Account'),
                  ),
                ))
          ],
        ));
  }
}

//HomePage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Phone book',
      home: HomePage(),
    );
  }
}

//Homepage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//HomePage
class _HomePageState extends State<HomePage> {
  List _postJson = [];

  @override
  void initState() {
    super.initState();
    this.getContact();
  }

  getContact() async {
    Uri url = Uri.http('dasal-heroku-app.herokuapp.com', '/get');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var posts = json.decode(response.body);
      print(posts);
      setState(() {
        _postJson = posts;
      });
    } else {
      setState(() {
        _postJson = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("PhoneBook"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              _postJson.length > 0
                  ? Expanded(
                      child: ListView.builder(
                      itemCount: _postJson.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(_postJson[index]['_id'] +
                                  "\n" +
                                  _postJson[index]['lastName'] +
                                  "\n" +
                                  _postJson[index]['firstName']),
                              subtitle: Text(_postJson[index]['firstNumber'] +
                                  "\n" +
                                  _postJson[index]['secondNumber'] +
                                  "\n" +
                                  _postJson[index]['thirdNumber'] +
                                  "\n"),
                            ));
                      },
                    ))
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              ElevatedButton(
                child: Text('Add contact'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
                  );
                },
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
              ElevatedButton(
                child: Text('Get contact'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetContact()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Create Contact
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

//Create Contact
class MyCustomFormState extends State<MyCustomForm> {
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final firstNumber = TextEditingController();
  final secondNumber = TextEditingController();
  final thirdNumber = TextEditingController();

  /*getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Confirmation(
                  lastnameHolder: lastName.text,
                  firstnameHolder: firstName.text,
                  firstnumberHolder: firstNumber.text,
                  secondnumberHolder: secondNumber.text,
                  thirdnumberHolder: thirdNumber.text,
                )));
  }*/

  void add() async {
    String _lastName = lastName.text;
    String _firstName = firstName.text;
    String _firstNumber = firstNumber.text;
    String _secondNumber = secondNumber.text;
    String _thirdNumber = thirdNumber.text;

    final response = await http
        .post(Uri.http('dasal-heroku-app.herokuapp.com', '/posts'), body: {
      'lastName': _lastName,
      'firstName': _firstName,
      'firstNumber': _firstNumber,
      'secondNumber': _secondNumber,
      'thirdNumber': _thirdNumber,
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: lastName,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Last Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: firstName,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your First Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: firstNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your First phone( Required)',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: secondNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Second phone(Optional)',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: thirdNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Third phone(Optional)',
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              add();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Text('ADD'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Text('RETURN'),
        ),
      ],
    ));
  }
}

//Decide what to do with specific Contact  given
class GetContact extends StatefulWidget {
  @override
  GetContactState createState() => GetContactState();
}

//Decide what to do with specific Contact  given
class GetContactState extends State<GetContact> {
  final idcntrl = TextEditingController();

  /*getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayContact(
                  idcntrlHolder: idcntrl.text,
                )));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: idcntrl,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Paste Id of contact',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeleteContact(
                              passId: idcntrl.text,
                              key: null,
                            )),
                  );
                },
                child: Text('Delete')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
          Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateContact(
                          passId: idcntrl.text,
                          key: null,
                        )),
              );
            },
            child: Text('Update Contact Info'),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
          Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Text('RETURN'),
          )),
        ],
      ),
    );
  }

  /*List contact = [];
  getContact() async {
    var response = await http.get(
        Uri.http('dasal-heroku-app.herokuapp.com', '/' + idcntrl.text),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    if (response.statusCode == 200) {
      var posts = json.decode(response.body);
      print(posts);
      setState(() {
        contact = posts;
      });
    } else {
      setState(() {
        contact = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getContact();
  }*/
}

//Delete Contact
class DeleteContact extends StatefulWidget {
  final String passId;
  const DeleteContact({Key? key, required this.passId}) : super(key: key);
  @override
  DeleteContactState createState() => DeleteContactState();
}

//Delete Contact
class DeleteContactState extends State<DeleteContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            ),
            _contact.length > 0
                ? Expanded(child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(_contact[index]["lastName"] +
                              "\n" +
                              _contact[index]['firstName']),
                          subtitle: Text(_contact[index]["firstNumber"] +
                              "\n" +
                              _contact[index]["secondNumber"] +
                              "\n" +
                              _contact[index]["thirdNumber"] +
                              "\n"),
                        ),
                      );
                    },
                  ))
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                http.delete(Uri.http('dasal-heroku-app.herokuapp.com',
                    '/delete/' + widget.passId));
              },
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
          ],
        ),
      ),
    );
  }

  List _contact = [];
  getContact() async {
    var response = await http.get(
        Uri.http('dasal-heroku-app.herokuapp.com', '/' + widget.passId),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    if (response.statusCode == 200) {
      var posts = json.decode(response.body);
      print(posts);
      setState(() {
        _contact = posts;
      });
    } else {
      setState(() {
        _contact = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getContact();
  }
}

//Update Contact
class UpdateContact extends StatefulWidget {
  final String passId;
  const UpdateContact({Key? key, required this.passId}) : super(key: key);
  @override
  UpdateContactState createState() => UpdateContactState();
}

//update Contact
class UpdateContactState extends State<UpdateContact> {
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final firstNumber = TextEditingController();
  final secondNumber = TextEditingController();
  final thirdNumber = TextEditingController();

  void UpdateLastName() async {
    String _lastName = lastName.text;

    final response = await http.patch(
        Uri.http('dasal-heroku-app.herokuapp.com', '/update/' + widget.passId),
        body: {
          'lastName': _lastName,
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  void UpdateFirstName() async {
    String _firstName = firstName.text;

    final response = await http.patch(
        Uri.http('dasal-heroku-app.herokuapp.com', '/update/' + widget.passId),
        body: {
          'firstName': _firstName,
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  void UpdateFirstNumber() async {
    String _firstNumber = firstNumber.text;

    final response = await http.patch(
        Uri.http('dasal-heroku-app.herokuapp.com', '/update/' + widget.passId),
        body: {
          'firstNumber': _firstNumber,
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  void UpdateSecondNumber() async {
    String _secondNumber = secondNumber.text;

    final response = await http.patch(
        Uri.http('dasal-heroku-app.herokuapp.com', '/update/' + widget.passId),
        body: {
          'secondNumber': _secondNumber,
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  void UpdateThirdNumber() async {
    String _thirdNumber = thirdNumber.text;

    final response = await http.patch(
        Uri.http('dasal-heroku-app.herokuapp.com', '/update/' + widget.passId),
        body: {
          'thirdNumber': _thirdNumber,
        });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: lastName,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Update Last Name',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UpdateLastName();
          },
          child: Text('Update'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: firstName,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Update First Name',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UpdateFirstName();
          },
          child: Text('Update'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: firstNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Update First phone',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UpdateFirstNumber();
          },
          child: Text('Update'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: secondNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Update Second phone',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UpdateSecondNumber();
          },
          child: Text('Update'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: thirdNumber,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Update Third phone',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            UpdateThirdNumber();
          },
          child: Text('Update'),
        ),
        Row(children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetContact()),
                );
              },
              child: Text('RETURN'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('CONFRIM'),
            ),
          )
        ]),
      ],
    )));
  }
}

/*class Confirmation extends StatelessWidget {
  final lastnameHolder;
  final firstnameHolder;
  final firstnumberHolder;
  final secondnumberHolder;
  final thirdnumberHolder;

  Confirmation(
      {Key? key,
      required this.lastnameHolder,
      this.firstnameHolder,
      this.firstnumberHolder,
      this.secondnumberHolder,
      this.thirdnumberHolder})
      : super(key: key);
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add contact"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Last Name = ' + lastnameHolder,
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'First Name = ' + firstnameHolder,
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'First Phone Number = ' + firstnumberHolder,
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Second Phone Number = ' + secondnumberHolder,
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Third Phone Number = ' + thirdnumberHolder,
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('ADD'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              ElevatedButton(
                onPressed: () => goBack(context),
                child: Text('RETURN'),
              ),
            ]));
  }
}*/
