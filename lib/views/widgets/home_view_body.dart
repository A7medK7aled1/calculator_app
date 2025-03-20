import 'dart:developer';

import 'package:calculator_app/constatnt.dart';
import 'package:calculator_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              height: 170,
              color: Colors.grey[300],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return CustomButton(
                    num: buttons[index],
                    onTap: () {
                      log('Button ${buttons[index]} Pressed');
                    },
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    num: '=',
                    onTap: () {
                      log('Button = Pressed');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
