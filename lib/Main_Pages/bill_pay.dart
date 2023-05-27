import 'package:flutter/material.dart';
import 'package:uwallet/Dahsboard_Container.dart';
import 'package:uwallet/Main_Pages/pay_bill_confirm.dart';

import '../utils/Shared_preferences.dart';

class PayBillPage extends StatefulWidget {
  @override
  _PayBillPageState createState() => _PayBillPageState();
}

class _PayBillPageState extends State<PayBillPage> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  String? _selectedCountry;
  String? _selectedCity;

  List<String> _countries = ['Pay Bills', 'School/College Fee', 'Utilities Bill'];
  Map<String, List<String>> _cities = {
    'Pay Bills': ['Desco', 'Dhaka Wasa', 'Palli Bidyut', 'Titas Gas', 'City Corporation '],
    'School/College Fee': ['UIU Tution Fee', 'Rajuk College', 'North South University', 'Adamjee Cantonment', 'Milestone College','Scholastica'],
    'Utilities Bill': ['Mime Internet', 'Netflix', 'Carnival Internet', 'Amazon Prime'],
  };

  List<DropdownMenuItem<String>> _buildCountryDropdownItems() {
    return _countries.map((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _buildCityDropdownItems() {
    if (_selectedCountry == null) {
      return [];
    }

    return _cities[_selectedCountry!]!.map((String city) {
      return DropdownMenuItem<String>(
        value: city,
        child: InkWell(
          onTap: () {
            _handleCitySelection(city); // Pass selected city to the method
          },
          child: Text(city),
        ),
      );
    }).toList();
  }

  void _handleCitySelection(String city) {
    setState(() {
      _selectedCity = city;
    });

    print('Clicked: $city');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayBillCofrimPage(billerName: city,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, ),
            onPressed: () {

             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardContainer(),
              ),
            );
             },
          ),
        ),
        title: Text('Pay Bills', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pay your bills right away", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Center(child: Text("Your Current Balance:",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2ECC71)),)),
                SizedBox(height: 15,),
                Center(child: Text("৳ 1500",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
                SizedBox(height: 20,),
                Text("Choose Biller to pay", style: TextStyle(fontSize: 14, ),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 0,
                      hint: Text('Select Category'),
                      value: _selectedCountry,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                          _selectedCity = null;
                        });
                      },
                      items: _buildCountryDropdownItems(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 0,

                      hint: Text('Select Biller'),
                      value: _selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue;
                        });
                      },
                      items: _buildCityDropdownItems(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
