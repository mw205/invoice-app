import 'package:appy/data/models/invoice_detail_model.dart';
import 'package:appy/mystrings.dart';
import 'package:dio/dio.dart';

class InvoiceDetailService {
  static Dio dio = Dio();
  static Future<List<InvoiceDetail>> getInvoiceDetail() async {
    BaseOptions options = BaseOptions(
        baseUrl: Mystrings.baseUrl, headers: {"accept": "application/json"});
    dio = Dio(options);
    try {
      Response response =
          await dio.get("${Mystrings.baseUrl}${Mystrings.invoiceDetail}");
      List<InvoiceDetail> invoiceDetailList = [];
      for (var element in response.data) {
        invoiceDetailList.add(InvoiceDetail.fromJson(element));
      }
      print(invoiceDetailList.first.lineNumber);
      return invoiceDetailList;
    } on DioException catch (e) {
      throw Exception();
    }
  }
}
