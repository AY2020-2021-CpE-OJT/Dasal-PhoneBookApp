import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _postJson = [];
  void getContact() async {
    try {
      final response = await get(Uri.parse(
          "https://raw.githubusercontent.com/Task-001/task03/master/contactinfo.json"));
      // final response = await get(Uri.http('127.0.0.1:200', '/get'));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("PhoneBook"),
          ),
          body: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(children: [
                _postJson.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _postJson.length,
                          itemBuilder: (context, i) {
                            final post = _postJson[i];
                            return Text(
                                // "Last Name: ${posts["title"]}\n First Name: ${posts["body"]}\n\n");
                                "Last Name: ${post["lastName"]}\n First Name: ${post["firstName"]}\n First Number: ${post["firstNumber"]}\n Second Number: ${post["secondNumber"]}\n Third Number: ${post["thirdNumber"]}\n\n");
                          },
                        ),
                      )
                    : Container(),
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
                ),
              ]))),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

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
            builder: (context) => DisplayContact(
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

    final response = await post(Uri.http('127.0.0.1:200', '/posts'), body: {
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

class GetContact extends StatefulWidget {
  @override
  GetContactState createState() => GetContactState();
}

class GetContactState extends State<GetContact> {
  final idcntrl = TextEditingController();

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayContact(
                //   idcntrlHolder: idcntrl.text,
                )));
  }

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
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, getItemAndNavigate(context));
            },
            child: Text('Get Contact Info'),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('RETURN'),
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class DisplayContact extends StatelessWidget {
  //final idcntrlHolder;

  /*DisplayContact({Key? key, this.idcntrlHolder}) : super(key: key);
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  late Map contact;
  late List userId;
  late List userLastName;
  late List userFirstName;
  late List userFirstNumber;
  late List userSecondNumber;
  late List userThirdNumber;
  // ignore: non_constant_identifier_names

  void getContact() async {
    String _idNum = idcntrlHolder;

    http.Response response =
        await get(Uri.http('127.0.0.1:200', '/posts/:postsID'));
    contact = json.decode(response.body);
  }*/

  /*void initState() {
    super.initState();
    GetContact();
  }*/

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateContat(
                //   idcntrlHolder: idcntrl.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Info"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Last Name = ', //+ userLastName.toString(),
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'First Name = ', //+ userFirstName.toString(),
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'First Phone Number = ', //+ userFirstNumber.toString(),
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Second Phone Number = ', //+ userSecondNumber.toString(),
                    style: TextStyle(fontSize: 22),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    'Third Phone Number = ', //+ userThirdNumber.toString(),
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('Delete'),
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
              Center(
                child: ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      getItemAndNavigate(context),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('RETURN'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GetContact()),
                    );
                  },
                ),
              ),
            ]));
  }
}

class UpdateContat extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update contact"),
      ),
      body: Column(),
    );
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



/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'entities/note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PhoneBook",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];
  Future fetchNotes() async {
    var response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Task-001/task03/master/data3.json'));
    var notes = [];
    if (response.statusCode == 200) {
      print(response.body);
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        _notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Book'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 32.0, left: 16.0, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notes[index].lastname,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notes[index].firstnumber,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notes[index].secondnumber,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notes[index].thirdnumber,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )));
        },
        itemCount: _notes.length,
      ),
    );
  }
}*/






/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:testfile/models/repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneBook',
      home: Home(),
    );
  }
}

Future<All> fetchRepos() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/Task-001/task03/master/contacts2.data'));
  if (response.statusCode == 200) {
    print(response.body);
    return All.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to get repo');
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<All> futureRepo;
  @override
  void initState() {
    super.initState();
    futureRepo = fetchRepos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhoneBook'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<All>(
            future: futureRepo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Repo> repos = <Repo>[];
                for (int i = 0; i < snapshot.data!.repos.length; i++) {
                  repos.add(
                    Repo(
                        lastname: snapshot.data!.repos[i].lastname,
                        firstname: snapshot.data!.repos[i].firstname,
                        firstnumber: snapshot.data!.repos[i].firstnumber,
                        secondnumber: snapshot.data!.repos[i].secondnumber,
                        thirdnumber: snapshot.data!.repos[i].thirdnumber),
                  );
                }
                return ListView(
                  children: repos
                      .map(
                        (r) => Card(
                          child: Column(
                            children: [
                              Text(r.lastname),
                              Text(r.firstname),
                              Text(r.firstnumber),
                              Text(r.secondnumber),
                              Text(r.thirdnumber),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}*/