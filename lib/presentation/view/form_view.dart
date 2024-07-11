// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/invoice_detail_model.dart';
import '../../data/services/invoice_detail_service.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  Future<List<InvoiceDetail>>? invoiceDetailsList;
  @override
  void initState() {
    invoiceDetailsList = InvoiceDetailService.getInvoiceDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Invoice Details page"),
      ),
      body: FutureBuilder(
        future: invoiceDetailsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (snapshot.hasData) {
            return InvoiceDetailsList(invoiceDetailsList: snapshot.data);
          } else {
            return const Center(
              child: Text("there was an error , please try again later"),
            );
          }
        },
      ),
    );
  }
}

class InvoiceDetailsList extends StatelessWidget {
  const InvoiceDetailsList({super.key, required this.invoiceDetailsList});
  final List<InvoiceDetail>? invoiceDetailsList;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PageController controller = PageController();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.5,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InvoiceDetailsTable(
                    invoiceDetail: invoiceDetailsList![index],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    controller.animateToPage(0,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(Icons.keyboard_double_arrow_left_rounded),
                ),
                IconButton(
                  onPressed: () {
                    controller.previousPage(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.nextPage(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.animateToPage(invoiceDetailsList!.length - 1,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(Icons.keyboard_double_arrow_right_rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InvoiceDetailsTable extends StatelessWidget {
  const InvoiceDetailsTable({
    super.key,
    required this.invoiceDetail,
  });
  final InvoiceDetail invoiceDetail;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InvoiceDetailsTableRow(
          title: "product name",
          value: invoiceDetail.productName ?? "",
        ),
        InvoiceDetailsTableRow(
          title: "unit number",
          value: invoiceDetail.unitNumber.toString(),
        ),
        InvoiceDetailsTableRow(
          title: "price",
          value: invoiceDetail.price.toString(),
        ),
        InvoiceDetailsTableRow(
          title: "quantity",
          value: invoiceDetail.quantity.toString(),
        ),
        InvoiceDetailsTableRow(
          title: "total",
          value: invoiceDetail.total.toString(),
        ),
        InvoiceDetailsTableRow(
          title: "date",
          value: invoiceDetail.expiryDate,
        ),
      ],
    );
  }
}

class InvoiceDetailsTableRow extends StatelessWidget {
  const InvoiceDetailsTableRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
            width: width * 0.6,
            height: height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
