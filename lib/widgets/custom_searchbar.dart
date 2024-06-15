import 'package:dalioz/pages/detail_task_page.dart';
import 'package:dalioz/utility/utility.dart';
import 'package:flutter/material.dart';

import '../constants/constents.dart';
import '../database/data.dart';
import '../models/Task.dart';

class CustomSearchBar extends StatelessWidget {
  final double widthPres;
  const CustomSearchBar({super.key, required this.widthPres});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate:CustomSerachDelegate() );
      },
      child: Container(
        //search
        padding: const EdgeInsets.only(right: 15, left: 10),
        width: MediaQuery.sizeOf(context).width/widthPres,
        height: MediaQuery.sizeOf(context).height / 15,
        decoration: BoxDecoration(
          color: lightSteelBlue,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/icons/Search.png',
              color: blueBill,
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              'Search For A task',
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
            Image.asset(
              'lib/assets/icons/Close.png',
              scale: 0.9,
            )
          ],
        ),
      ),
    );
  }
}

class CustomSerachDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Image.asset('lib/assets/icons/Close-Square-black.png'))];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context,null), icon: Icon(Icons.arrow_back_ios));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> matchQuery = [];
    for (var task in tasksData) {
      if (task.title.toLowerCase().contains(query.trim().toLowerCase())) {
        matchQuery.add(task);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
      Task result = matchQuery[index];
      return GestureDetector(
          onTap: () {
            // TODO Task DETAIL
          },
          child: ListTile(title: Text(result.title),));
    },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Task> matchQuery = [];
    for (var task in tasksData) {
      if (task.title.toLowerCase().contains(query.trim().toLowerCase())) {
        matchQuery.add(task);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        Task result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            query = '';
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailTaskPage(task: result);
            },));
          },
          child: ListTile(title: Text(result.title),
          trailing: Text(formatTime(result.time)),),
        );
      },);
  }
  
}
