import 'package:flutter/material.dart';

class ExpandableDetailTile extends StatelessWidget {
  final String title;
  final String? type;
  final String? year;
  final String? icon;
  final String? onGoingMeds;
  final String? familyHistory;
  final String? medicalHistory;
  final String? reasonForVisit;
  final int? age;
  final String? gender;
  final String? weight;
  final String? height;
  final bool? vitals;
  final bool? hasBP;
  final bool? hasSugar;
  final String? qualification;
  final String? specialization;
  final int? years;

  const ExpandableDetailTile({
    super.key,
    required this.title,
    this.type,
    this.icon,
    this.year,
    this.reasonForVisit,
    this.onGoingMeds,
    this.familyHistory,
    this.medicalHistory,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.vitals,
    this.hasBP,
    this.hasSugar,
    this.years,
    this.qualification,
    this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    String toTitleCase(String text) => text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconColor: Theme.of(context).cardColor,
          collapsedIconColor: Theme.of(context).cardColor,
          title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  if (icon != null)
                    SizedBox(
                      width: 50,
                      child: Image.asset(icon!),
                    ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 23)),
                  ),
                ],
              )),
          children: [
            if (reasonForVisit != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: _buildDetailRow(
                  context,
                  'Reason: ',
                  toTitleCase(reasonForVisit!),
                ),
              ),
            if (medicalHistory != null)
              _buildExpandableDetail(
                context,
                [
                  _buildDetailRow(context, 'Type: ', toTitleCase(type!)),
                  _buildDetailRow(context, 'Year: ', toTitleCase(year!)),
                  _buildDetailColumn(context, 'Description: ', medicalHistory!),
                ],
              ),
            if (familyHistory != null)
              _buildExpandableDetail(
                context,
                [
                  _buildDetailRow(context, 'Type: ', toTitleCase(type!)),
                  _buildDetailColumn(context, 'Description: ', familyHistory!),
                ],
              ),
            if (onGoingMeds != null)
              ..._buildOngoingMeds(context, onGoingMeds!),
            if (height != null && weight != null)
              _buildExpandableDetail(
                context,
                [
                  _buildDetailRow(context, 'Height: ', height.toString()),
                  _buildDetailRow(context, 'Weight: ', weight.toString()),
                ],
              ),
            if (age != null)
              _buildExpandableDetail(
                context,
                [
                  _buildDetailRow(context, 'Age: ', age.toString()),
                  _buildDetailRow(context, 'Gender: ', gender.toString()),
                ],
              ),
            if (vitals == true) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          _buildListTileWithCheckbox(
                            context,
                            'Blood Pressure',
                            hasBP!,
                          ),
                          _buildListTileWithCheckbox(
                            context,
                            'Sugar',
                            hasSugar!,
                          ),
                        ],
                      )))
            ],
            if (years != null && specialization != null)
              _buildExpandableDetail(
                context,
                [
                  _buildDetailRow(context, 'Experience: ', '${years!} year'),
                  _buildDetailColumn(
                      context, 'Specialization: ', specialization!),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Material(
      elevation: 4.0,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 60.0),
            Flexible(
              flex: 2,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Flexible(
              flex: 4,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 60.0),
        Flexible(
          flex: 4,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Flexible(
          flex: 4,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 60.0),
            Flexible(
              flex: 2,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 63.0, right: 16.0, top: 8.0),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableDetail(BuildContext context, List<Widget> detailRows) {
    return Material(
      elevation: 4.0,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _addSpacingBetweenWidgets(detailRows, 12.0),
        ),
      ),
    );
  }

  Widget _buildListTileWithCheckbox(
      BuildContext context, String title, bool value) {
    return Padding(
      padding: const EdgeInsets.only(left: 65.0, right: 30.0),
      child: ListTile(
        trailing: Checkbox(
          activeColor: Theme.of(context).cardColor,
          value: value,
          onChanged: (bool? newValue) {},
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  List<Widget> _addSpacingBetweenWidgets(List<Widget> widgets, double spacing) {
    List<Widget> spacedWidgets = [];
    for (var i = 0; i < widgets.length; i++) {
      spacedWidgets.add(widgets[i]);
      if (i < widgets.length - 1) {
        spacedWidgets.add(SizedBox(height: spacing));
      }
    }
    return spacedWidgets;
  }

  List<Widget> _buildOngoingMeds(BuildContext context, String meds) {
    List<String> medsList = meds.split(',');
    return [
      Material(
        elevation: 4.0,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _addSpacingBetweenWidgets(
              medsList
                  .map((med) => Row(
                        children: [
                          const SizedBox(width: 60.0),
                          const Text('• ', style: TextStyle(fontSize: 16.0)),
                          Expanded(
                            child: Text(
                              med.trim(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ))
                  .toList(),
              12.0,
            ),
          ),
        ),
      )
    ];
  }
}
