import 'package:flutter/material.dart';
typedef AccDeny<T,R> = void Function(T value1, R value2);
typedef RemEntry<T> = void Function(T value);

class editEntry extends StatefulWidget {
  String weight;
  String name;
  int entryIndex;
  RemEntry<int> removeEntry;
  editEntry({
    Key? key,
    required this.weight,
    required this.name,
    required this.entryIndex,
    required this.removeEntry,
  }) : super(key: key);

  @override
  _editEntryState createState() => _editEntryState();
}

class _editEntryState extends State<editEntry> {
  bool enableEdit = false;
  bool removed = false;
  double? widthAC;
  double? heightAC = 100.0;
  String weigh = '1';
  @override
  void initState() {
    super.initState();
    weigh = widget.weight;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: AnimatedContainer(
          alignment: Alignment.topCenter,
          onEnd: (){
            setState(() {
              if(enableEdit){enableEdit = false;}
              else if(removed){widget.removeEntry(widget.entryIndex);}
              else{enableEdit = true;}
            });
          },
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0.5,
              blurRadius: 15.0,
            )]
          ),
          width: widthAC ?? MediaQuery.of(context).size.width,
          height: heightAC,
          duration: Duration(milliseconds: 200),
          curve: Curves.decelerate,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(widget.name),
                      ),

                      Expanded(
                        child: Text(weigh + ' gm'),
                      ),

                      //literally the widget that enables editing
                      Expanded(
                        child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(enableEdit){heightAC = 100.0;}
                            else{heightAC = 220.0;}
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.2,
                                  blurRadius: 2.0,
                              )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.edit_sharp,
                              size: 15,
                            ),
                          ),
                        ),
                      ),),

                      //literally the widget that deleted entries
                      Expanded(
                        child: GestureDetector(
                        onTap: (){
                          setState(() {
                            heightAC = 0.0;
                            removed = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.2,
                                blurRadius: 2.0,
                            )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                                Icons.close_sharp,
                              size: 15,
                            ),
                          ),
                        ),
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: 5.0,),

                Divider(height: 20.0, color: Colors.grey,),

                Container(
                  alignment: Alignment.center,
                  child: enableEdit ?editNumbers(
                    weightToEdit: weigh,
                    onChange: (conDeny, newVal){
                      setState(() {
                        if(conDeny){
                          setState(() {
                            weigh = newVal;
                          });
                          heightAC = 100;
                        }
                        else{
                          heightAC = 100;
                        }
                      });
                    },
                  ) : Text(
                    'To be replaced with entry time',
                    style: TextStyle(
                      fontSize: 10.0
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class editNumbers extends StatefulWidget {
  String weightToEdit;
  AccDeny<bool, String> onChange;
  editNumbers({Key? key, required this.weightToEdit, required this.onChange}) : super(key: key);

  @override
  _editNumbersState createState() => _editNumbersState();
}

class _editNumbersState extends State<editNumbers> {
  late TextEditingController thisEdit;
  String newValue = 'none';

  @override
  void initState() {
    super.initState();
    thisEdit = new TextEditingController();
    thisEdit.text = widget.weightToEdit;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [



              //text edit field
              Container(
                width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  key: UniqueKey(),
                  controller: thisEdit,
                  decoration: InputDecoration(
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                  onChanged: (value){
                    newValue = value;
                  },
                ),
              ),


              SizedBox(height: 30),


              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          side: BorderSide(
                              width: 0.2,
                              color: Colors.red
                          )
                      ),
                      onPressed: (){
                        widget.onChange(false, newValue);
                      },
                      icon: Icon(
                        Icons.close_sharp,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.redAccent
                        ),
                      ),
                    ),


                    TextButton.icon(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        side: BorderSide(
                          width: 0.2,
                          color: Colors.green
                        )
                      ),
                        onPressed: (){
                          widget.onChange(true, newValue);
                        },
                        label: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.green
                          ),
                        ),
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
