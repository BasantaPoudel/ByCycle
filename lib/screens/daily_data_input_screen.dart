import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
  // NO,
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
  var logger = Logger();
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
    // const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5),
    const Color(0xFFDED4C5)
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
        iconTheme: Theme.of(context).brightness == Brightness.light
            ? const IconThemeData(color: Colors.black)
            : const IconThemeData(color: Colors.white),
        title: const Text('Daily Data Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'To get the most out of your syncing experience, it\'s important to log your symptoms!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              _buildTemperatureCard(),
              _buildDischargeCard(),
              _buildSleepCard(),
              _buildEnergyLevelCard(),
              _buildBloodCard(),
              _buildSymtomsCard(),
              SizedBox(
                width: 224,
                height: 44,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor:
                            // _hoursController.text == "" ||
                            //         _minsController.text == ""
                            //     ? MaterialStateProperty.all<Color>(
                            //         const Color(0xFFDED4C5))
                            // :
                            WidgetStateProperty.all<Color>(
                                const Color.fromRGBO(1, 1, 1, 1))),
                    onPressed: () async {
                      logger.d("Submit button pressed");
                      dailyDataInput.temperature = _currentSliderValue;
                      //TODO
                      //Hours of sleep is stored in minutes
                      if (_hoursController.text != "" &&
                          _minsController.text != "") {
                        dailyDataInput.hoursOfSleep =
                            int.parse(_hoursController.text) * 60 +
                                int.parse(_minsController.text);
                        try {
                          await UserRepository()
                              .saveDailyDataInputData(dailyDataInput);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Data Submitted Successfully"),
                            duration: Duration(seconds: 2),
                          ));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Data Submission Failed")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter amount of sleep")));
                      }
                    },
                    child: const Text('Submit')),
              ),
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
      info:
          'Measuring temperature helps to understand the menstrual phase of the cycle by providing insight into hormonal fluctuations and identifying ovulation, which is crucial for fertility tracking and health monitoring.',
      infoSource: '– Journal of Obstetric, Gynecologic, and Neonatal Nursing',
      padding: const EdgeInsets.all(16.0),
      onPressed: () {
        logger.d('Temperature card tapped');
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
              logger.d("object");
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
      info:
          'Cervical mucus is another important indicator of where a person is in their menstrual cycle. The consistency and amount of cervical mucus change throughout the cycle due to hormonal fluctuations.',
      infoSource:
          '– Hilgers, (2012). The ovulation method - natural family planning. Omaha, NE: Pope Paul VI Institute Press.',
      color: Theme.of(context).cardTheme.color,
      onPressed: () {
        // setState(() {
        //   _dischargeOptionsColor = Color.fromARGB(255, 34, 33, 32);
        // });
        logger.d('Discharge info tapped');
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
      info:
          'Tracking energy levels alongside menstrual cycle phases and sleep patterns helps to identify correlations and better understand how hormonal changes affect their energy levels and sleep quality throughout the cycle.',
      infoSource:
          '– Baker, (1999). Circadian rhythms, sleep, and the menstrual cycle. ',
      title: 'EnergyLevel',
      color: Theme.of(context).cardTheme.color,
      onPressed: () {
        logger.d('Energy info tapped');
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
      info:
          'Blood is important indicator of where a person is in their menstrual cycle..',
      infoSource: '– Journal of Obstetric, Gynecologic, and Neonatal Nursing',
      title: 'Blood',
      color: Theme.of(context).cardTheme.color,
      onPressed: () {
        logger.d('Blood info tapped');
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
      info:
          'Most women experience mild symptoms in the few days leading up to menstruation and in the first day or two of menstruating when the flow of blood is heavier.',
      infoSource: '– Society of Obstetricians and Gynaecologists of Canada',
      title: 'Symptoms',
      color: Theme.of(context).cardTheme.color,
      onPressed: () {
        logger.d('Symptoms info tapped');
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
      info:
          ' Consistently logging sleep  can indicate potential sleep problems or lifestyle factors that need adjustment.',
      infoSource:
          '– Buysse, D. J. (2014). Sleep health: Can we define it? Does it matter? Sleep. ',
      title: 'Hours Of Sleep',
      color: Theme.of(context).cardTheme.color,
      onPressed: () {
        logger.d('Hours info tapped');
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
            logger.d(itemType.toString().split('.').last);
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
            logger.d(itemType.toString().split('.').last);
            dailyDataInput.discharge = "";
          } else {
            logger.d("Only one discharge can be selected");
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
            logger.d(itemType.toString().split('.').last);
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
            logger.d(itemType.toString().split('.').last);
            dailyDataInput.blood = "";
          } else {
            logger.d("Only one blood type can be selected");
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
            logger.d(itemType.toString().split('.').last);
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
            logger.d(itemType.toString().split('.').last);
            dailyDataInput.energyLevel = "";
          } else {
            logger.d("Only one energy level can be selected");
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
          logger.d(itemType.toString().split('.').last);

          // if (itemType.toString().split('.').last == "NO") {
          //   dailyDataInput.symptoms.clear();
          //   for (int i = 0; i < _symptomsOptionsColor.length; i++) {
          //     setState(() {
          //       _symptomsOptionsColor[i] = Color(0xFFDED4C5);
          //     });
          //   }
          // }

          dailyDataInput.symptoms.contains(itemType.toString().split('.').last)
              ? dailyDataInput.symptoms
                  .remove(itemType.toString().split('.').last)
              : dailyDataInput.symptoms
                  .add(itemType.toString().split('.').last);

          setState(() {
            _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] ==
                    const Color(0xFFDED4C5)
                ? _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    const Color.fromRGBO(82, 82, 76, 1)
                : _symptomsOptionsColor[Symptoms.values.indexOf(itemType)] =
                    const Color(0xFFDED4C5);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFEF7ED)),
          padding: const EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // itemType.toString().split('.').last == "NO"
              //     ?
              Icon(Icons.circle_outlined,
                  color:
                      _symptomsOptionsColor[Symptoms.values.indexOf(itemType)]),
              Text(
                itemType.toString().split('.').last,
                style: lightThemeData.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
