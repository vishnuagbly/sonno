import 'package:flutter/services.dart';
import 'package:sonno/constants.dart';

import 'status.dart';

class Parameter {
  const Parameter({String name, List<double> ranges})
      : this._name = name,
        this._ranges = ranges;

  final String _name;
  final List<double> _ranges;

  @override
  int get hashCode => this.toMap().toString().hashCode;

  @override
  bool operator ==(Object other) =>
      other is Parameter && other.hashCode == this.hashCode;

  String get name => _name;

  Map<String, dynamic> toMap() => {
        '_name': _name,
        '_ranges': _ranges,
      };

  double min(Status status) {
    for (int i = 0; i < statuses.length; i++) {
      if (status == statuses[i]) {
        if (i >= _ranges.length) return _ranges.last;
        return _ranges[i];
      }
    }
    throw PlatformException(
      code: 'status not in range',
      details: 'status\n  ${status.text} = ${status.hashString}',
    );
  }

  double max(Status status) {
    for (int i = 0; i < statuses.length; i++) {
      if (status == statuses[i]) {
        if (i + 1 >= _ranges.length) return _ranges.last;
        return _ranges[i + 1];
      }
    }
    throw 'status not in range';
  }

  Status status(double value) {
    for (var status in statuses) {
      if (value >= min(status) && value < max(status)) return status;
    }
    throw PlatformException(
      code: 'value_not_in_range',
      details: 'value: $value\n_ranges: ${_ranges.toString()}',
    );
  }
}

class Parameters {
  Parameters._();

  static const pm25 = Parameter(
    name: 'PM\u2082.\u2085',
    ranges: [0, 30, 60, 90, 150, 250, double.infinity],
  );

  static const pm10 = Parameter(
    name: 'PM\u2081\u2080',
    ranges: [0, 50, 100, 250, 350, 430, double.infinity],
  );

  static const no2 = Parameter(
    name: 'NO\u2082',
    ranges: [0, 40, 80, 180, 280, 400, double.infinity],
  );

  static const nh3 = Parameter(
    name: 'NH\u2083',
    ranges: [0, 200, 400, 800, 1200, 1800, double.infinity],
  );

  static const co = Parameter(
    name: 'CO',
    ranges: [0, 1, 2, 10, 17, 34, double.infinity],
  );

  static const so2 = Parameter(
    name: 'SO\u2082',
    ranges: [0, 40, 80, 380, 800, 1600, double.infinity],
  );

  static const o3 = Parameter(
    name: 'O\u2083',
    ranges: [0, 50, 100, 200, 265, 748, double.infinity],
  );

  static const aqi = Parameter(
    name: 'AQI',
    ranges: [0, 50, 100, 200, 300, 400, double.infinity],
  );

  static List<Parameter> get values => [
        Parameters.pm25,
        Parameters.pm10,
        Parameters.no2,
        Parameters.nh3,
        Parameters.co,
        Parameters.so2,
        Parameters.o3,
        Parameters.aqi,
      ];
}
