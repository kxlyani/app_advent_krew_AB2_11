import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:relieflink/models/crisis_update_card.dart';

// Base Crisis Class
abstract class Crisis {
  final String title;
  final String description;
  final String country;
  final String date;
  final String criticalLevel;

  Crisis({
    required this.title,
    required this.description,
    required this.country,
    required this.date,
    required this.criticalLevel,
  });
}

// Natural Disaster Class
class NaturalDisaster extends Crisis {
  final String disasterType;

  NaturalDisaster({
    required super.title,
    required super.description,
    required this.disasterType,
    required super.country,
    required super.date,
    required super.criticalLevel,
  });

  factory NaturalDisaster.fromJson(Map<String, dynamic> json) {
    return NaturalDisaster(
      title: json['name'] ?? 'No Title',
      description: json['description'] ?? 'No Description Available',
      disasterType: json['type']?[0]['name'] ?? 'Unknown',
      country: json['country']?[0]['name'] ?? 'Unknown Location',
      date: json['date']?['created'] ?? 'Date Unknown',
      criticalLevel: 'High', // Placeholder
    );
  }
}

// Humanitarian Conflict Class
class HumanitarianConflict extends Crisis {
  final String conflictType;

  HumanitarianConflict({
    required super.title,
    required super.description,
    required this.conflictType,
    required super.country,
    required super.date,
    required super.criticalLevel,
  });

  factory HumanitarianConflict.fromJson(Map<String, dynamic> json) {
    return HumanitarianConflict(
      title: json['title'] ?? 'No Title',
      description: json['summary'] ?? 'No Description Available',
      conflictType: json['primary_type'] ?? 'Unknown',
      country: json['country']?[0]['name'] ?? 'Unknown Location',
      date: json['date']?['created'] ?? 'Date Unknown',
      criticalLevel: 'Medium',
    );
  }
}

// Pandemic Class
class Pandemic extends Crisis {
  final String disease;

  Pandemic({
    required super.title,
    required super.description,
    required this.disease,
    required super.country,
    required super.date,
    required super.criticalLevel,
  });

  factory Pandemic.fromJson(Map<String, dynamic> json) {
    return Pandemic(
      title: json['title'] ?? 'No Title',
      description: json['summary'] ?? 'No Description Available',
      disease: json['disease'] ?? 'Unknown Disease',
      country: json['country']?[0]['name'] ?? 'Unknown Location',
      date: json['date']?['created'] ?? 'Date Unknown',
      criticalLevel: 'High',
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Dio _dio = Dio();
  List<Crisis> crises = [];
  bool isLoading = true;
  bool isError = false;
  String selectedCategory = "natural_disaster";

  @override
  void initState() {
    super.initState();
    fetchCrisisData();
  }

  Future<void> fetchCrisisData() async {
    String url;
    if (selectedCategory == "natural_disaster") {
      url = 'https://api.reliefweb.int/v1/disasters?appname=relieflink&limit=5';
    } else if (selectedCategory == "humanitarian_conflict") {
      url = 'https://api.reliefweb.int/v1/reports?appname=relieflink&limit=5';
    } else {
      url = 'https://api.reliefweb.int/v1/reports?appname=relieflink&limit=5&query[disease]=true';
    }

    try {
      final response = await _dio.get(url);
      final List<dynamic> data = response.data['data'];

      setState(() {
        crises = data.map((e) {
          if (selectedCategory == "natural_disaster") {
            return NaturalDisaster.fromJson(e['fields']);
          } else if (selectedCategory == "humanitarian_conflict") {
            return HumanitarianConflict.fromJson(e['fields']);
          } else {
            return Pandemic.fromJson(e['fields']);
          }
        }).toList();
        isLoading = false;
        isError = false;
      });
    } catch (e) {
      print('Error fetching crisis data: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crisis Dashboard')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Urgent Crises',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(child: Text('Interactive Crisis Map')),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                items: const [
                  DropdownMenuItem(value: "natural_disaster", child: Text("Natural Disaster")),
                  DropdownMenuItem(value: "humanitarian_conflict", child: Text("Humanitarian Conflict")),
                  DropdownMenuItem(value: "pandemic", child: Text("Pandemic")),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCategory = newValue;
                      fetchCrisisData();
                    });
                  }
                },
              ),
              if (isLoading) const Center(child: CircularProgressIndicator())
              else if (isError) const Center(child: Text('Failed to load crisis updates.'))
              else Column(
                children: crises.map((crisis) => CrisisUpdateCard(
                  title: crisis.title,
                  description: '${crisis.runtimeType}: ${crisis.description}',
                  category: crisis.runtimeType.toString(),
                  timestamp: crisis.date,
                  criticalLevel: crisis.criticalLevel,
                  onTap: () {},
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
