import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  final String? disease; // Accept disease parameter
  final String? plantName; // Add plant name

  RecommendationScreen({required this.disease, required this.plantName});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  // Hardcoded recommendations data
  final List<Map<String, dynamic>> recommendations = [
    {
      'disease': 'Healthy',
      'predicted_disease': 'Healthy',
      'inorganic_solution': [],
      'organic_solution': []
    },
    {
      'disease': 'Mosaic',
      'predicted_disease': 'Mosaic',
      'inorganic_solution': [
        {'name': 'Mancozeb', 'icon': Icons.local_florist},
        {'name': 'Copper Fungicide', 'icon': Icons.local_florist}
      ],
      'organic_solution': [
        {'name': 'Neem Oil', 'icon': Icons.nature},
        {'name': 'Milk Spray', 'icon': Icons.nature}
      ]
    },
    {
      'disease': 'RedDot',
      'predicted_disease': 'RedDot',
      'inorganic_solution': [
        {'name': 'Copper Sulfate', 'icon': Icons.local_florist},
        {'name': 'Chlorothalonil', 'icon': Icons.local_florist}
      ],
      'organic_solution': [
        {'name': 'Garlic Spray', 'icon': Icons.nature},
        {'name': 'Essential Oils', 'icon': Icons.nature}
      ]
    },
    {
      'disease': 'Rust',
      'predicted_disease': 'Rust',
      'inorganic_solution': [
        {'name': 'Triazole Fungicides', 'icon': Icons.local_florist},
        {'name': 'Mancozeb', 'icon': Icons.local_florist}
      ],
      'organic_solution': [
        {'name': 'Cayenne Pepper', 'icon': Icons.nature},
        {'name': 'Horticultural Oil', 'icon': Icons.nature}
      ]
    },
    {
      'disease': 'Yellow',
      'predicted_disease': 'Yellow',
      'inorganic_solution': [
        {'name': 'Fungicide XYZ', 'icon': Icons.local_florist},
        {'name': 'Fungicide ABC', 'icon': Icons.local_florist},
        {'name': 'Copper Sulfate', 'icon': Icons.local_florist},
        {'name': 'Zinc Sulfate', 'icon': Icons.local_florist}
      ],
      'organic_solution': [
        {'name': 'Neem Oil', 'icon': Icons.nature},
        {'name': 'Garlic Spray', 'icon': Icons.nature},
        {'name': 'Baking Soda', 'icon': Icons.nature},
        {'name': 'Essential Oils', 'icon': Icons.nature}
      ]
    }
  ];

  // Fetch current recommendation based on disease passed
  Map<String, dynamic> getCurrentRecommendation() {
    return recommendations.firstWhere(
      (rec) => rec['disease'] == widget.disease,
      orElse: () => {}, // Return an empty map if no match is found
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentRecommendation = getCurrentRecommendation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Recommendations'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentRecommendation.isNotEmpty
            ? ListView(
                children: [
                  SizedBox(height: 10),

                  // Plant Name Label Section
                  Text(
                    'Plant Name:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[800]!, width: 2),
                    ),
                    child: Text(
                      widget.plantName ?? 'Unknown Plant',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Predicted Disease Section
                  Text(
                    'Predicted Disease:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[800]!, width: 2),
                    ),
                    child: Text(
                      currentRecommendation['predicted_disease'] ??
                          'Unknown Disease',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Recommendations Label
                  Text(
                    'Recommendations:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Two Boxes for Solutions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildSolutionBox(
                          'Organic Solutions',
                          currentRecommendation['organic_solution'] ?? [],
                          Colors.green,
                        ),
                      ),
                      SizedBox(width: 16), // Add spacing between boxes
                      Expanded(
                        child: _buildSolutionBox(
                          'Inorganic Solutions',
                          currentRecommendation['inorganic_solution'] ?? [],
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Text(
                  'No recommendations available for ${widget.disease}',
                  style: TextStyle(fontSize: 22),
                ),
              ),
      ),
    );
  }

  Widget _buildSolutionBox(String title, List solutions, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Tapped on $title")));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            ...solutions.map<Widget>((solution) {
              return ListTile(
                leading: Icon(solution['icon'], color: color),
                title: Text(solution['name']),
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                horizontalTitleGap: 8,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
