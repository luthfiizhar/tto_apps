import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/constant/constant.dart';
import 'package:tto_apps/constant/text.dart';
import 'package:tto_apps/pages/lp_approval_page.dart';
import 'package:tto_apps/widgets/layout_page.dart';
import 'package:http/http.dart' as http;
import 'package:tto_apps/widgets/notif_dialog.dart';

class ListExitFormPage extends StatefulWidget {
  ListExitFormPage({
    super.key,
    this.context2,
  });

  BuildContext? context2;

  @override
  State<ListExitFormPage> createState() => _ListExitFormPageState();
}

class _ListExitFormPageState extends State<ListExitFormPage> {
  List formList = [];

  bool isLoading = false;

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
    var url = Uri.https(apiUrlGlobal, 'ExitPassHOBackend/public/api/form/list');
    Map<String, String> requestHeader = {"Content-Type": "application/json"};

    var bodySend = """
    {
      "Status": "APPROVED",
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
                    'Daftar Perizinan Keluar',
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
                                          builder: (context) => ApprovalPage(
                                            formId: formList[index]['FormID'],
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
