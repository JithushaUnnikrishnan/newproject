import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DAycarefoodview.dart';

class FoodUpdate extends StatefulWidget {
  final String id;

  const FoodUpdate({Key? key, required this.id}) : super(key: key);

  @override
  _FoodUpdateState createState() => _FoodUpdateState();
}

class _FoodUpdateState extends State<FoodUpdate> {
  TextEditingController mondayBreakfastController = TextEditingController();
  TextEditingController mondayLunchController = TextEditingController();
  TextEditingController mondaySnackController = TextEditingController();

  TextEditingController tuesdayBreakfastController = TextEditingController();
  TextEditingController tuesdayLunchController = TextEditingController();
  TextEditingController tuesdaySnackController = TextEditingController();

  TextEditingController wednesdayBreakfastController = TextEditingController();
  TextEditingController wednesdayLunchController = TextEditingController();
  TextEditingController wednesdaySnackController = TextEditingController();

  TextEditingController thursdayBreakfastController = TextEditingController();
  TextEditingController thursdayLunchController = TextEditingController();
  TextEditingController thursdaySnackController = TextEditingController();

  TextEditingController fridayBreakfastController = TextEditingController();
  TextEditingController fridayLunchController = TextEditingController();
  TextEditingController fridaySnackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFoodDetails();
  }

  void _fetchFoodDetails() async {
    try {
      DocumentSnapshot foodSnapshot = await FirebaseFirestore.instance
          .collection("Daycarefoodadd")
          .doc(widget.id)
          .get();

      Map<String, dynamic> data = foodSnapshot.data() as Map<String, dynamic>;

      setState(() {
        mondayBreakfastController.text = data['MBreakFast'] ?? '';
        mondayLunchController.text = data['MLunch'] ?? '';
        mondaySnackController.text = data['MSnack'] ?? '';

        tuesdayBreakfastController.text = data['TuBreakFast'] ?? '';
        tuesdayLunchController.text = data['TuLunch'] ?? '';
        tuesdaySnackController.text = data['TuSnack'] ?? '';

        wednesdayBreakfastController.text = data['WBreakFast'] ?? '';
        wednesdayLunchController.text = data['WLunch'] ?? '';
        wednesdaySnackController.text = data['WSnack'] ?? '';

        thursdayBreakfastController.text = data['ThBreakFast'] ?? '';
        thursdayLunchController.text = data['ThLunch'] ?? '';
        thursdaySnackController.text = data['ThSnack'] ?? '';

        fridayBreakfastController.text = data['FBreakFast'] ?? '';
        fridayLunchController.text = data['FLunch'] ?? '';
        fridaySnackController.text = data['FSnack'] ?? '';
      });
    } catch (e) {
      print("Error fetching food details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 4,
        shadowColor: Colors.grey,
        title: Text('Edit Food Details'),
        backgroundColor: Colors.green.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDayRow('Monday', mondayBreakfastController,
                mondayLunchController, mondaySnackController),
            _buildDayRow('Tuesday', tuesdayBreakfastController,
                tuesdayLunchController, tuesdaySnackController),
            _buildDayRow('Wednesday', wednesdayBreakfastController,
                wednesdayLunchController, wednesdaySnackController),
            _buildDayRow('Thursday', thursdayBreakfastController,
                thursdayLunchController, thursdaySnackController),
            _buildDayRow('Friday', fridayBreakfastController,
                fridayLunchController, fridaySnackController),
            SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,foregroundColor: Colors.white),
              onPressed: () {
                _updateFoodDetails(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(
      String day,
      TextEditingController breakfastController,
      TextEditingController lunchController,
      TextEditingController snackController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextFormField(
          controller: breakfastController,
          decoration: InputDecoration(labelText: 'Breakfast'),
        ),
        TextFormField(
          controller: lunchController,
          decoration: InputDecoration(labelText: 'Lunch'),
        ),
        TextFormField(
          controller: snackController,
          decoration: InputDecoration(labelText: 'Snack'),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _updateFoodDetails(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("Daycarefoodadd")
          .doc(widget.id)
          .update({
        'MBreakFast': mondayBreakfastController.text,
        'MLunch': mondayLunchController.text,
        'MSnack': mondaySnackController.text,

        'TuBreakFast': tuesdayBreakfastController.text,
        'TuLunch': tuesdayLunchController.text,
        'TuSnack': tuesdaySnackController.text,

        'WBreakFast': wednesdayBreakfastController.text,
        'WLunch': wednesdayLunchController.text,
        'WSnack': wednesdaySnackController.text,

        'ThBreakFast': thursdayBreakfastController.text,
        'ThLunch': thursdayLunchController.text,
        'ThSnack': thursdaySnackController.text,

        'FBreakFast': fridayBreakfastController.text,
        'FLunch': fridayLunchController.text,
        'FSnack': fridaySnackController.text,
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DaycareFoodview()));
    } catch (e) {
      print("Error updating food details: $e");
    }
  }
}
