import 'package:by_cycle/screens/info_pages/common.dart';
import 'package:flutter/material.dart';

class InfoPageOvulation extends StatelessWidget {
  const InfoPageOvulation({super.key});

  static const List<String> mucus = [
    "egg white",
    "watery",
  ];

  static const List<String> symptoms = [
    "bloating",
    "anxiety",
    "breast pain",
    "abdominal pain",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, 'What is the ovulatory phase?'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'Ovulation takes place when your ovary releases an egg, typically around the 14th day of a 28-day menstrual cycle. ',
                  ),
                  TextSpan(
                    text: 'This is when you\'re at your most fertile.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            buildSectionTitle(context, 'Anatomy'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'After an egg is released from your ovary, it travels down the fallopian tube, waiting to be fertilized by sperm. Between days 10 and 14 of the cycle, only one developing follicle produces a fully mature egg. Around day 14, a sharp increase in luteinizing hormone triggers the ovary to release the egg, marking ovulation. Following ovulation, progesterone levels rise to help prepare the uterus for a potential pregnancy.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            buildSectionTitle(context, 'Temperature'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'Right after ovulation there’s a surge in your basal body temperature. If you measure your temperature everyday in the morning and you observe ',
                  ),
                  TextSpan(
                    text: 'a rise higher than 0.22 degree Celsius ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'which persists for over 2 days, ',
                  ),
                  TextSpan(
                    text:
                        'that may signify the end of ovulation and entering the luteal phase.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            buildSectionTitle(context, 'Mucus'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'During ovulation, when your ovaries release an egg, ',
                  ),
                  TextSpan(
                    text:
                        'your discharge may become particularly slippery and wet. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'This change helps sperm swim more easily to reach the egg for fertilization.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _buildMucusList(),
              ),
            ),
            const SizedBox(height: 47.0),
            buildSectionTitle(context, 'Symptoms'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text: 'During ovulation people typically feel ',
                  ),
                  TextSpan(
                    text:
                        'more attractive, energetic, sociable and have an increased sex drive. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'However some of the symptoms may be ',
                  ),
                  TextSpan(
                    text: 'similar to the ones of PMS, ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'but are perfectly normal.',
                  ),
                ],
              ),
            ),
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

  List<Widget> _buildMucusList() {
    return mucus.map((itemType) {
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
