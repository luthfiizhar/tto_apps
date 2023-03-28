import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/constant/constant.dart';
import 'package:tto_apps/constant/text.dart';
import 'package:tto_apps/main_model.dart';
import 'package:tto_apps/pages/history_detail_page.dart';
import 'package:tto_apps/pages/lp_approval_page.dart';
import 'package:tto_apps/widgets/layout_page.dart';
import 'package:http/http.dart' as http;
import 'package:tto_apps/widgets/notif_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List formList = [];

  bool isLoading = false;

  pullRefresh() async {
    getListForm().then((value) {
      setState(() {
        isLoading = false;
        formList = value['Data'];
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialogBlack(
          title: 'Gagal konek ke API',
          contentText: error.toString(),
        ),
      );
    });
  }

  Future getListForm() async {
    setState(() {
      isLoading = true;
    });
    var url =
        Uri.https(apiUrlGlobal, 'ExitPassHOBackend/public/api/form/history');
    Map<String, String> requestHeader = {"Content-Type": "application/json"};

    var bodySend = """
    {
      "Status": "",
      "Keyword": ""
    }
    """;

    try {
      var response =
          await http.post(url, body: bodySend, headers: requestHeader);

      var data = json.decode(response.body);

      return data;
    } on Error catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListForm().then((value) {
      print(value['Data']);
      setState(() {
        isLoading = false;
        formList = value['Data'];
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialogBlack(
          title: 'Gagal konek ke API',
          contentText: error.toString(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: RefreshIndicator(
          onRefresh: () => pullRefresh(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Daftar Transaksi Selesai',
                    style: helveticaText.copyWith(
                      fontSize: 22,
                      color: eerieBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: eerieBlack,
                          ),
                        )
                      : formList.isEmpty
                          ? Center(
                              child: Text(
                              'Data tidak tersedia',
                              style: helveticaText.copyWith(
                                fontSize: 16,
                              ),
                            ))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: formList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HistoryDetailPage(
                                            formId: formList[index]['FormID'],
                                            status: formList[index]['Status'],
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        setState(() {});
                                        pullRefresh();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: platinum,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    formList[index]
                                                        ['VehicleLicense'],
                                                    style:
                                                        helveticaText.copyWith(
                                                      color: eerieBlack,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    formList[index]['FormID'],
                                                    style:
                                                        helveticaText.copyWith(
                                                      color: eerieBlack,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${formList[index]['ItemOrigin']} - ${formList[index]['ItemDestination']} ',
                                                    style:
                                                        helveticaText.copyWith(
                                                      color: eerieBlack,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    formList[index]
                                                        ['CreatedDate'],
                                                    style:
                                                        helveticaText.copyWith(
                                                      color: eerieBlack,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    formList[index]['Status'],
                                                    style:
                                                        helveticaText.copyWith(
                                                      color: formList[index]
                                                                  ['Status'] ==
                                                              "VERIFIED"
                                                          ? greenAcent
                                                          : orangeAccent,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // child: ListTile(
                                      //   contentPadding:
                                      //       const EdgeInsets.symmetric(
                                      //           horizontal: 20, vertical: 10),
                                      //   title: RichText(
                                      //     text: TextSpan(
                                      //       text: formList[index]
                                      //           ['VehicleLicense'],
                                      //       style: helveticaText.copyWith(
                                      //         color: eerieBlack,
                                      //         fontWeight: FontWeight.w700,
                                      //         fontSize: 18,
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   subtitle: Column(
                                      //     children: [
                                      //       Text(
                                      //         formList[index]['FormID'],
                                      //         style: helveticaText.copyWith(
                                      //           color: eerieBlack,
                                      //           fontWeight: FontWeight.w300,
                                      //           fontSize: 16,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(
                                      //         height: 10,
                                      //       ),
                                      //       Text(
                                      //         '${formList[index]['ItemOrigin']} - ${formList[index]['ItemDestination']} ',
                                      //         style: helveticaText.copyWith(
                                      //           color: eerieBlack,
                                      //           fontWeight: FontWeight.w300,
                                      //           fontSize: 16,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(
                                      //         height: 10,
                                      //       ),
                                      //       Text(
                                      //         formList[index]['CreatedDate'],
                                      //         style: helveticaText.copyWith(
                                      //           color: eerieBlack,
                                      //           fontWeight: FontWeight.w300,
                                      //           fontSize: 16,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   trailing: const Icon(
                                      //     Icons.chevron_right_sharp,
                                      //     color: eerieBlack,
                                      //   ),
                                      //   onTap: () {
                                      //     // context.goNamed(
                                      //     //   'approval',
                                      //     //   params: {
                                      //     //     "id": formList[index]['FormID']
                                      //     //   },
                                      //     // );
                                      //     // Navigator.push(
                                      //     //   context,
                                      //     //   MaterialPageRoute(
                                      //     //     builder: (context) => ApprovalPage(
                                      //     //       formId: formList[index]['FormID'],
                                      //     //     ),
                                      //     //   ),
                                      //     // );
                                      //     // navKey.currentState!
                                      //     //     .push(MaterialPageRoute(
                                      //     //   builder: (context) => ApprovalPage(
                                      //     //       formId: formList[index]
                                      //     //           ['FormID']),
                                      //     // ));
                                      //     Navigator.of(context)
                                      //         .push(
                                      //       MaterialPageRoute(
                                      //         builder: (context) => ApprovalPage(
                                      //           formId: formList[index]['FormID'],
                                      //         ),
                                      //       ),
                                      //     )
                                      //         .then((value) {
                                      //       print('pop');
                                      //       setState(() {});
                                      //       pullRefresh();
                                      //     });
                                      //   },
                                      // ),
                                    ),
                                  ),
                                );
                              },
                            )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
