library package;

class FyPackageName {
  static final FyPackageName instance = FyPackageName._internal();
  factory FyPackageName() => instance;
  FyPackageName._internal() : super();
} //ex: FyAlerts, FyMarketDepth
