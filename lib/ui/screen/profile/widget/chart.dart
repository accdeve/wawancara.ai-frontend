import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart'; // Pastikan untuk mengimpor paket DChart
import 'dart:math';

class ChartWidget extends StatelessWidget {
  final List ranking;

  ChartWidget({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBarCustom(
        loadingDuration: const Duration(milliseconds: 1500),
        showLoading: true,
        valueAlign: Alignment.topCenter,
        showDomainLine: true,
        showDomainLabel: true,
        showMeasureLine: true,
        showMeasureLabel: true,
        spaceDomainLabeltoChart: 10,
        spaceMeasureLabeltoChart: 5,
        spaceDomainLinetoChart: 15,
        spaceMeasureLinetoChart: 20,
        spaceBetweenItem: 16,
        radiusBar: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        measureLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.purple,
        ),
        domainLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.purple,
        ),
        measureLineStyle: const BorderSide(color: Colors.amber, width: 2),
        domainLineStyle: const BorderSide(color: Colors.red, width: 2),
        max: 25,
        listData: List.generate(ranking.length, (index) {
          // Random from 'dart:math'
          Color currentColor = Color((Random().nextDouble() * 0xFFFFFF).toInt());
          return DChartBarDataCustom(
            onTap: () {
              print(
                '${ranking[index]['class']} => ${ranking[index]['total']}',
              );
            },
            elevation: 8,
            value: ranking[index]['total'].toDouble(),
            label: ranking[index]['class'],
            color: currentColor.withOpacity(1),
            splashColor: Colors.blue,
            showValue: ranking[index]['class'] == 'C' ? false : true,
            valueStyle: ranking[index]['class'] == 'A'
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  )
                : const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
            valueCustom: ranking[index]['total'] > 20
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${ranking[index]['total']}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Text(
                          '😄',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : null,
            valueTooltip: '${ranking[index]['total']} Student',
          );
        }),
      ),
    );
  }
}
