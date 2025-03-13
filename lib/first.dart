// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController myText = TextEditingController();
  TextEditingController myValue = TextEditingController();

  var mybox = Hive.box('Mybox');

  List mydata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItem();
  }

  addItem(data) async {
    await mybox.add(data);
    print(mybox.values);
    getItem();
  }

  deleteItem(key) async {
    await mybox.delete(key);
    getItem();
  }

  // updateItem(key, updatedData) async {
  //   await mybox.put(key, updatedData);
  //   getItem();
  // }

  getItem() {
    mydata = mybox.keys.map((e) {
      var res = mybox.get(e);

      return {
        'Key': e,
        'title': res['title'],
        'value': res['value'],
      };
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Database'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: myText,
              decoration: InputDecoration(hintText: 'Enter desc'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: myValue,
              decoration: InputDecoration(hintText: 'Enter value'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Map<String, String> m1 = {
                  'title': myText.text,
                  'value': myValue.text,
                };
                addItem(m1);
              },
              icon: Icon(Icons.save),
              label: Text('Save Date'),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: mydata.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${mydata[index]['title']}"),
                  subtitle: Text("${mydata[index]['value']}"),
                  // leading: IconButton(
                  //     onPressed: () {
                   
                  //     },
                  //     icon: Icon(Icons.save_as_outlined)),
                  trailing: IconButton(
                      onPressed: () {
                        deleteItem(mydata[index]['Key']);
                      },
                      icon: Icon(Icons.delete_forever_outlined)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

/*
class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'Student details-Hive',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


 class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          
        ],
      )),
    );
  }
}
*/
