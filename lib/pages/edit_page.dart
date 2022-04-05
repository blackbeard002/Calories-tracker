import 'package:calories_tracker/widgets/edit_entry.dart';
import 'package:calories_tracker/widgets/edit_indicator.dart';
import 'package:flutter/material.dart';

class editDelegate extends StatefulWidget {
  const editDelegate({Key? key}) : super(key: key);

  @override
  _editDelegateState createState() => _editDelegateState();
}

class _editDelegateState extends State<editDelegate> {

  List<String> entries = ['eggs', 'maggie', 'peas'];
  List<String> weights = ['100.0', '234.0', '23.0'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),

      body: Stack(
        children: [

          Container(
            child: FutureBuilder(
              future: getEntriesAsList(),
              builder: (context, AsyncSnapshot<List<Widget>> widgetList) {
                if(widgetList.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: widgetList.data ?? [Text('please wait')],
                      ),
                    ),
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                );
              },
            )
          ),

          Positioned(
            child: Mini(consumedCals: '22', maxCals: '22',),
          )
        ],
      )
    );
  }



  Future<List<Widget>> getEntriesAsList() async
  {
    await getEntries();
    if(entries.length > 0){
      List<Widget> wigList =  List.generate(entries.length, (index) =>
          editEntry(
            key: UniqueKey(),
            weight: weights[index],
            name: entries[index],
            entryIndex: index,
            removeEntry: (indexRem){
              setState(() {
                entries.removeAt(indexRem);
              });
            },
          ),
      );
      await Future.delayed(Duration(seconds: 2));
      return wigList;
    }
    else{
      return [Text('No Entries Availiable', key: UniqueKey(),)];
    }
  }

  Future<void> getEntries() async
  {
    //todo: Implement Database functions here

    //setting dummy data, please ignore and remove once actual implementation is done
    entries = ['Eggs', 'Maggie', 'Peas','Eggs', 'Maggie', 'Peas','Eggs', 'Maggie', 'Peas'];
    weights = ['100.0', '234.0', '23.0','100.0', '234.0', '23.0','100.0', '234.0', '23.0'];
  }
}
