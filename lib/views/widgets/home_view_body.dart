import 'dart:developer';
import 'package:calculator_app/constatnt.dart';
import 'package:calculator_app/manager/cubit/calculator_cubit.dart';
import 'package:calculator_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (context) => CalculatorCubit(),
        child: BlocBuilder<CalculatorCubit, CalculatorState>(
          builder: (context, state) {
            String displayText = '0';
            if (state is CalculatorInitial) {
              displayText = state.displayText;
            } else if (state is CalculatorResult) {
              displayText = state.result;
            } else if (state is CalculatorError) {
              displayText = state.errorMessage;
            }
            return Column(
              children: [
                Container(
                    height: 170,
                    color: Colors.grey[300],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          displayText,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 16,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        return CustomButton(
                          num: buttons[index],
                          onTap: () {
                            context
                                .read<CalculatorCubit>()
                                .onButtonPressed(buttons[index]);
                            log('Button Pressed: ${buttons[index]}');
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
                            context
                                .read<CalculatorCubit>()
                                .onButtonPressed('=');
                            log('Button Pressed: =');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
