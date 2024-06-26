import 'package:flutter/material.dart';

class ExpandableDetailTile extends StatelessWidget {
  final String title;
  final String? type;
  final String? year;
  final String? icon;
  final String? onGoingMeds;
  final String? description;
  final String? reasonForVisit;
  final double? weight;
  final double? height;

  const ExpandableDetailTile({
    super.key,
    required this.title,
    this.type,
    this.icon,
    this.year,
    this.reasonForVisit,
    this.onGoingMeds,
    this.description,
    this.weight,
    this.height,
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
          title: Row(children: [
            if (icon != null)
              SizedBox(
                width: 50,
                child: Image.asset(icon!),
              ),
            const SizedBox(width: 12.0),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ]),
          children: [
            if (reasonForVisit != null) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      child: Row(children: [
                        if (icon != null)
                          const SizedBox(
                            width: 75,
                          ),
                        Text('Reason: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(
                          toTitleCase(reasonForVisit!),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ]))),
            ],
            if (type != null && year != null && description != null) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Type: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                toTitleCase(type!),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ]),
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Year: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                toTitleCase(year!),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ]),
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Description: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                description!,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                          ]))),
            ],
            if (type != null && description != null) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Type: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                toTitleCase(type!),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ]),
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Description: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                description!,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                          ]))),
            ],
            if (onGoingMeds != null) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      child: Row(children: [
                        if (icon != null)
                          const SizedBox(
                            width: 75,
                          ),
                        Text('OnGoing Meds: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(
                          toTitleCase(onGoingMeds!),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ]))),
            ],




                       if (height != null && weight!=null) ...[
              Material(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Height: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                height.toString()!,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ]),
                            Row(children: [
                              if (icon != null)
                                const SizedBox(
                                  width: 75,
                                ),
                              Text('Weight: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                weight.toString()!,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ]),
                            
                          ]))),
            ],
          ],
        ),
      ),
    );
  }
}
