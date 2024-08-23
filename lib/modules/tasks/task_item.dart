import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        leading: VerticalDivider(
          color: theme.primaryColor,
          thickness: 5,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Play basket ball",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.primaryColor),
            ),
            Row(
              children: [
                Icon(Icons.alarm,size: 18,),
                SizedBox(width: 5,),
                Text(
                  "10:00 Am",
                  style: theme.textTheme.bodySmall

                ),
              ],
            )
          ],
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 10),
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(10),

          ),
          child: Icon(Icons.check,color: Colors.white,size: 35,),
        ),
      ),
    );
  }
}
