import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class SalesPipelineTable extends StatefulWidget {
  @override
  _SalesPipelineTableState createState() => _SalesPipelineTableState();
}

class _SalesPipelineTableState extends State<SalesPipelineTable> {
  late SalesDataSource salesDataSource;

  @override
  void initState() {
    super.initState();
    salesDataSource = SalesDataSource(getSalesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDataGrid(
        source: salesDataSource,
        columns: <GridColumn>[
          GridColumn(columnName: 'quote', label: buildHeader('Quote'), width: 200),
          GridColumn(columnName: 'amount', label: buildHeader('Amount'), width: 100),
          GridColumn(columnName: 'status', label: buildHeader('Status'), width: 100),
          GridColumn(columnName: 'callDate', label: buildHeader('Call Date'), width: 120),
          GridColumn(columnName: 'meetingDate', label: buildHeader('Meeting Date'), width: 120),
          GridColumn(columnName: 'followUp', label: buildHeader('Follow-up Quote'), width: 150),
        ],
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
      ),
    );
  }

  Widget buildHeader(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          textAlign: TextAlign.center),
    );
  }
}

// Model for Sales Data
class Sales {
  final String imagePath;
  final String quote;
  final String amount;
  final String status;
  final String callDate;
  final String meetingDate;
  final String followUp;

  Sales(this.imagePath, this.quote, this.amount, this.status, this.callDate, this.meetingDate, this.followUp);
}

// Data Source for DataGrid
class SalesDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  SalesDataSource(List<Sales> salesList) {
    dataGridRows = salesList.map<DataGridRow>((sales) {
      return DataGridRow(cells: [
        DataGridCell<Sales>(columnName: 'quote', value: sales), // Pass object for custom UI
        DataGridCell<String>(columnName: 'amount', value: sales.amount),
        DataGridCell<String>(columnName: 'status', value: sales.status),
        DataGridCell<String>(columnName: 'callDate', value: sales.callDate),
        DataGridCell<String>(columnName: 'meetingDate', value: sales.meetingDate),
        DataGridCell<String>(columnName: 'followUp', value: sales.followUp),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataCell) {
          if (dataCell.columnName == 'quote') {
            final sales = dataCell.value as Sales;
            return buildQuoteCell(sales);
          }
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8),
            child: Text(dataCell.value.toString(),
                style: TextStyle(fontSize: 14, color: Colors.black)),
          );
        }).toList());
  }

  Widget buildQuoteCell(Sales sales) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(sales.imagePath), // Use networkImage if required
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            sales.quote,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Sample Data with Images
List<Sales> getSalesData() {
  return [
    Sales('assets/user1.png', 'Quote for 150 carpets', '\$40,000', 'New', '02/08/2025', '', ''),
    Sales('assets/user2.png', 'Office Design and Architecture', '\$9,000', 'Won', '02/09/2025', '', ''),
    Sales('assets/user3.png', 'Quote for 12 Tables', '\$40,000', 'Qualified', '03/10/2025', '', ''),
    Sales('assets/user4.png', '5 VP Chairs', '\$5,600', 'Qualified', '03/17/2025', '', ''),
    Sales('assets/user5.png', 'Need 20 Desks', '\$60,000', 'Won', '03/17/2025', '', ''),
    Sales('assets/user6.png', 'Quote for 600 Chairs', '\$22,500', 'New', '04/19/2025', '04/20/2025', ''),
    Sales('assets/user7.png', 'Modern Open Space', '\$4,500', 'Double Won', '07/18/2025', '', ''),
  ];
}
