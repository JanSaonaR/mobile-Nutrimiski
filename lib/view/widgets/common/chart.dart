import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChildBMIChart extends StatelessWidget {
  const ChildBMIChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('Ene', 34),
      ChartData('Feb', 32),
      ChartData('Mar', 31),
      ChartData('Abr', 26),
      ChartData('May', 28),
      ChartData('Jun', 26),
      ChartData('Jul', 27),
      ChartData('Ago', 25),
      ChartData('Set', 24),
      ChartData('Oct', 23),
      ChartData('Nov', 23.2),
      ChartData('Dic', 23.5),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.29,
      child: Center(
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true),
          tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: true),
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 1),
            //labelPlacement: LabelPlacement.betweenTicks,
            interval: 2,
            labelStyle: GoogleFonts.inter(),
          ),
          primaryYAxis: NumericAxis(
            labelStyle: GoogleFonts.inter(),
            minimum: 20,
            maximum: 40
          ),
          series: <ChartSeries>[
            SplineSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(
                isVisible: false,
                textStyle: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}