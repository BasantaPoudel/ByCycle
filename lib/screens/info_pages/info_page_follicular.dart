import 'package:flutter/material.dart';

class InfoPageFollicular extends StatelessWidget {
  const InfoPageFollicular({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'What is the follicular phase?'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'The follicular phase is the longest part of your menstrual cycle, lasting between 14 to 21 days. ',
                  ),
                  TextSpan(
                    text:
                        'It begins with your period and continues until ovulation.',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    text:
                        'During the follicular phase, fluid-filled sacs in your ovaries known as follicles contain immature eggs. One of these follicles, called the dominant follicle, holds an ',
                  ),
                  TextSpan(
                    text: 'egg that is growing larger ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'and healthier than the others. ',
                  ),
                  TextSpan(
                    text:
                        'Your pituitary gland releases follicle-stimulating hormone ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '(FSH), which stimulates the formation of a dominant follicle. This ',
                  ),
                  TextSpan(
                    text:
                        'dominant follicle then releases more estrogen into your body, ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'leading to a subsequent decrease in FSH levels.',
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
                    text:
                        'In this phase there’s no significant changes in your basal body temperature.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Mucus'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'During this phase your discharge may vary tremendously. You should beware of any spotting, bleeding or mucus that could signify a vaginal infection.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 47.0),
            _buildSectionTitle(context, 'Symptoms'),
            const SizedBox(height: 14.0),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(
                    text:
                        'During the follicular phase, most women tend to feel ',
                  ),
                  TextSpan(
                    text: 'more energetic, focused, and happier ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'compared to other phases of the menstrual cycle. It\'s also a period when ',
                  ),
                  TextSpan(
                    text: 'sleep usually comes easily.',
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color.fromRGBO(49, 49, 47, 1),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
