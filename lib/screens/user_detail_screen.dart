import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' ;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:practical_task/models/UserProfileModel.dart' hide Location;

import '../bloc/user_detail_bloc/user_detail_bloc.dart';
import '../bloc/user_detail_bloc/user_detail_state.dart';
import '../models/UserListModel.dart';
import '../models/UserProfileModel.dart' as Loca;

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  GoogleMapController? _mapController;
  LatLng? _targetLatLng;

  @override
  void initState() {
    super.initState();
    // _fetchCoordinates();
  }
  Future<void> _fetchCoordinates(Loca.Location? location) async {
    String fullAddress = "${location!.street}, ${location.city}, ${location.state}, ${location.country}";

    try {
      List<Location> locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        setState(() {
          _targetLatLng = LatLng(
            locations.first.latitude,
            locations.first.longitude,
          );
        });
      }
    } catch (e) {
      print("Error fetching coordinates: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<UserDetailBloc, UserDetailState>(
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDetailLoaded) {
            final user = state.user;
            // Future<LatLng?> string= getLatLngFromAddress(user.location);
            _fetchCoordinates(user.location);

            String dobformattedDate="",registerformattedDate="";
            if(user.dateOfBirth!=null) {
              DateTime dobdateTime = DateTime.parse(user.dateOfBirth!);
              dobformattedDate = DateFormat('dd-MM-yyyy').format(dobdateTime);
            }
            if(user.registerDate!=null) {
              DateTime registerdateTime = DateTime.parse(user.registerDate!);
              registerformattedDate =
                  DateFormat('dd-MM-yyyy').format(registerdateTime);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity, margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: NetworkImage(user.picture!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  detailText("Name", "${user.firstName} ${user.lastName}"),
                  detailText("Gender", user.gender!),
                  detailText("Date of birth", dobformattedDate),
                  detailText("Register date", registerformattedDate),
                  detailText("Email", user.email!),
                  detailText("Phone", user.phone!),
                  detailText("Address",
                      "${user.location!.street} ${user.location!.city}, ${user.location!.state}"),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,width: double.infinity,margin: EdgeInsets.only(bottom: 50),
                    child: _targetLatLng == null
                        ? const Center(child: CircularProgressIndicator())
                        : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _targetLatLng!,
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("user_location"),
                          position: _targetLatLng!,
                          infoWindow: InfoWindow(
                            title: user.location!.city,
                            snippet: user.location!.street,
                          ),
                        ),
                      },
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                    ),
                  )
                  /*Image.network(
                    "https://maps.googleapis.com/maps/api/staticmap?center=${user.location!.city}&zoom=12&size=400x200&key=AIzaSyDZF_oNL8olqMqAbgcjl6HU1vj2eEjx1Hw",
                    errorBuilder: (context, error, stackTrace) =>
                     Text("Map unavailable ${error}"),
                  )*/
                ],
              ),
            );
          } else if (state is UserDetailError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        return LatLng(loc.latitude, loc.longitude);
      }
    } catch (e) {
      print("Geocoding error: $e");
    }
    return null;
  }
  Widget detailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title: ",
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
          Expanded(child: Text(value,style: const TextStyle(fontSize: 16,color: Colors.grey))),
        ],
      ),
    );
  }
}
