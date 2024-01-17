



import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movilcenter_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:movilcenter_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:movilcenter_app/src/widgets/PlanInventarios/plan_inventario_actualizar_cantidad_widget.dart';
import 'package:movilcenter_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;



class PlanInventarioDetallePage extends StatefulWidget {

  String? idCabecera = "0";
  PlanInventarioDetallePage({this.idCabecera});



  @override
  State<PlanInventarioDetallePage> createState() => _PlanInventarioDetallePageState();
}

class _PlanInventarioDetallePageState extends State<PlanInventarioDetallePage> {


  SPGlobal _prefs = SPGlobal();









  var _planInventarioServices = new PlanInventariosServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String idPedGlobLocal = "0";
  String cantTotalGlob = "0";
  // String usr = "";
  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();
  TextEditingController _filtrarontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  List<PlanInventarioDetalleModel> informeModelList2 = [];
  List<PlanInventarioDetalleModel> informeModelList3 = [];

  // List<PedidosDeliveryDetalleModel> pendientes = [];

  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Dataaaa");

  }

  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("rolId")!;
  }
//19.10
  getData(){
    idPedGlobLocal = "0";
    isLoading = true;
    _planInventarioServices.getPlanInventariosDetallesxId(widget.idCabecera!).then((value) {
      informeModelList2 = value;
      informeModelList3 = [];
      informeModelList3.addAll(informeModelList2);
      Accion = 0;
      setState(() {
        isLoading = false;
        print("lISTA 2 DESDE GET_DATA");
        print(informeModelList2.length);
        print("LISTA 3 DESDE GET_DATA");
        print(informeModelList3.length);


      });
    });
  }
  //DBAdmin().getDBPedidosOffline("nada","nada")



  // DBAdmin().getDBPedidosOffline("nada","nada").then((value) {
  //   informeModelList2 = value;
  //   informeModelList3.addAll(informeModelList2);
  //   Accion = 0;
  //   setState(() {
  //     isLoading = false;
  //   });
  // });
  // }


  // showDetalle(String estimado) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return PedidosDeliveryMostrarEstimaciones(
  //         estimacion: estimado,
  //       );
  //     },
  //   );
  // }



  void filtrarPorPlaca(String query) {
    print("xxxx 1");
    List<PlanInventarioDetalleModel> tempSearchList = [];

    if (query.isNotEmpty) {
      tempSearchList.addAll(informeModelList3);
      List<PlanInventarioDetalleModel> tempDataList = [];
      tempSearchList.forEach((element) {
        if (element.pdProductoNombre!.toLowerCase().contains(query.toLowerCase()) || element.pdProductoCodigoBarras!.toLowerCase().contains(query.toLowerCase())) {
          //pene
          tempDataList.add(element);
        }
      });
      informeModelList2.clear();
      informeModelList2.addAll(tempDataList);
      setState(() {});
    } else {
      print("xxxx 3");
      print(informeModelList3);
      informeModelList2.clear();
      informeModelList2.addAll(informeModelList3);
      setState(() {});
    }
  }
  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
     String qrValue = cameraScanResult!;
      _filtrarontroller.text = qrValue;
     filtrarPorPlaca(qrValue);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos de Inventario"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () async{
          //     DBAdmin().deleteDatabase();
          //    // DBAdmin().deleteAllData();
          //    // print("Pene");
          //   },
          //   icon: Icon(Icons.delete,color: Colors.red),
          // ),
          // IconButton(
          //   onPressed: () async{
          //     DBAdmin().initDatabase();
          //     DBAdmin().getdata(initDate, endDate);
          //    // getData();
          //     setState(() {
          //       getData();
          //     });
          //     //DBAdmin().insertPrueba2();
          //     //DBAdmin().getDataPrueba();
          //     //print(listaClientes);
          //     //DBAdmin().insertarCliente(listaClientes);
          //     //DBAdmin().listarCliente(); EV
          //     // DBAdmin().getdata();
          //
          //   },
          //   icon: Icon(Icons.cloud_download,color: Colors.amber),
          // ),
          // IconButton(
          //   onPressed: () async{
          //    // DBAdmin().getDBPedidosOffline("nada","nada");
          //
          //   getData();  //local xD
          //   },
          //   icon: Icon(Icons.ac_unit,color: Colors.green),
          // ),
          // IconButton(
          //   icon: Icon(Icons.add_circle_outline),
          //   color: Colors.white,
          //   iconSize: 30.0,
          //   onPressed: () {
          //     //Navigator.pushNamed(context, 'general');
          //     Navigator.pushNamed(context, 'pedidosCrear');
          //   },
          // )
        ],
      ),
     // drawer: MenuWidget(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     getData();
      //   }),
      //   tooltip: 'Actualizar',
      //   child: const Icon(Icons.refresh),
      // ),
      body: !isLoading
          ? Column(
        children: <Widget>[
       const SizedBox(
        width: 10,
        height: 10,
      ),

          TextFormField(
            onChanged: (String value) {
              filtrarPorPlaca(value);
            },
            controller: _filtrarontroller,
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "Producto",
              labelText: "Producto",
              hintStyle: TextStyle(color: Colors.black54),
              prefixIcon: Container(
                padding: EdgeInsets.all(10),
                width: 17.0,
                height: 17.0,
                child: SvgPicture.asset(
                  "assets/icons/product_box.svg",
                  color: Colors.black87.withOpacity(0.6),
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon:
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF000000),
                child: IconButton(
                  icon: const Icon(
                    Icons.qr_code_2_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    scanQr();
                    // consultaSunat(_rucController.text);
                  },
                ),
              ),
            ),
            maxLines: 1,
            readOnly: false,
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: informeModelList2.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    // showDetalles(modelList[i].idTipoDocumento,
                    //     modelList[i].plaId);
                  },
                  tileColor: informeModelList2[i].pdProcesadoCierre =="True" ? Colors.lightGreenAccent.shade100 : Colors.yellow.shade50,
                  title:  Text(
                    "${informeModelList2[i].pdProductoNombre}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "${informeModelList2[i].pdProductoNombre}",
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black54),
                  //     ),
                  //     Text(
                  //       "${double.parse(informeModelList2[i].pdCantidadApertura!).toStringAsFixed(2)}",
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black54),
                  //     ),
                  //   ],
                  // ),
                  subtitle:

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${double.parse(informeModelList2[i].pdCantidadApertura!).toStringAsFixed(2)}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,fontSize: 18),
                      ),
                      Text(
                        "${informeModelList2[i].pdCantidadCierre}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green, fontSize: 20),
                      ),
                    ],
                  ),


                  // informeModelList2[i].pdProcesadpCierre == "True" ?
                  // Text("${double.parse(informeModelList2[i].pdCantidadApertura!).toStringAsFixed(2)}",
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.black54),
                  //       )
                  //
                  //
                  //     : Text("SIN PROCESAR"),
                  // leading: Icon(
                  //   Icons.content_paste,
                  //   color: Colors.redAccent,
                  // ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                    informeModelList2[i].pdProcesadoCierre =="True"? Text("") : IconButton(
                        icon: Icon(Icons.production_quantity_limits_rounded,
                            color: Colors.blue),
                        onPressed: () {

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PlanInventarioActualizarCantidadWidget(idPd: informeModelList2[i].id,idPiFk: informeModelList2[i].planInventarioFk, );
                              }).then((value){
                          //  cargarPreferencias();
                            getData();
                            print("Saliendo de Mensajito pipi");
                          });


                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return PlanInventarioActualizarCantidadWidget(idPd: informeModelList2[i].id,idPiFk: informeModelList2[i].planInventarioFk, );
                          //     //  return Container();
                          //   },
                          // );

                       //   globalizar(modelList[i].id.toString());

                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return OfflineImpresionPedidosPagosPage(
                          //       idPago: modelList[i].id.toString(),
                          //     );
                          //   },
                          // ).then((val) {
                          //   //Navigator.pop(context);
                          //   getData();
                          // });



                          // Navigator.pushNamed(context, 'offlineImpPago');
                          //

                        },
                      ),
                    ],
                  ),
                  // trailing: idRol != "1"
                  //     ? null
                  //     : Wrap(
                  //         spacing: 12, // space between two icons
                  //         children: <Widget>[
                  //           IconButton(
                  //             icon: Icon(Icons.remove_circle,
                  //                 color: Colors.blue),
                  //             onPressed: () {
                  //               anularPago(modelList[i].idPag!);
                  //             },
                  //           ),
                  //           IconButton(
                  //             icon: Icon(Icons.print,
                  //                 color: Colors.red),
                  //             onPressed: () {
                  //               anularPago(modelList[i].idPag!);
                  //             },
                  //           ),
                  //         ],
                  //       ),
                );
              },


              // itemBuilder: (BuildContext context, int i) {
              //   return ListTile(
              //     // tileColor: miColor,
              //     onTap: () {
              //       print(informeModelList2[i].id!);  //ide de registro xd
              //     },
              //     title: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "${informeModelList2[i].pdProductoNombre}" ,
              //           // "${informeModelList2[i].piFechaApertura}" +
              //           //     "-" +
              //           //     "${informeModelList2[i].usuarioCreacionDesc}",
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black54),
              //         ),
              //         Text(
              //           // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
              //           informeModelList2[i].pdCantidadApertura!,
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black54),
              //         ),
              //       ],
              //     ),
              //     // subtitle: Text(informeModelList2[i].fecha!),
              //     subtitle: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         // Text(
              //         //   "${(informeModelList2[i].fechaCreacion)}",
              //         //   overflow: TextOverflow.ellipsis,
              //         //   maxLines: 1,
              //         //   style: TextStyle(
              //         //       fontWeight: FontWeight.bold,
              //         //       color: Colors.black54),
              //         // ),
              //         informeModelList2[i].pdProcesadpCierre == "False" ?  Text(
              //           "SIN PROCESAR",
              //           //   "RESTANTES?",
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.red.shade300),
              //         ) : const Text(
              //           "PROCESADO",
              //           //   "RESTANTES?",
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.green),
              //         ),
              //       ],
              //     ),
              //
              //
              //     leading: IconButton(
              //       icon: Icon(Icons.paste, color: Colors.red, size: 30,),
              //       onPressed: () {
              //         // showDetalle(informeModelList2[i].descripcion != null ? informeModelList2[i].descripcion!: "-");
              //         // print(informeModelList2[i].idPedido);
              //       },
              //     ),
              //
              //     trailing: informeModelList2[i].pdProcesadpCierre! ==
              //         "True"
              //         ? Icon(
              //       Icons.check,
              //       color: Colors.green,
              //       size: 50.0,
              //     )
              //         : FutureBuilder(
              //       future: getIdRol(),
              //       builder:
              //           (BuildContext context, AsyncSnapshot snap) {
              //         // if (snap.hasData) {
              //         //   String idRol = snap.data;
              //           return PopupMenuButton<String>(
              //             icon: Icon(
              //               Icons.more_vert,
              //               color: Colors.redAccent,
              //             ),
              //             itemBuilder: (BuildContext context) {
              //               return [
              //                 PopupMenuItem<String>(
              //                   value: "1",
              //                   child: Text("Actualizar Cantidad"),
              //                   onTap: () {
              //                     Accion = 1;
              //                     // cantTotalGlob = informeModelList2[i].pedtotalGalones.toString();
              //                     // globalizar(
              //                     //     informeModelList2[i].idPedido!);
              //                   },
              //                 ),
              //               ];
              //             },
              //             onSelected: (choice) =>
              //                 choiceAction(Accion, cantTotalGlob, context),
              //             //   onSelected: choiceAction(s)
              //           );
              //       //  }
              //
              //         // return SizedBox(
              //         //   width: 1,
              //         //   height: 1,
              //         // );
              //       },
              //     ),
              //   );
              // },
            ),
          ),

        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }



  showMensajeriaAW(DialogType tipo, String titulo, String desc) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {},
    ).show().then((value) {
      getData();
      setState(() {});
    });
  }
  //
  // globalizar(String id) async {
  //   idPedGlobLocal = id;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("idPed", id);
  // }

  showMessajeAW(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              //Cuando se genera el pedido
              Navigator.pushReplacementNamed(
                context,
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }


  void choiceAction(int choice,String cantTotal, BuildContext context) {
    if (choice == 1) {
      print("a");
      // Navigator.pushNamed(context, 'pedidosDetalleOffline');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OfflinePedidosDetallePage(pendienteTotal: cantTotal),
      //   ),
      // );


    }

  }
  //
  // Future<Null> _selectDateInit(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       locale: Locale('es', 'ES'),
  //       initialDate: DateTime.parse(initDate),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2030));
  //
  //   if (picked != null)
  //     setState(() {
  //       initDate = picked.toString().substring(0, 10);
  //       //_listInforme(context, informe);
  //       getData();
  //     });
  // }
  //
  // Future<Null> _selectDateEnd(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       locale: Locale('es', 'ES'),
  //       initialDate: DateTime.parse(endDate),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2030));
  //
  //   if (picked != null)
  //     setState(() {
  //       endDate = picked.toString().substring(0, 10);
  //       //_listInforme(context, informe);
  //       getData();
  //     });
  // }













}



