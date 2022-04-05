import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

typedef tracker<T> = void Function(T value);

class listPicker extends StatefulWidget {

  List scrollList;
  String heading;
  Color? budColor = Colors.orange;
  Color? textColor = Colors.black;
  tracker<String> onChange;
  bool isInput;
  listPicker({Key? key,
    required this.onChange,
    required this.scrollList,
    required this.isInput,
    required this.heading,
    this.budColor,
    this.textColor,
  }) : super(key: key);

  @override
  _listPickerState createState() => _listPickerState();
}

class _listPickerState extends State<listPicker> {


  late List<Widget> widgetListTemp;
  double itemExt = 55;
  String currentlySelected = '';
  FixedExtentScrollController fesc = new FixedExtentScrollController();
  late TextEditingController inputControl;
  late FocusNode customFocus;


  @override
  void initState() {
    super.initState();
    customFocus = FocusNode();
    inputControl = new TextEditingController();
    inputControl.text = widget.scrollList[0].toString();
  }

  @override
  void dispose() {
    customFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(widget.heading,
            style: TextStyle(
              fontSize: 16,
              shadows: [Shadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset.fromDirection(0.5)
              )]
            ),
          ),
          SizedBox(height: 5,),
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                child: Container(
                  child: SizedBox(width: 100.0, height: 30,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      )
                  ),
                ),
              ),

              IgnorePointer(
                child: Row(
                  children: [
                    Icon(Icons.arrow_drop_down,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    SizedBox(width: 40,),
                    Icon(Icons.arrow_drop_up,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              Container(
                  width: 100.0,
                  height: 110.0,
                  child: GestureDetector(
                    onTap: () => {
                      if(widget.isInput){
                        customFocus.requestFocus(),
                        inputControl.text = '',
                        fesc.animateToItem(1, duration: Duration(milliseconds: 200), curve: Curves.easeIn)
                      }
                      else{

                      }
                    },
                    child: ListWheelScrollView(
                      controller: fesc,
                      diameterRatio: 1.5,
                      physics: FixedExtentScrollPhysics(),
                      children: widget.isInput ? getInteractableList() : getConstList(),
                      itemExtent: 45,
                      onSelectedItemChanged: (index) {
                        updateCurrentlySelected(widget.scrollList[index].toString());
                      },
                    ),
                  )
              ),
            ],
          )
        ],
      )
    );
  }

  List<Widget> getInteractableList()
  {
    List<Widget>scrollView = List.generate(widget.scrollList.length, (index) =>
      Container(
        width: 80,
        height: 45,
        alignment: Alignment.center,
        child: index == 0 ? TextField(
          maxLength: 3,
          keyboardType: TextInputType.number,
          controller: inputControl,
          focusNode: customFocus,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: ''
          ),

          onChanged: (text) {
            widget.scrollList[0] = text;
            updateCurrentlySelected(text);
          },
        ) : Text(
          widget.scrollList[index].toString(),
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      )
    );
    widget.onChange(widget.scrollList[0].toString());
    return scrollView;
  }
  List<Widget> getConstList()
  {
    List<Widget>scrollView = List.generate(widget.scrollList.length, (index) =>
      Container(
        width: 80,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          widget.scrollList[index].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
      )
    );
    widget.onChange(widget.scrollList[0].toString());
    return scrollView;
  }

  void updateCurrentlySelected(String s)
  {
    currentlySelected = s;
    //add code to update it to super
    widget.onChange(currentlySelected);
  }
}
