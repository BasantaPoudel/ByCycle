import 'package:by_cycle/algorithms/update_users_algorithm_data.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  static const List<String> Blood = [
    "sticky",
    "clumpy",
    "white",
    "no discharge",
    "creamy",
  ];
  final UserModel currentUser;

  const InfoPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    // Compute the index of today
    final indexOfToday = findDailyDataInputIndexByDate(
        currentUser.dailyDataInput, DateTime.now());
    final currentPhase = currentUser.dailyDataInput[indexOfToday].phase;

    // Compute the progress and phase color
    final currentDateTimeRange = findCurrentPhaseDateTimeRange(currentUser);
    final phaseProgressPercentage =
        findProgressPercentage(currentDateTimeRange);
    final phaseColor = _getPhaseColor(currentPhase);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You\'re in the $currentPhase phase',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: phaseProgressPercentage,
                  backgroundColor: const Color.fromRGBO(222, 212, 197, 1),
                  valueColor: AlwaysStoppedAnimation<Color>(phaseColor),
                ),
              ),
              const SizedBox(height: 47.0),
              _buildSectionTitle(context, 'What is luteal phase?'),
              const SizedBox(height: 14.0),
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
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
                      text: 'ends when you get your period. ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'The luteal phase prepares your uterus for pregnancy by thickening your uterine lining.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 47.0),
              _buildSectionTitle(context, 'Anatomy'),
              const SizedBox(height: 14.0),
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(
                      text: 'During this phase of your cycle, an ',
                    ),
                    TextSpan(
                      text: 'egg travels from your ovary ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'through your fallopian tube and '),
                    TextSpan(
                      text: 'to your uterus. ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'If sperm fertilizes that egg, the fertilized egg implants into your uterine lining and pregnancy occurs. ',
                    ),
                    TextSpan(
                      text: 'If the egg isn’t fertilized ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: 'or doesn’t implant (pregnancy doesn’t occur), '),
                    TextSpan(
                      text: 'you’ll get your period. ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Your luteal phase is over when you get your period.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 47.0),
              _buildSectionTitle(context, 'Temperature'),
              const SizedBox(height: 14.0),
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(
                      text:
                          'If you take your temperature immediately after waking, you’ll notice a slight ',
                    ),
                    TextSpan(
                      text:
                          'increase in your body temperature after ovulation. ',
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
              _buildSectionTitle(context, 'Mucus'),
              const SizedBox(height: 14.0),
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(
                      text:
                          'During ovulation, your discharge is wet and slippery like egg whites. It gets ',
                    ),
                    TextSpan(
                      text: 'thick, dry and paste-like in the luteal phase.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14.0),
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.5,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _buildMucusList(),
                ),
              ),
              const SizedBox(height: 47.0),
              _buildSectionTitle(context, 'Symptoms'),
              const SizedBox(height: 14.0),
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(
                      text:
                          'Symptoms of the luteal phase resemble those that happen during ',
                    ),
                    TextSpan(
                      text: 'PMS (premenstrual syndrome).',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 47.0),
              Text(
                '- Cleveland Clinic',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const SizedBox(height: 55.0),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPhaseColor(String? phase) {
    switch (phase) {
      case 'follicular':
        return const Color(0xFF8E79BB);
      case 'ovulation':
        return const Color(0xFF85A79D);
      case 'luteal':
        return const Color(0xFFD6A879);
      case 'menstruation':
        return const Color(0xFFD48078);
      default:
        return Colors.grey; // Default color
    }
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.shade300,
    );
  }

  findCurrentPhaseDateTimeRange(UserModel? user) {
    var currentPhaseDateTimeRange = CustomDateTimeRange(
        start: DateTime.now(), end: DateTime.now(), phase: '');
    if (user?.phaseRanges == null) return currentPhaseDateTimeRange;
    user?.phaseRanges.firstWhere((element) {
      var phaseStart =
          DateTime(element.start.year, element.start.month, element.start.day);
      var phaseEnd =
          DateTime(element.end.year, element.end.month, element.end.day);
      var currentTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      logger.d('Phase start: $phaseStart');
      logger.d('Phase end: $phaseEnd');
      logger.d('Current time: $currentTime');

      if ((currentTime.isAfter(phaseStart) && currentTime.isBefore(phaseEnd)) ||
          currentTime.isAtSameMomentAs(phaseStart) ||
          currentTime.isAtSameMomentAs(phaseEnd)) {
        currentPhaseDateTimeRange = element;
        return true;
      }
      return false;
    });
    return currentPhaseDateTimeRange;
    // return null;
  }

  findProgressPercentage(currentDateTimeRange) {
    var phaseStart = DateTime(currentDateTimeRange.start.year,
        currentDateTimeRange.start.month, currentDateTimeRange.start.day);
    var phaseEnd = DateTime(currentDateTimeRange.end.year,
        currentDateTimeRange.end.month, currentDateTimeRange.end.day);
    var currentTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    //Added one day to adjust the difference in days
    var totalLength = phaseEnd.difference(phaseStart).inDays + 1;
    var currentProgress = currentTime.difference(phaseStart).inDays + 1;

    var progressPercentage = currentProgress / totalLength;
    return progressPercentage;
    // return
  }

  List<Widget> _buildMucusList() {
    return Blood.map((itemType) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromRGBO(222, 212, 197, 1),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          itemType.toString().split('.').last,
          style: TextStyle(fontSize: 13), // Optional: Customize text style here
        ),
      );
    }).toList();
  }
}
