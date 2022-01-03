import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Hérores del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1.0
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile( bands[index] )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        elevation: 1.0
      )
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {},
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Text('Delete band', style: TextStyle(color: Colors.white)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0,2)),
          backgroundColor: Colors.blue[100]
        ),
        title: Text( band.name! ),
        trailing: Text( '${band.votes}', style: TextStyle(fontSize: 20) ),
        onTap: (){
          print(band.name);
        }
      )
    );
  }

  addNewBand() {

    final textController = TextEditingController();

    if(Platform.isAndroid) {
      return showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5.0,
                textColor: Colors.blue,
                onPressed: () => addBandToList( textController.text )
              )
            ]
          );
        } 
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( context ) {
        return CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField( controller: textController ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList( textController.text ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            )
          ]
        );
      }
    );

  }

  addBandToList(String name) {
    
    if(name.length > 1) {
      this.bands.add(
        Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 0
        )
      );
      setState(() {});
    }

    Navigator.pop(context);

  }

}