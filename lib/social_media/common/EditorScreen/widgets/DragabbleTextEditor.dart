import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class DraggableTextEditor extends StatefulWidget {
  final Function(String text,TextStyle style) onSubmit;
  String? text;
  TextStyle? style;
  DraggableTextEditor({super.key,required this.onSubmit,required this.text,required this.style});

  @override
  State<DraggableTextEditor> createState() => _DraggableTextEditorState();
}

class _DraggableTextEditorState extends State<DraggableTextEditor> {

  bool isTextWritten = false;

  FocusNode inputFocusNode =FocusNode();
  TextEditingController inputController = TextEditingController();
  Color? textColor;
  Color? textBackgroundColor;
  double? fontSize;
  FontWeight? inputWeight;
  FontStyle? inputStyle;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputFocusNode.requestFocus();
    inputController.text = widget.text!;
    fontSize = widget.style?.fontSize ?? 28;
    textColor = widget.style?.color ?? Colors.white;
    textBackgroundColor = widget.style?.backgroundColor ?? Colors.transparent;
    inputWeight = widget.style?.fontWeight ?? FontWeight.normal;
    inputStyle = widget.style?.fontStyle ?? FontStyle.normal;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.text!.isNotEmpty){
      isTextWritten = true;
    }
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      
                      return Dialog(
                        child: SizedBox(
                            height: 550,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ColorPicker(pickerColor: Colors.black, onColorChanged: (value) {
                                    textColor = value;
                                    print(value);
                                  },),
                                ),
                                ElevatedButton(onPressed: () {
                                  setState(() {
                                  });
                                  Navigator.pop(context);
                                },child: const Text("done"))
                              ],
                            ),
                        ),
                      );
                    },);
                  },
                  child: CircleAvatar(backgroundColor: textColor,))),
          Positioned(
              top: 10,
              left: 60,
              child: InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (context) {

                      return Dialog(
                        child: SizedBox(
                          height: 550,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ColorPicker(pickerColor: Colors.black, onColorChanged: (value) {
                                  textBackgroundColor = value;
                                },),
                              ),
                              ElevatedButton(onPressed: () {
                                setState(() {
                                });
                                Navigator.pop(context);
                              },child: const Text("done"))
                            ],
                          ),
                        ),
                      );
                    },);
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      color: textBackgroundColor
                    ),))),
          Positioned(
              top: 8,
              left: 120,
              child: InkWell(
                  onTap: () {
                    if(inputWeight != FontWeight.bold) {
                    inputWeight = FontWeight.bold;
                    setState(() {
                    });
                  }else{
                      inputWeight = FontWeight.normal;
                      setState(() {
                      });
                    }
                },
                  child: Text("B",style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: inputWeight),))),
          Positioned(
              top: 15,
              left: 150,
              child: InkWell(
                  onTap: () {
                    if(inputStyle != FontStyle.italic) {
                      inputStyle = FontStyle.italic;
                      setState(() {});
                    }else{
                      inputStyle = FontStyle.normal;
                      setState(() {});
                    }
                  },
                  child: const Icon(Icons.format_italic,color: Colors.white,size: 30,))),
      Positioned(
          top: 0,
          right: 0,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {

                      fontSize = fontSize!+1;
                      setState(() {});
                  },
                  child: Text("+",style: TextStyle(color: Colors.white,fontSize: 21)),),
                const SizedBox(width: 10,),
                Text("$fontSize",style: TextStyle(color: Colors.white,fontSize: 21),),
                const SizedBox(width: 10,),
                Container(child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextButton(
                      onPressed: () {
                        fontSize = fontSize!-1;
                        setState(() {});
                      },
                      child:Text("-",style: TextStyle(color: Colors.white,fontSize: 21),)),
                )),
              ],
            ),
          ),

          
          
          Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: TextField(
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 20,
              maxLength: 1000,
              controller: inputController,
              onChanged: (value) {
                if(value.length > 0){
                  isTextWritten = true;
                  setState(() {
                  });
                }else{
                  isTextWritten = false;
                  setState(() {
                  });
                }
              },
              focusNode: inputFocusNode,
              decoration: const InputDecoration(

                  border: InputBorder.none),
              style: TextStyle(
                fontStyle: inputStyle,
                backgroundColor: textBackgroundColor,
                  fontSize: fontSize,
                  fontWeight: inputWeight,
                  color: textColor
              ),
            ),
          ),
        ),
          isTextWritten ? Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: const Icon(Icons.done),
              onPressed: () {
                widget.onSubmit(inputController.text,TextStyle(
                    fontStyle: inputStyle,
                    backgroundColor: textBackgroundColor,
                    fontSize: fontSize,
                    fontWeight: inputWeight,
                    color: textColor
                ));
            },),
          ) : Container()
        ]
      ),
    );
  }
}
