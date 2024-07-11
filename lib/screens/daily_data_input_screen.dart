import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/models/User.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Discharge {
  NO_DISCHARGE,
  CREAMY,
  WATERY,
  STICKY,
  EGG_WHITE,
  SPOTTING,
  CLUMPY_WHITE,
}

enum Blood {
  LIGHT,
  MEDIUM,
  HEAVY,
  NO,
  BROWN_SPOTTING,
  RED_SPOTTING,
  SUPER_HEAVY
}

enum EnergyLevel { LOW, MEDIUM, HIGH }

enum Symptoms {
  NO,
  ANXIETY,
  MOOD_SWINGS,
  CRAMPS,
  BLOATING,
  NAUSEA,
  BACK_PAIN,
  DIARRHOEA,
  BREAST_PAIN,
  ABDOMINAL_PAIN,
  SKIN_BREAKOUTS
}

class DailyDataInputScreen extends StatefulWidget {
  @override
  _DailyDataInputState createState() => _DailyDataInputState();
}

class _DailyDataInputState extends State<DailyDataInputScreen> {
  double _currentSliderValue = 35;
  List<Color> _energyOptionsColor = [
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
  ];

  List<Color> _bloodOptionsColor = [
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
  ];
  List<Color> _dischargeOptionsColor = [
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
  ];
  List<Color> _symptomsOptionsColor = [
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
    Color.fromRGBO(254, 247, 237, 1),
  ];

  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minsController = TextEditingController();

//TODO - Find the better solution to initialize the empty list

  DailyDataInput dailyDataInput =
      DailyDataInput(date: DateTime.now(), symptoms: [""]);

//TODO - Find if there's another alternative
  ThemeData darkThemedata = ThemeCubit().getDarkThemeData();
  ThemeData lightThemeData = ThemeCubit().getThemeData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Data Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTemperatureCard(),
              _buildDischargeCard(),
              _buildSleepCard(),
              _buildEnergyLevelCard(),
              _buildBloodCard(),
              _buildSymtomsCard(),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFDED4C5)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(left: 25, right: 25)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 20, color: Colors.black)),
                    elevation: MaterialStateProperty.all<double>(5.0),
                  ),
                  onPressed: () {
                    print("Submit button pressed");
                    dailyDataInput.temperature = _currentSliderValue;
                    //TODO - Change the hours and minutes to a single field
                    dailyDataInput.hours_of_sleep =
                        int.parse(_hoursController.text);
                    UserRepository().sendDailyData(dailyDataInput);
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  _buildTemperatureCard() {
    return CustomCard(
      title: 'Temperature',
      color: Color.fromRGBO(222, 212, 197, 1),
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      onPressed: () {
        print('Temperature card tapped');
      },
      child: Column(
        children: [
          Slider(
            thumbColor: Colors.black,
            activeColor: Colors.black,
            value: _currentSliderValue,
            min: 35,
            max: 42,
            divisions: 70,
            label: "$_currentSliderValue",
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              print("object");
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('35°C'),
              Text('42°C'),
            ],
          ),
        ],
      ),
    );
  }

  _buildDischargeCard() {
    return CustomCard(
      title: 'Discharge',
      color: Color.fromRGBO(222, 212, 197, 1),
      onPressed: () {
        // setState(() {
        //   _dischargeOptionsColor = Color.fromARGB(255, 34, 33, 32);
        // });
        print('Discharge info tapped');
      },
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.5,
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _buildDischargeList(),
        ),
      ),
    );
  }

  _buildEnergyLevelCard() {
    return CustomCard(
      title: 'EnergyLevel',
      color: Color.fromRGBO(222, 212, 197, 1),
      onPressed: () {
        print('Energy info tapped');
      },
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.5,
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _buildEnergyLevelList(),
        ),
      ),
    );
  }

  _buildBloodCard() {
    return CustomCard(
      title: 'Blood',
      color: Color.fromRGBO(222, 212, 197, 1),
      onPressed: () {
        print('Blood info tapped');
      },
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.5,
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _buildBloodList(),
        ),
      ),
    );
  }

  _buildSymtomsCard() {
    return CustomCard(
      title: 'Symptoms',
      color: Color.fromRGBO(222, 212, 197, 0.5),
      onPressed: () {
        print('Symptoms info tapped');
      },
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.5,
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _buildSymptomsList(),
        ),
      ),
    );
  }

  _buildSleepCard() {
    return CustomCard(
      title: 'Hours Of Sleep',
      color: Color.fromRGBO(222, 212, 197, 1),
      onPressed: () {
        print('Hours info tapped');
      },
      borderRadius: 15.0,
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          child: Container(
        // margin: EdgeInsets.all(12.0),
        // padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Hours"))),
            const Text(":"),
            Expanded(
                child: TextField(
                    controller: _minsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Minutes"))),
          ],
        ),
      )),
    );
  }

  List<GestureDetector> _buildDischargeList() {
    return Discharge.values.map((itemType) {
      // Color containerColor = const Color.fromRGBO(254, 247, 237, 1);
      return GestureDetector(
        onTap: () {
          setState(() {
            _dischargeOptionsColor[Discharge.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                    Color.fromRGBO(82, 82, 76, 1)
                : _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                    Color.fromRGBO(254, 247, 237, 1);
          });
          print(itemType.toString().split('.').last);
          dailyDataInput.discharge = itemType.toString().split('.').last;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _dischargeOptionsColor[Discharge.values.indexOf(itemType)],
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _dischargeOptionsColor[Discharge.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? Theme.of(context).textTheme.bodySmall
                : darkThemedata.textTheme.bodySmall,
          ),
        ),
      );
    }).toList();
  }

  List<GestureDetector> _buildBloodList() {
    return Blood.values.map((itemType) {
      return GestureDetector(
        onTap: () {
          print("Gesture Detected");
          dailyDataInput.blood = itemType.toString().split('.').last;
          print(itemType.toString().split('.').last);

          setState(() {
            _bloodOptionsColor[Blood.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                    Color.fromRGBO(82, 82, 76, 1)
                : _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                    Color.fromRGBO(254, 247, 237, 1);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _bloodOptionsColor[Blood.values.indexOf(itemType)],
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _bloodOptionsColor[Blood.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? Theme.of(context).textTheme.bodySmall
                : darkThemedata.textTheme.bodySmall,
          ),
        ),
      );
    }).toList();
  }

  List<GestureDetector> _buildSymptomsList() {
    return Symptoms.values.map((itemType) {
      return GestureDetector(
        onTap: () {
          print(itemType.toString().split('.').last);
          dailyDataInput.symptoms.contains(itemType.toString().split('.').last)
              ? dailyDataInput.symptoms
                  .remove(itemType.toString().split('.').last)
              : dailyDataInput.symptoms
                  .add(itemType.toString().split('.').last);

          setState(() {
            _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    Color.fromRGBO(82, 82, 76, 1)
                : _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    Color.fromRGBO(254, 247, 237, 1);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _symptomsOptionsColor[Symptoms.values.indexOf(itemType)]),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? Theme.of(context).textTheme.bodySmall
                : darkThemedata.textTheme.bodySmall,
          ),
        ),
      );
    }).toList();
  }

  List<GestureDetector> _buildEnergyLevelList() {
    return EnergyLevel.values.map((itemType) {
      return GestureDetector(
        onTap: () {
          print("Gesture Detected");
          dailyDataInput.energy_level = itemType.toString().split('.').last;
          print(itemType.toString().split('.').last);
          setState(() {
            _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                    Color.fromRGBO(82, 82, 76, 1)
                : _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                    Color.fromRGBO(254, 247, 237, 1);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _energyOptionsColor[EnergyLevel.values.indexOf(itemType)],
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                    Color.fromRGBO(254, 247, 237, 1)
                ? Theme.of(context).textTheme.bodySmall
                : darkThemedata.textTheme.bodySmall,
          ),
        ),
      );
    }).toList();
  }
}
