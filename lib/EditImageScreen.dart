import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editor/Edit_ImageViewModel.dart';
import 'package:screenshot/screenshot.dart';
import 'ImageText.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key, required this.selectedImage})
      : super(key: key);
  final String selectedImage;

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                      left: texts[i].left,
                      top: texts[i].top,
                      child: GestureDetector(
                        onLongPress: () {
                         setState(() {
                           currentIndex =i;
                           removeText(context);
                         });
                        },
                        onTap: ()=> setCurrentIndex(context, i),
                        child: Draggable(
                            feedback: ImageText(textInfo: texts[i]),
                            child: ImageText(textInfo: texts[i]),
                            onDragEnd: (drag) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);
                              setState(() {
                                texts[i].top = off.dy - 96;
                                texts[i].left = off.dx;
                              });
                            }),
                      )),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black.withOpacity(
                                0.3,
                              )),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _addnewTextFab,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(
            widget.selectedImage,
          ),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addnewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        tooltip: 'Add New Text',
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                tooltip: 'Save Image',
                onPressed: ()=>saveToGollery(context),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                tooltip: 'Add Image',
                onPressed: increaseFontSize,
              ),
              IconButton(
                icon: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                tooltip: 'Remove',
                onPressed: decreaseFonSize,
              ),
              IconButton(
                icon: Icon(
                  Icons.bolt,
                  color: Colors.black,
                ),
                tooltip: 'Bolt',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                tooltip: 'Italic',
                onPressed: italicText,
              ),
              IconButton(
                icon: Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                tooltip: 'bold',
                onPressed:  boldText,
              ),
              IconButton(
                icon: Icon(
                  Icons.format_underline,
                  color: Colors.black,
                ),
                tooltip: 'UnderLine',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                tooltip: 'Align right ',
                onPressed: alignRight,
              ),
              IconButton(
                icon: Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                tooltip: 'Align Center ',
                onPressed: alignCenter,
              ),
              IconButton(
                icon: Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                tooltip: 'Align Left ',
                onPressed: alignLeft,
              ),
              IconButton(
                icon: Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                tooltip: 'Add a new line',
                onPressed: addLineToText,
              ),
              // THIS IS THE TOOL COLORS ITEAM ;
              Tooltip(
                message: 'purpleAccent',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.purpleAccent),
                  child: const CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'red',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'green',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'blue',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'yellow',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'pink',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'black',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Tooltip(
                message: 'grey',
                child: GestureDetector(
                  onTap: ()=> changeTextColor(Colors.grey),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 5,),
            ],
          ),
        ),
      );
}
