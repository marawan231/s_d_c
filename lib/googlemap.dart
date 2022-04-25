import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class GlobalSreen extends StatefulWidget {


  @override
  _MapSreenState createState() => _MapSreenState();
}

class _MapSreenState extends State<GlobalSreen> {



  static const _initalcameraposition =CameraPosition(
      target:LatLng(30.033333, 31.233334) ,
      zoom: 11.0);

    GoogleMapController _googleMapController ;

    TextEditingController _from =TextEditingController();
    TextEditingController _to =TextEditingController();

  Marker _Origin;
  Marker _destination;
  Polyline _polyline;
  //Directions _info;
 // Directions ? _info;

  @override
  void dispose() {
    _googleMapController.dispose();

    super.dispose();
  }





  void _addmarker (LatLng pos) async
  {
    if(_Origin== null ||  (_Origin!= null&&_destination!=null))
    {
      setState(() {
        _Origin=Marker(
          markerId: const MarkerId("Origin"),
          infoWindow: const InfoWindow(title: "Origin"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,

        );

_from.text=(_Origin.position.latitude).toString()+" && "+(_Origin.position.longitude).toString();
_to.clear();

        _destination=   null ;
        _polyline=null;
//_info=null;
      });
    }
    else
    {

      setState(() {

        _destination=Marker(
          markerId: const MarkerId("destination"),
          infoWindow: const InfoWindow(title: "destination"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,

        );
        _to.text=(_destination.position.latitude).toString()+" && "+(_destination.position.longitude).toString();
        //polyline da elly hsavoh f el firebase
        _polyline =Polyline(
               polylineId: const PolylineId('Path'),
              color: Colors.blueGrey,
             width: 2,
            points:[
              LatLng(_Origin.position.latitude, _Origin.position.longitude),
              LatLng(_destination.position.latitude, _destination.position.longitude)

            ],
            );


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Order Will Arrives in 45 minnutes "),backgroundColor: Colors.blueGrey,));




      });

      //  final directions =await DirectionsRepository().getDirections(origin: _Origin!.position, destination:pos);
       //setState(()=>_info=directions);


    }


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: false,
        title: const Text("Select Locations"),

        actions: [
          if(_Origin!=null)
            TextButton(onPressed: ()=>_googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _Origin.position,zoom: 14.5,tilt: 50.0)))
              ,
              style: TextButton.styleFrom(primary: Colors.black87,
                  textStyle: TextStyle(fontWeight: FontWeight.w600))

              ,child:const Text("ORIGIN") ,),

          if(_destination!=null)
            TextButton(onPressed: ()=>_googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _destination.position,zoom: 14.5,tilt: 50.0)))
              ,
              style: TextButton.styleFrom(primary: Colors.black87,
                  textStyle: TextStyle(fontWeight: FontWeight.w600))

              ,child:const Text("DEST") ,),


        ],

      ),
      body: Stack(
alignment: Alignment.topCenter,
          children:[

                Material(
                  elevation: 1,
                  child: Container(
height: MediaQuery.of(context).size.height/5,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [

SizedBox(height: 3,),
                         Padding(
                           padding: const EdgeInsets.only(left: 7,right: 7),
                           child: Container(

                             width: MediaQuery.of(context).size.width,
                             child: TextField(
controller: _from,
keyboardType: TextInputType.none,
                               decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                     borderSide: BorderSide.none,
                                   ),
                                   filled: true,
                                   fillColor: Colors.green[50],
                                   hintText: "From Where..",
                                   prefixIcon: Icon(Icons.location_on_outlined,color: Colors.grey[800],)
                               ),
                             ),
                           ),
                         ),
          SizedBox(height: 3,),
          Padding(
            padding: const EdgeInsets.only(left: 7,right: 7),
            child: Container(
              width:MediaQuery.of(context).size.width,
              child: TextField(
controller: _to,
                               keyboardType: TextInputType.none,
                               decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                     borderSide: BorderSide.none,
                                   ),
                                   filled: true,
                                   fillColor: Colors.green[50],
                                   hintText: "To...",
                                   prefixIcon: Icon(Icons.location_on_outlined,color: Colors.grey[800],)
                               ),
                             ),
            ),
          ),



                     ],
               ),
                  ),
                ),
            Container(
              decoration: BoxDecoration(
borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5+2),
              child: GoogleMap(

                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,

                initialCameraPosition: _initalcameraposition,
                onMapCreated: (controller)=>_googleMapController=controller,
                //List of polyline elly h3mlha save in firebase
                polylines: {
                  if(_polyline!=null) _polyline
                },
                markers: {

                  if(_Origin!=null) _Origin,
                  if(_destination!=null)_destination,

                },

                onTap: _addmarker,
                // polylines: {

                // if(_info !=null)
                //   Polyline(
                //   polylineId: const PolylineId('overview_polyline'),
                //  color: Colors.red,
                // width: 5,
                //points: _info!.polylinepoints.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                //),


                //},

              ),
            ),

            // if(_info!= null)
            //Positioned(top: 20.0,

            //child: Container(
            //padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
            //decoration: BoxDecoration(

            // color: Colors.yellowAccent,
            // borderRadius: BorderRadius.circular(20.0),
            //boxShadow: const
            // [
            // BoxShadow(color: Colors.black26,
            //offset: Offset(0,2),
            //blurRadius: 6.0,
            //)

            //   ]
            //   ),
            //   child: Text('${_info!.totaldistance},${_info!.totalDuration}',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18.0),),


            //     ),
            // ),






          ]
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,

        backgroundColor: Colors.teal,

        onPressed: () {


          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initalcameraposition));

          //_googleMapController.animateCamera(
          // _info !=null ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0):CameraUpdate.newCameraPosition(_initalcameraposition),
          //)

        }
        ,
        child: const Icon(Icons.center_focus_strong),

      ),


    );


  }



}
