import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/widgets/custom_card.dart';
import 'package:flutter/material.dart';

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
  const DailyDataInputScreen({super.key});

  @override
  _DailyDataInputState createState() => _DailyDataInputState();
}

class _DailyDataInputState extends State<DailyDataInputScreen> {
  double _currentSliderValue = 35;
  final List<Color> _energyOptionsColor = [
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
  ];

  final List<Color> _bloodOptionsColor = [
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
  ];
  final List<Color> _dischargeOptionsColor = [
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
  ];
  final List<Color> _symptomsOptionsColor = [
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
    const Color.fromRGBO(254, 247, 237, 1),
  ];

  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minsController = TextEditingController();

//TODO - Find the better solution to initialize the empty list

  DailyDataInput dailyDataInput =
      DailyDataInput(date: DateTime.now(), symptoms: [""]);

//TODO - Find if there's another alternative
  ThemeData darkThemedata = ThemeCubit().getDarkThemeData();
  ThemeData lightThemeData = ThemeCubit().getLightThemeData();

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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFDED4C5)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.only(left: 25, right: 25)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 20, color: Colors.black)),
                    elevation: MaterialStateProperty.all<double>(5.0),
                  ),
                  onPressed: () async {
                    print("Submit button pressed");
                    dailyDataInput.temperature = _currentSliderValue;
                    //TODO - Change the hours and minutes to a single field
                    dailyDataInput.hoursOfSleep =
                        int.parse(_hoursController.text);

                    try {
                      await UserRepository().sendDailyData(dailyDataInput);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Data Submitted Successfully"),
                        duration: Duration(seconds: 2),
                      ));
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data Submission Failed")));
                    }
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
      color: Theme.of(context).cardTheme.color,
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
      color: Theme.of(context).cardTheme.color,
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
      color: Theme.of(context).cardTheme.color,
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
      color: Theme.of(context).cardTheme.color,
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
      color: Theme.of(context).cardTheme.color,
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
      color: Theme.of(context).cardTheme.color,
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
                    decoration: const InputDecoration(hintText: "Hours"))),
            const Text(":"),
            Expanded(
                child: TextField(
                    controller: _minsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Minutes"))),
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
          if (dailyDataInput.discharge.isEmpty) {
            setState(() {
              _dischargeOptionsColor[Discharge.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.discharge = itemType.toString().split('.').last;
          } else if (dailyDataInput.discharge ==
              itemType.toString().split('.').last) {
            setState(() {
              _dischargeOptionsColor[Discharge.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _dischargeOptionsColor[Discharge.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.discharge = "";
          } else {
            print("Only one discharge can be selected");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _dischargeOptionsColor[Discharge.values.indexOf(itemType)],
          ),
          padding: const EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _dischargeOptionsColor[Discharge.values.indexOf(itemType)] ==
                    const Color.fromRGBO(254, 247, 237, 1)
                ? lightThemeData.textTheme.bodySmall
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
          if (dailyDataInput.blood.isEmpty) {
            setState(() {
              _bloodOptionsColor[Blood.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.blood = itemType.toString().split('.').last;
          } else if (dailyDataInput.blood ==
              itemType.toString().split('.').last) {
            setState(() {
              _bloodOptionsColor[Blood.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _bloodOptionsColor[Blood.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.blood = "";
          } else {
            print("Only one blood type can be selected");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _bloodOptionsColor[Blood.values.indexOf(itemType)],
          ),
          padding: const EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _bloodOptionsColor[Blood.values.indexOf(itemType)] ==
                    const Color.fromRGBO(254, 247, 237, 1)
                ? lightThemeData.textTheme.bodySmall
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
          if (dailyDataInput.energyLevel.isEmpty) {
            setState(() {
              _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.energyLevel = itemType.toString().split('.').last;
          } else if (dailyDataInput.energyLevel ==
              itemType.toString().split('.').last) {
            setState(() {
              _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                      const Color.fromRGBO(254, 247, 237, 1)
                  ? _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                      const Color.fromRGBO(82, 82, 76, 1)
                  : _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] =
                      const Color.fromRGBO(254, 247, 237, 1);
            });
            print(itemType.toString().split('.').last);
            dailyDataInput.energyLevel = "";
          } else {
            print("Only one energy level can be selected");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                    const Color.fromRGBO(254, 247, 237, 1)
                ? _energyOptionsColor[EnergyLevel.values.indexOf(itemType)]
                : const Color.fromRGBO(82, 82, 76, 1),
          ),
          padding: const EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _energyOptionsColor[EnergyLevel.values.indexOf(itemType)] ==
                    const Color.fromRGBO(254, 247, 237, 1)
                ? lightThemeData.textTheme.bodySmall
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
                    const Color.fromRGBO(254, 247, 237, 1)
                ? _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    const Color.fromRGBO(82, 82, 76, 1)
                : _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    const Color.fromRGBO(254, 247, 237, 1);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _symptomsOptionsColor[Symptoms.values.indexOf(itemType)]),
          padding: const EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] ==
                    const Color.fromRGBO(254, 247, 237, 1)
                ? lightThemeData.textTheme.bodySmall
                : darkThemedata.textTheme.bodySmall,
          ),
        ),
      );
    }).toList();
  }
}
