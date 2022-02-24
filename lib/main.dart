import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'safe_cracker_widgets/safe_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Review App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SafeCrackerView(),
    );
  }
}

class SafeCrackerView extends StatefulWidget {
  const SafeCrackerView({Key? key}) : super(key: key);

  @override
  State<SafeCrackerView> createState() => _SafeCrackerViewState();
}

class _SafeCrackerViewState extends State<SafeCrackerView> {
  List<int> values = [0, 0, 0];
  String combination = "123";
  String feedback = '';
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text(
          "Safe Cracker",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUnlocked
                  ? CupertinoIcons.lock_open_fill
                  : CupertinoIcons.lock_fill,
              size: 100,
              color: Colors.blueGrey[500],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              height: 120,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < values.length; i++)
                  SafeDial(
                    startingValue: values[i],
                    onIncrement: () {
                      setState(() {
                        values[i]++;
                      });
                      setState(() {
                        if (values[i] > 9) {
                          values[i] = 9;
                        }
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        values[i]--;
                      });
                      setState(() {
                        if (values[i] < 0) {
                          values[i] = 0;
                        }
                      });
                    },
                  ),
              ]),
            ),
            if (feedback.isNotEmpty) Text(feedback),
            Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              child: TextButton(
                onPressed: () {
                  unlockSafe();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.deepPurple,
                  ),
                  child: const Text(
                    "Unlock Safe",
                    style: TextStyle(color: Color(0xffffffaa)),
                  ),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(),
              height: 60,
              child: TextButton(
                onPressed: () {
                  lockSafe(values);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.deepPurple,
                  ),
                  child: const Text(
                    "Lock Safe",
                    style: TextStyle(color: Color(0xffffffaa)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  unlockSafe() {
    if (checkCombination()) {
      setState(() {
        lockSafe(values);
        isUnlocked = true;
        feedback = "Nice! Now get the money";
      });
    } else {
      setState(() {
        isUnlocked = false;
        feedback = "Oops! Wrong combination, No money. Try again!";
      });
    }
  }

  lockSafe(List<int> val) {
    setState(() {
      for (int i = 0; i < values.length; i++) {
        values[i] = 0;
      }
      isUnlocked = false;
    });
  }

  // resetNumbers(List<int> val){
  //   setState(() {
  //     for (int i = 0; i < values.length; i++){
  //       values[i] = 0;
  //     }
  //   });
  // }

  bool checkCombination() {
    String theCurrentValue = convertValuesToComparableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    return isUnlocked;
  }

  String convertValuesToComparableString(List<int> val) {
    String temp = "";
    for (int v in val) {
      temp += "$v";
    }
    return temp;
  }

  // int sumOfAllValues(List<int> list) {
  //   int temp = 0;
  //   for (int i = 0; i < list.length; i++) {
  //     temp += list[i];
  //   }
  //   // for (int number in list) {
  //   //   temp += number;
  //   // }
  //   return temp;
  // }
}

// class NumberHolder extends StatelessWidget {
//   final dynamic content;
//   const NumberHolder({Key? key, this.content}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(4),
//         constraints: const BoxConstraints(minHeight: 60),
//         width: double.infinity,
//         color: Colors.orangeAccent,
//         child: Center(
//           child: Text(
//             "$content",
//             textAlign: TextAlign.center,
//           ),
//         ));
//   }
// }

// class IncrementalNumberHolder extends StatefulWidget {
//   final Function(int) onUpdate;
//   final int startingValue;
//   const IncrementalNumberHolder(
//       {Key? key, this.startingValue = 0, required this.onUpdate})
//       : super(key: key);

//   @override
//   State<IncrementalNumberHolder> createState() =>
//       _IncrementalNumberHolderState();
// }

// class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
//   @override
//   void initState() {
//     currentValue = widget.startingValue;
//     super.initState();
//   }

//   late int currentValue;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(4),
//         width: double.infinity,
//         color: Colors.orangeAccent,
//         constraints: const BoxConstraints(minHeight: 60),
//         child: Row(
//           children: [
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   currentValue--;
//                 });
//                 widget.onUpdate(currentValue);
//               },
//               icon: const Icon(Icons.chevron_left),
//             ),
//             Expanded(
//               child: Text(
//                 "$currentValue",
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   currentValue++;
//                 });
//                 widget.onUpdate(currentValue);
//               },
//               icon: const Icon(Icons.chevron_right),
//             ),
//           ],
//         ));
//   }
// }
