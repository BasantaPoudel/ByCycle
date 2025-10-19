import 'package:by_cycle/screens/info_pages/common.dart';
import 'package:flutter/material.dart';

class InfoPageLuteal extends StatelessWidget {
  const InfoPageLuteal({super.key});

  static const List<String> mucus = [
    "sticky",
    "clumpy white",
    "no discharge",
    "creamy",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, 'What is luteal phase?'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'The luteal phase happens in the second part of your menstrual cycle. ',
                  ),
                  TextSpan(
                    text: 'It begins around day 15 ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'of a 28-day cycle and '),
                  TextSpan(
                    text: 'concludes with the onset of menstruation. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'During this phase, the uterine lining thickens in preparation for a potential pregnancy.',
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
                    text: 'During this phase of your cycle, ',
                  ),
                  TextSpan(
                    text:
                        'an egg moves from the ovary through the fallopian tube to the uterus. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          'If the egg is fertilized by sperm, it implants into the uterine lining, leading to pregnancy. If the egg is not fertilized or does not implant,  '),
                  TextSpan(
                    text:
                        'menstruation begins, marking the end of the luteal phase.',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                        'If you take your temperature immediately after waking, you’ll notice a slight ',
                  ),
                  TextSpan(
                    text: 'increase in your body temperature after ovulation. ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'The shift can be as little as ',
                  ),
                  TextSpan(
                    text: '0.22 degrees Celsius.',
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
                        'During ovulation, your discharge is wet and slippery, resembling egg whites. ',
                  ),
                  TextSpan(
                    text:
                        'In the luteal phase, it dries up and thickens creating paste-like consistency.',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    text:
                        'The symptoms experienced during the luteal phase are ',
                  ),
                  TextSpan(
                    text: 'similar to those of premenstrual syndrome (PMS).',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
}
