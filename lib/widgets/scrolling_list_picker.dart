import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

typedef tracker<T> = void Function(T value);

class listPicker extends StatefulWidget {

  List scrollList;
  Color? budColor = Colors.orange;
  Color? textColor = Colors.black;
  tracker<String> onChange;
  bool isInput;
  listPicker({Key? key,
    required this.onChange,
    required this.scrollList,
    required this.isInput,
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
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: Material(

              child: SizedBox(width: 120.0, height: 50,),
              borderRadius: BorderRadius.circular(32),
              color: widget.budColor,
              shadowColor: Colors.black,
              elevation: 5.0,
            ),
          ),

          IgnorePointer(
            child: Row(
              children: [
                Icon(Icons.arrow_right,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(width: 60,),
                Icon(Icons.arrow_left,
                  size: 30.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          Container(
            width: 100.0,
            height: 130.0,
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
                physics: FixedExtentScrollPhysics(),
                children: widget.isInput ? getInteractableList() : getConstList(),
                itemExtent: 55,
                onSelectedItemChanged: (index) {
                  updateCurrentlySelected(widget.scrollList[index].toString());
                },
              ),
            )
          ),
        ],
      )
    );
  }

  List<Widget> getInteractableList()
  {
    List<Widget>scrollView = List.generate(widget.scrollList.length, (index) =>
      Container(
        width: 80,
        height: 55,
        alignment: Alignment.center,
        child: index == 0 ? TextField(
          maxLength: 3,
          keyboardType: TextInputType.number,
          controller: inputControl,
          focusNode: customFocus,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0),
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
            fontSize: 22.0
          ),
        ),
      )
    );
    return scrollView;
  }
  List<Widget> getConstList()
  {
    List<Widget>scrollView = List.generate(widget.scrollList.length, (index) =>
      Container(
        width: 80,
        height: 55,
        alignment: Alignment.center,
        child: Text(
          widget.scrollList[index].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0
          ),
        ),
      )
    );
    return scrollView;
  }

  void updateCurrentlySelected(String s)
  {
    currentlySelected = s;
    //add code to update it to super
    widget.onChange(currentlySelected);
  }
}
