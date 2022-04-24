import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/model/entitie/child_history.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../presenter/child_presenter.dart';
import '../../../util/colors.dart';

class ChildBMIChart extends StatelessWidget {
  const ChildBMIChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.29,
      child: Center(
        child: Provider.of<ChildPresenter>(context).getHistoryReady() == 2 ? SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true),
          tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: true),
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeAxis(
            majorGridLines: const MajorGridLines(width: 0),
            //labelPlacement: LabelPlacement.betweenTicks,
            minimum: Provider.of<ChildPresenter>(context).getSelectedChart() == 1 ? Provider.of<ChildPresenter>(context, listen: false).startWeekDate : Provider.of<ChildPresenter>(context, listen: false).startMonthDate,
            maximum: Provider.of<ChildPresenter>(context, listen: false).endDate,
            maximumLabels: 5,
            interval: 2,
            labelStyle: const TextStyle(fontSize: 10),
          ),
          primaryYAxis: NumericAxis(
            labelStyle: const TextStyle(fontSize: 10),
            minimum: 10,
            maximum: 40
          ),
          series: <ChartSeries>[
            SplineSeries<ChildHistory, DateTime>(
              width: 2,
              color: primaryColor,
              dataSource: Provider.of<ChildPresenter>(context).getSelectedChart() == 1 ? Provider.of<ChildPresenter>(context, listen: false).getWeekHistory() : Provider.of<ChildPresenter>(context, listen: false).getMothHistory(),
              xValueMapper: (ChildHistory data, _) => data.date!,
              yValueMapper: (ChildHistory data, _) => data.imc!,
              dataLabelSettings: DataLabelSettings(
                isVisible: false,
                textStyle: GoogleFonts.inter(),
              ),
            ),
          ],
        ) : const CupertinoActivityIndicator(color: primaryColor,),
      ),
    );
  }
}