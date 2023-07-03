import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  final categoryValue = ['Work', 'Study', 'Exercise'];
  String? selectedCategory;

  final levelimportanceValue = ['중요', '매우중요', '보통'];
  String? selectedLevelImportance;

  Widget buildTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF9C89B8),
        ),
      ),
      child: child,
    );
  }

  Widget buildColorContainer(Color color) {
    return Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    );
  }

  String getFormattedDate() {
    return '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle('Name'),
              buildContainer(
                  child: const SizedBox(width: 300, child: TextField())),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Date'),
              buildContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getFormattedDate(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.calendar,
                          color: Color(0xFF9C89B8)),
                      onPressed: () {
                        selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Category'),
              buildContainer(
                  child: DropdownButton(
                value: selectedCategory,
                isExpanded: true,
                items: categoryValue
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                icon: const Icon(
                  Icons.expand_more,
                  color: Color(0xFF9C89B8),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Level Importance'),
              buildContainer(
                  child: DropdownButton(
                value: selectedLevelImportance,
                isExpanded: true,
                items: levelimportanceValue
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLevelImportance = value!;
                  });
                },
                icon: const Icon(
                  Icons.expand_more,
                  color: Color(0xFF9C89B8),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Color'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildColorContainer(const Color(0xFFCEEDC7)),
                  buildColorContainer(const Color(0xFFFF9494)),
                  buildColorContainer(const Color(0xFFFFD4B2)),
                  buildColorContainer(const Color(0xFFFFF6BD)),
                  buildColorContainer(const Color(0xFFD7E3FC)),
                  buildColorContainer(const Color(0xFFFFC8DD)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Set Alarm'),
              buildContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$time'),
                    IconButton(
                        onPressed: () {
                          showDialogTimePicker(context);
                        },
                        icon: const Icon(Icons.access_alarm),
                        color: Color(0xFF9C89B8))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTitle('Time During'),
              buildContainer(
                  child: const SizedBox(width: 300, child: TextField())),
              const SizedBox(height: 30),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF9C89B8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {},
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogTimePicker(BuildContext context) {
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedTime.then((value) {
      setState(() {
        time = "${value!.hour} : ${value.minute}";
      });
    });
  }
}
