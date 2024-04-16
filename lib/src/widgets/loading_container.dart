import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 280),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0x592f2f2f),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: const Color(0x662f2f2f),
            ),
            height: 14,
          ),
        ),
        const Divider(
          height: 6.0,
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 80),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0x592f2f2f),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        color: const Color(0x592f2f2f),
      ),
      height: 18,
    );
  }
}
