import 'package:calories_tracker/pages/search_food.dart';
import 'package:calories_tracker/widgets/edit_entry.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/hero_dialogue_route.dart';



class editDelegate extends StatefulWidget {
  const editDelegate({Key? key}) : super(key: key);

  @override
  _editDelegateState createState() => _editDelegateState();
}

class _editDelegateState extends State<editDelegate> {

  List<String> entries = ['eggs', 'maggie', 'peas'];
  List<String> weights = ['100.0', '234.0', '23.0'];
  @override
  void initState() {
    super.initState();
    getEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(HeroDialogRoute(builder: (context){return searchfood(selectedDate: DateTime.now(),);},
              settings: RouteSettings())
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: getEntriesAsList(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getEntries() async
  {
    entries = ['Eggs', 'Maggie', 'Peas'];
    weights = ['100.0', '234.0', '23.0'];
  }

  List<Widget> getEntriesAsList()
  {
    if(entries.length > 0){
      return List.generate(entries.length, (index) =>
          editEntry(
            key: UniqueKey(),
            weight: weights[index],
            name: entries[index],
            entryIndex: index,
            removeEntry: (indexRem) async{
              setState(() {
                entries.removeAt(indexRem);
              });
            },
          ),
      );
    }
    else{
      return [Text('No Entries Availiable', key: UniqueKey(),)];
    }
  }
}
