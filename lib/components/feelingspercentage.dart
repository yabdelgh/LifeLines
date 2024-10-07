import 'package:LifeLines/components/chart.dart';
import 'package:flutter/material.dart';

Map<String, int> tmp(List notes)
{
  Map<String, int> toto = {};
  // int some = notes.values.fold(0.0, (sum, value) => sum + value)
  int some = 0;
  for (var map in notes)
  {
    toto[map['data']['feeling'].toString()] = 
    toto[map['data']['feeling'].toString()] == null ? 1 : toto[map['data']['feeling'].toString()]! + 1; 
    some += toto[map['data']['feeling'].toString()] == null ? 0 : 1; 
    // debugPrint(map['data']['createdAt'].toString());
    // var tmp = map['data']['createdAt']?.toDate();
    // debugPrint(tmp.month.toString());
    // debugPrint(map['data']['createdAt'].toString());
    // debugPrint(Timestamp.now().toString());
  }
  toto.forEach((key, val) => toto[key] = (val * 100 / some).round() );
  debugPrint(toto.toString());
  return toto;
}

class FeelingsPercentage extends StatelessWidget
{
  final List<Map<String, dynamic>> notes;
  const FeelingsPercentage({super.key, required this.notes});

  @override
  Widget build(BuildContext context)
  {
    return PieChartSample3(notes: tmp(notes));
  }
}