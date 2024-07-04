import 'package:by_cycle/models/User.dart';
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
  @override
  _DailyDataInputState createState() => _DailyDataInputState();
}

class _DailyDataInputState extends State<DailyDataInputScreen> {
  double _currentSliderValue = 35;

//TODO - Find the better solution to initialize the empty list

  DailyDataInput dailyDataInput =
      DailyDataInput(date: DateTime.now(), symptoms: [""]);

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
              _buildCard1(),
              _buildEnergyLevelCard(),
              _buildCard2(),
              _buildCard3(),
              _buildCard4(),
              _buildCard2(),
              _buildCard2(),
              ElevatedButton(
                  onPressed: () {
                    print("Submit button pressed");
                    UserRepository().sendDailyData(dailyDataInput);
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  _buildCard1() {
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
            min: 34,
            max: 38.5,
            divisions: 5,
            label: "$_currentSliderValue",
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              print("object");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('34°C'),
              Text('38.5°C'),
            ],
          ),
        ],
      ),
    );
  }

  _buildCard2() {
    return CustomCard(
      title: 'Discharge',
      color: Color.fromRGBO(222, 212, 197, 1),
      onPressed: () {
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

  _buildCard3() {
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

  _buildCard4() {
    return CustomCard(
      title: 'Symptoms',
      color: Color.fromRGBO(222, 212, 197, 1),
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

  List<GestureDetector> _buildDischargeList() {
    return Discharge.values.map((itemType) {
      return GestureDetector(
        onTap: () {
          print("Gesture Detected");
          print(itemType.toString().split('.').last);
          dailyDataInput.discharge = itemType.toString().split('.').last;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(254, 247, 237, 1),
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: TextStyle(color: Colors.black, fontSize: 11.0),
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
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(254, 247, 237, 1),
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: TextStyle(color: Colors.black, fontSize: 11.0),
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
          dailyDataInput.symptoms.add(itemType.toString().split('.').last);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(254, 247, 237, 1),
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: TextStyle(color: Colors.black, fontSize: 11.0),
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
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(254, 247, 237, 1),
          ),
          padding: EdgeInsets.all(3.0),
          // margin: EdgeInsets.all(8.0),
          child: Text(
            itemType.toString().split('.').last,
            style: TextStyle(color: Colors.black, fontSize: 11.0),
          ),
        ),
      );
    }).toList();
  }
}
