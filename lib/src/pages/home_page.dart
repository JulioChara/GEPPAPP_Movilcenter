


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:movilcenter_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:movilcenter_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:movilcenter_app/src/widgets/menu_widget.dart';
import 'package:movilcenter_app/utils/sp_global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SPGlobal _prefs = SPGlobal();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static List<PlanInventarioDetalleModel> productos = [];
  //var _offlineServices = new OfflineServices();
  PlanInventariosServices _planInventariosServices = PlanInventariosServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  //
  // void consultarPlanActivo() async {
  //   try {
  //     productos =[];
  //   //  loading = true;
  //     productos = await _planInventariosServices.getKardexInicial();
  //
  //     setState(() {
  //
  //       // productoLista = productos; //test
  //       // cantidadTotal = productoLista.length.toString();
  //       // loading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  mensajeToast(String mensaje, Color colorFondo, Color colorText) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorFondo,
        textColor: colorText,
        fontSize: 16.0);
  }

  showMensajeriaBasic(
      DialogType tipo,
      String titulo,
      String desc,
      ) {
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
      //   btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {},
    ).show().then((val) {
      //getData();
      setState(() {});
    });
  }


  get dashBg => Column(
    children: <Widget>[
      _crearFondo(context)
      // Expanded(
      //   child: Container(color: Colors.deepPurple),
      //   flex: 2,
      // ),
      // Expanded(
      //   child: Container(color: Colors.transparent),
      //   flex: 5,
      // ),
    ],
  );

  get content => Container(
    child: Column(
      children: <Widget>[
        header,
        grid,
       // Lottie.asset("assets/animation/animation_fall.json", height: 500),
        //Lottie.asset("assets/animation/animation_halloween_cat.json", height: 250)
        //fechas,
      ],
    ),
  );

  get header => ListTile(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
    // leading: GestureDetector(
    //   key: _scaffoldKey,
    //   onTap: () {_scaffoldKey.currentState!.openDrawer();}, // Image tapped
    //   child: Icon(Icons.menu_outlined, color: Colors.white, size: 30,),
    // ),
    // leading: IconButton(
    //   key: _scaffoldKey,
    //   icon: Icon(Icons.menu_outlined, color: Colors.white, size: 30,),
    //   onPressed: () => Scaffold.of(context).openDrawer(),
    //
    //     //  _scaffoldKey.currentState!.openDrawer(),
    // ),


    title: Text(
      'MENUS',
     style: TextStyle(
          inherit: true,
          fontSize: 30.0,
          color: Colors.orange,
          shadows: [
            Shadow( // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.white
            ),
            Shadow( // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.white
            ),
            Shadow( // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.white
            ),
            Shadow( // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.white
            ),
          ]
      ),
      // style: TextStyle(color: Colors.white),
    ),
    subtitle: Text(
      'Accesos Rapidos',
      style: TextStyle(
        inherit: true,
        fontSize: 25.0,
        color: Colors.black87,
        shadows: [
          Shadow( // bottomLeft
              offset: Offset(-1.5, -1.5),
              color: Colors.white
          ),
          Shadow( // bottomRight
              offset: Offset(1.5, -1.5),
              color: Colors.white
          ),
          Shadow( // topRight
              offset: Offset(1.5, 1.5),
              color: Colors.white
          ),
          Shadow( // topLeft
              offset: Offset(-1.5, 1.5),
              color: Colors.white
          ),
        ]
    ),
    ),
    trailing: CircleAvatar(
      backgroundImage: NetworkImage(
          "https://www.anmosugoi.com/wp-content/uploads/2022/04/date-a-live-iv-portada-1.jpg"),
    ),
  );

  get grid => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: .90,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'planInventarios');

              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.inventory_outlined,
                          color: Colors.green, size: 80),
                      Text('PLAN DE INVENTARIO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),












            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'productosDetalle');


              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                //color: Colors.black12,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.production_quantity_limits ,
                          color: Colors.amber, size: 80),
                      Text('INF. PRODUCTO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),


            if (_prefs.rolId == "1") InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'productosEditar');
              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                //color: Colors.black12,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.edit ,
                          color: Colors.red, size: 80),
                      Text('EDITAR PRODUCTO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ) else (
                Text("")
            ),



            // InkWell(
            //   onTap: () {
            //     Navigator.pushReplacementNamed(
            //               context, 'scanQR');
            //     // consultarPlanActivo();
            //     // print("Entrada");
            //     // print(productos.length);
            //     // print("Salida");
            //     // if(productos.isNotEmpty){
            //     //   mensajeToast("OK", Colors.cyan, Colors.white);
            //     //   Navigator.pushReplacementNamed(
            //     //       context, 'scanQR');
            //     // }else {
            //     //   mensajeToast("No existe plan de inventarios Activo", Colors.redAccent, Colors.white);
            //     // }
            //
            //   },
            //   child: Card(
            //     elevation: 2,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8)),
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         //children: <Widget>[FlutterLogo(), Text('SUBIR')],
            //         children: const <Widget>[
            //           Icon(Icons.qr_code_scanner,
            //               color: Colors.blueAccent, size: 80),
            //           Text('BUSCAR PRODUCTOS')
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

          ]

        // List.generate(8, (_) {
        //   return Card(
        //     elevation: 2,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8)
        //     ),
        //     child: Center(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[FlutterLogo(), Text('data')],
        //       ),
        //     ),
        //   );
        // }),
      ),
    ),
  );

  //
  // get fechas => Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //   children: <Widget>[
  //     Expanded(
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: Color(0XFF51E2A7),
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: [
  //               BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
  //             ]),
  //         child: CupertinoButton(
  //           padding: EdgeInsets.zero,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Icon(
  //                 Icons.date_range,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(
  //                 width: 7.0,
  //               ),
  //               Text(
  //                 initDate,
  //                 style: TextStyle(color: Colors.white, fontSize: 18),
  //               )
  //             ],
  //           ),
  //           onPressed: () {
  //             _selectDateInit(context);
  //           },
  //         ),
  //       ),
  //     ),
  //     SizedBox(
  //       width: 10.0,
  //     ),
  //     Expanded(
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: Colors.lightBlueAccent,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: [
  //               BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
  //             ]),
  //         child: CupertinoButton(
  //           padding: EdgeInsets.zero,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Icon(
  //                 Icons.date_range,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(
  //                 width: 7.0,
  //               ),
  //               Text(
  //                 endDate,
  //                 style: TextStyle(color: Colors.white, fontSize: 18),
  //               )
  //             ],
  //           ),
  //           onPressed: () {
  //             _selectDateEnd(context);
  //           },
  //         ),
  //       ),
  //     ),
  //   ],
  // );
  //
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
  //       //   getData();
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
  //       //  getData();
  //     });
  // }





  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final primerFondo = Container(
    //   height: size.height * 0.4,
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(colors: <Color>[
    //         Color(0xFFF7F7F7),
    //         Color(0xFFF7F7F7),
    //       ])),
    // );

    final primerFondo = Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              // 'assets/wallpapers/menu_wallpaper.png'),
              'assets/wallpapers/11.jpg'),
          fit: BoxFit.fill,
        ),
        // shape: BoxShape.circle,
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          // color: Color.fromRGBO(255, 255, 255, 0.1)),
          color: Color.fromRGBO(150, 255, 255, 0.2)),
    );

    // return Stack(
    //   children: <Widget>[
    //     primerFondo,
    //    // Lottie.asset("assets/animation/animation_fall.json", height: 800),
    //     Positioned(
    //       top: 90.0,
    //       left: 30.0,
    //       child: circulo,
    //     ),
    //     Positioned(
    //       top: -40.0,
    //       right: -30.0,
    //       child: circulo,
    //     ),
    //     Positioned(
    //       bottom: -50.0,
    //       right: -10.0,
    //       child: circulo,
    //     ),
    //     Positioned(
    //       bottom: 120.0,
    //       right: 20.0,
    //       child: circulo,
    //     ),
    //     Positioned(
    //       bottom: -50.0,
    //       left: -20.0,
    //       child: circulo,
    //     ),
    //     // Row(
    //     //   mainAxisAlignment: MainAxisAlignment.center,
    //     //   children: <Widget>[
    //     //     Container(
    //     //         height: 200.0,
    //     //         padding: EdgeInsets.only(top: 70.0),
    //     //         child: ClipRRect(
    //     //           borderRadius: BorderRadius.circular(8.0),
    //     //           child: Image.asset("assets/logo.png"),
    //     //         ))
    //     //   ],
    //     // )
    //   ],
    // );


    return Stack(
      children: <Widget>[
        primerFondo,
        // Lottie.asset("assets/animation/animation_fall.json", height: 800),
           Positioned(
            // left: -200,
            // top: -200,
             left: 0,
             top: 0,
            height: size.height,
            width: size.width,
            child: Opacity(
              opacity: 0.9,
              child: LottieBuilder.asset(
                "assets/animation/animation_wallpaper_cristmas.json",
             //   reverse: true,
               // options: LottieOptions(enableApplyingOpacityToLayers: true),
                fit: BoxFit.fill,
              ),
            ),
          ),
      ],
    );






  }








}

