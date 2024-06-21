import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class ExpandableDetailTile extends StatelessWidget {
  final String title;
  final String? type;
  final String description;

  const ExpandableDetailTile({
    Key? key,
    required this.title,
    this.type,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.zero,
        color: Theme.of(context).brightness != Brightness.dark
            ? Theme.of(context).cardColor
            : AppColors.gray2,
        child: ExpansionTile(
          iconColor: AppColors.blue1,
          collapsedIconColor: AppColors.blue1,
          title: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.white)),
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              title: type != null
                  ? Text(type!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500, color: AppColors.white))
                  : null,
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.white),
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
