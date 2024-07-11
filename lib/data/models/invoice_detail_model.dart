import 'package:appy/data/models/unit_model.dart';

class InvoiceDetail {
  final int lineNumber;
  final String? productName;
  final UnitModel? unit;
  final int unitNumber;
  final double price;
  final double quantity;
  final double total;
  final String expiryDate;

  InvoiceDetail(
      {required this.lineNumber,
      this.productName,
      this.unit,
      required this.unitNumber,
      required this.price,
      required this.quantity,
      required this.total,
      required this.expiryDate});
  factory InvoiceDetail.fromJson(jsonData) {
    return InvoiceDetail(
        lineNumber: jsonData["lineNo"],
        productName: jsonData["productName"],
        unit: jsonData['unit'] == null
            ? null
            : UnitModel.fromJson(jsonData['unit']),
        unitNumber: jsonData['unitNo'],
        price: jsonData["price"],
        quantity: jsonData["quantity"],
        total: jsonData["total"],
        expiryDate: jsonData["expiryDate"]);
  }
}
