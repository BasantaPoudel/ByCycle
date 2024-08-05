import 'package:flutter/material.dart';

class InfoPageMenstruation extends StatelessWidget {
  const InfoPageMenstruation({super.key});
  
static const List<String> bleeding = [
  "light",
  "medium",
  "heavy",
  "brown spotting",
  "red spotting",
  "super heavy",
];

static const List<String> symptoms = [
  "anxiety",
  "mood swings",
  "cramps",
  "bloating",
  "nausea",
  "back pain",
  "diarrhea",
  "breast pain",
  "abdominal pain",
  "skin breakouts",
];



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'What is menstrual phase?'),
            const SizedBox(height: 14.0),
            Text.rich(
              //style:  Theme.of(context).textTheme.bodyLarge;
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: 'A menstrual cycle starts with your period ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'or menstruation, which is when ',
                  ),
                  TextSpan(
                    text: 'the uterine lining is shed. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'It may be preceded by PMS and it’s typically when bleeding occurs.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Anatomy'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: 'A healthy period typically lasts between 2 to 7 days, ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'with a blood loss of about 20 to 80 milliliters (about 1 to 6 tablespoons).',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Abnormalities'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Menstrual flow that is significantly heavier or lighter than usual (going through one pad or a tampon in one or two hours).\n',
                  ),
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Bleeding lasting longer than seven days.\n',
                  ),
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Periods accompanied by severe pain, cramping, nausea, or vomiting.\n',
                  ),
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Periods occurring less than 21 days or more than 35 days apart.\n',
                  ),
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Absence of a period for three months (or 90 days).\n',
                  ),
                  TextSpan(
                    text: '• ',
                    style: TextStyle(color: Color.fromRGBO(212, 128, 120, 1)),
                  ),
                  TextSpan(
                    text: 'Sudden red or brown spotting between periods.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Temperature'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: 'You can observe a small ',
                  ),
                  TextSpan(
                    text: 'fall of basal body temperature - approximately 0.22 degree Celsius.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Bleeding'),
            const SizedBox(height: 14.0),
            SizedBox(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _buildBleedingList(),
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Symptoms'),
            const SizedBox(height: 14.0),
            SizedBox(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _buildSymptomsList(),
              ),
            ),
            const SizedBox(height: 47.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '- Cleveland Clinic',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
              ],
            ),
            const SizedBox(height: 55.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color.fromRGBO(49, 49, 47, 1),
            fontWeight: FontWeight.bold,
          ),
    );
  }

  List<Widget> _buildBleedingList() {
    return bleeding.map((itemType) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromRGBO(222, 212, 197, 1),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          itemType,
          style: const TextStyle(fontSize: 13),
        ),
      );
    }).toList();
  }

  List<Widget> _buildSymptomsList() {
    return symptoms.map((itemType) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromRGBO(222, 212, 197, 1),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          itemType,
          style: const TextStyle(fontSize: 13),
        ),
      );
    }).toList();
  }
}
