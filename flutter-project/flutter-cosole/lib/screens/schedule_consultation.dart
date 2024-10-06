// import 'package:flutter/material.dart';

// class ScheduleConsultationScreen extends StatefulWidget {
//   const ScheduleConsultationScreen({Key? key}) : super(key: key);

//   @override
//   _ScheduleConsultationScreenState createState() =>
//       _ScheduleConsultationScreenState();
// }

// class _ScheduleConsultationScreenState extends State<ScheduleConsultationScreen>
//     with SingleTickerProviderStateMixin {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   String? selectedRegion;
//   String diseaseName = '';

//   // Hardcoded dataset for agronomists based on regions
//   final Map<String, List<Agronomist>> agronomistsByRegion = {
//     'Pune': [
//       Agronomist(name: 'Dr. A', mobile: '1234567890'),
//       Agronomist(name: 'Dr. D', mobile: '2345678901'),
//     ],
//     'Mumbai': [
//       Agronomist(name: 'Dr. B', mobile: '0987654321'),
//       Agronomist(name: 'Dr. E', mobile: '3456789012'),
//     ],
//     'Jalgaon': [
//       Agronomist(name: 'Dr. C', mobile: '1122334455'),
//       Agronomist(name: 'Dr. F', mobile: '4567890123'),
//     ],
//   };

//   List<Agronomist> get selectedAgronomists {
//     return agronomistsByRegion[selectedRegion] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Consultation'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),

//             // Title
//             Text(
//               'Select a Date, Time & Provide Details',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green.shade900,
//               ),
//             ),
//             SizedBox(height: 20),

//             // Region Selection Dropdown
//             _buildDropdownField(
//               value: selectedRegion,
//               hint: 'Select Region',
//               items: ['Pune', 'Mumbai', 'Jalgaon'],
//               onChanged: (value) {
//                 setState(() {
//                   selectedRegion = value;
//                 });
//               },
//               icon: Icons.location_on,
//             ),
//             SizedBox(height: 20),

//             // Agronomist List
//             selectedRegion != null && selectedAgronomists.isNotEmpty
//                 ? _buildAgronomistList()
//                 : Center(child: Text('No Agronomists Available')),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownField({
//     required String? value,
//     required String hint,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     required IconData icon,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       hint: Text(hint),
//       items: items
//           .map((region) => DropdownMenuItem(
//                 value: region,
//                 child: Text(region),
//               ))
//           .toList(),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         prefixIcon: Icon(icon, color: Colors.green),
//       ),
//     );
//   }

//   Widget _buildAgronomistList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: selectedAgronomists.length,
//       itemBuilder: (context, index) {
//         return _buildAgronomistCard(selectedAgronomists[index]);
//       },
//     );
//   }

//   Widget _buildAgronomistCard(Agronomist agronomist) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               agronomist.name,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green.shade700,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text('Mobile: ${agronomist.mobile}'), // Fixed typo here
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle consult button click
//                     _showConsultationDialog(agronomist);
//                   },
//                   child: Text('Consult'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.green.shade600,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showScheduleForm(agronomist);
//                   },
//                   child: Text('Schedule'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.blue.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showScheduleForm(Agronomist agronomist) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Schedule Consultation with ${agronomist.name}'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildTextField(
//                     label: 'Disease Name',
//                     icon: Icons.local_hospital,
//                     onChanged: (value) {
//                       setState(() {
//                         diseaseName = value;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   _buildDatePickerField(setState),
//                   SizedBox(height: 10),
//                   _buildTimePickerField(setState),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (diseaseName.isNotEmpty &&
//                         selectedDate != null &&
//                         selectedTime != null) {
//                       // Schedule consultation logic
//                       Navigator.of(context).pop();
//                       _showConfirmationDialog(agronomist);
//                     } else {
//                       _showErrorDialog('Please fill all the fields.');
//                     }
//                   },
//                   child: Text('Schedule'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required IconData icon,
//     required ValueChanged<String> onChanged,
//   }) {
//     return TextField(
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         prefixIcon: Icon(icon, color: Colors.green),
//       ),
//     );
//   }

//   Widget _buildDatePickerField(StateSetter setState) {
//     return TextField(
//       readOnly: true,
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: selectedDate ?? DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2025),
//         );
//         if (pickedDate != null) {
//           setState(() {
//             selectedDate = pickedDate;
//           });
//         }
//       },
//       decoration: InputDecoration(
//         labelText: 'Select Date',
//         border: OutlineInputBorder(),
//         prefixIcon: Icon(Icons.calendar_today, color: Colors.green),
//         hintText: selectedDate != null
//             ? '${selectedDate!.toLocal()}'.split(' ')[0]
//             : 'Pick a Date',
//       ),
//     );
//   }

//   Widget _buildTimePickerField(StateSetter setState) {
//     return TextField(
//       readOnly: true,
//       onTap: () async {
//         TimeOfDay? pickedTime = await showTimePicker(
//           context: context,
//           initialTime: selectedTime ?? TimeOfDay.now(),
//         );
//         if (pickedTime != null) {
//           setState(() {
//             selectedTime = pickedTime;
//           });
//         }
//       },
//       decoration: InputDecoration(
//         labelText: 'Select Time',
//         border: OutlineInputBorder(),
//         prefixIcon: Icon(Icons.access_time, color: Colors.green),
//         hintText: selectedTime != null
//             ? '${selectedTime!.hour}:${selectedTime!.minute}'
//             : 'Pick a Time',
//       ),
//     );
//   }

//   void _showConfirmationDialog(Agronomist agronomist) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Schedule Confirmed'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Disease: $diseaseName'),
//               Text('Date: ${selectedDate?.toLocal()}'),
//               Text('Time: ${selectedTime?.hour}:${selectedTime?.minute}'),
//               Text('Consultation with ${agronomist.name} confirmed.'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showConsultationDialog(Agronomist agronomist) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Consult ${agronomist.name}'),
//           content: Text('Contact: ${agronomist.mobile}'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class Agronomist {
//   final String name;
//   final String mobile;

//   Agronomist({required this.name, required this.mobile});
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleConsultationScreen extends StatefulWidget {
  const ScheduleConsultationScreen({Key? key}) : super(key: key);

  @override
  _ScheduleConsultationScreenState createState() =>
      _ScheduleConsultationScreenState();
}

class _ScheduleConsultationScreenState extends State<ScheduleConsultationScreen>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedRegion;
  String diseaseName = '';

  // This will hold the agronomists fetched from the API based on region
  final Map<String, List<Agronomist>> agronomistsByRegion = {};

  List<Agronomist> get selectedAgronomists {
    return agronomistsByRegion[selectedRegion] ?? [];
  }

  List<Agronomist> agronomists = [];

  Future<void> fetchAgronomists(String address) async {
    final url = Uri.parse(
        'http://192.168.97.193:8081/agronomist/api/v1/getByAddress/$address');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(url);
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<Agronomist> agronomists = (jsonResponse['agronomists'] as List)
            .map((data) => Agronomist.fromJson(data))
            .toList();

        setState(() {
          agronomistsByRegion[address] =
              agronomists; // Update the agronomistsByRegion map
        });
      } else {
        // Handle the error
        print('Failed to fetch agronomists: ${response.statusCode}');
        _showErrorDialog('Failed to load agronomists.');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
      _showErrorDialog('An error occurred while fetching agronomists.');
    }
  }

  // void fetchAgronomists(String address) async {
  //   final String url =
  //       'http://10.0.2.2:8081/agronomist/api/v1/getByAddress/Pune';
  //   final Dio dio;

  //   dio = Dio(BaseOptions(
  //     connectTimeout: Duration(seconds: 50), // 5 seconds
  //     receiveTimeout: Duration(seconds: 30), // Optional: 3 seconds
  //   ));

  //   try {
  //     Response response = await dio.get(url);

  //     if (response.statusCode == 200) {
  //       List<Agronomist> fetchedAgronomists =
  //           (response.data['agronomists'] as List)
  //               .map((data) => Agronomist.fromJson(data))
  //               .toList();

  //       setState(() {
  //         agronomists = fetchedAgronomists;
  //       });
  //     } else {
  //       print('Failed to fetch agronomists: ${response.statusCode}');
  //     }
  //   } on DioError catch (e) {
  //     print('Error: ${e.message}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Consultation'),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Select a Date, Time & Provide Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            SizedBox(height: 20),
            _buildDropdownField(
              value: selectedRegion,
              hint: 'Select Region',
              items: ['Pune', 'Mumbai', 'Jalgaon'],
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  // Fetch agronomists when region is selected
                  if (selectedRegion != null) {
                    fetchAgronomists(selectedRegion!);
                  }
                });
              },
              icon: Icons.location_on,
            ),
            SizedBox(height: 20),
            selectedRegion != null && selectedAgronomists.isNotEmpty
                ? _buildAgronomistList()
                : Center(child: Text('No Agronomists Available')),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items
          .map((region) => DropdownMenuItem(
                value: region,
                child: Text(region),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.green),
      ),
    );
  }

  Widget _buildAgronomistList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: selectedAgronomists.length,
      itemBuilder: (context, index) {
        return _buildAgronomistCard(selectedAgronomists[index]);
      },
    );
  }

  Widget _buildAgronomistCard(Agronomist agronomist) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              agronomist.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text('Mobile: ${agronomist.mobile}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showConsultationDialog(agronomist);
                  },
                  child: Text('Consult'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showScheduleForm(agronomist);
                  },
                  child: Text('Schedule'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConsultationDialog(Agronomist agronomist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Consult with ${agronomist.name}'),
          content: Text('You can discuss your issues with ${agronomist.name}.'),
          actions: [
            TextButton(
              onPressed: () {
                // Handle consultation confirmation logic here (e.g., make API call)
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showScheduleForm(Agronomist agronomist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Schedule Consultation with ${agronomist.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    label: 'Disease Name',
                    icon: Icons.local_hospital,
                    onChanged: (value) {
                      setState(() {
                        diseaseName = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _buildDatePickerField(setState),
                  SizedBox(height: 10),
                  _buildTimePickerField(setState),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (diseaseName.isNotEmpty &&
                        selectedDate != null &&
                        selectedTime != null) {
                      // Schedule consultation logic
                      Navigator.of(context).pop();
                      _showConfirmationDialog(agronomist);
                    } else {
                      _showErrorDialog('Please fill all the fields.');
                    }
                  },
                  child: Text('Schedule'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.green),
      ),
    );
  }

  Widget _buildDatePickerField(StateSetter setState) {
    return TextField(
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      decoration: InputDecoration(
        labelText: 'Select Date',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.green),
        hintText: selectedDate != null
            ? '${selectedDate!.toLocal()}'.split(' ')[0]
            : 'Pick a Date',
      ),
    );
  }

  Widget _buildTimePickerField(StateSetter setState) {
    return TextField(
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            selectedTime = pickedTime;
          });
        }
      },
      decoration: InputDecoration(
        labelText: 'Select Time',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.access_time, color: Colors.green),
        hintText: selectedTime != null
            ? '${selectedTime!.hour}:${selectedTime!.minute}'
            : 'Pick a Time',
      ),
    );
  }

  void _showConfirmationDialog(Agronomist agronomist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Consultation Scheduled'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Disease: $diseaseName'),
              Text('Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
              Text('Time: ${selectedTime!.hour}:${selectedTime!.minute}'),
              Text('With: ${agronomist.name}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class Agronomist {
  final int agronomistId;
  final String name;
  final String mobile;

  Agronomist({
    required this.agronomistId,
    required this.name,
    required this.mobile,
  });

  factory Agronomist.fromJson(Map<String, dynamic> json) {
    return Agronomist(
      agronomistId: json['agronomistId'],
      name: json['agronomistName'],
      mobile: json['mobileNo'],
    );
  }
}
