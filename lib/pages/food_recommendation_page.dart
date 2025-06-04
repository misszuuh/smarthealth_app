import 'package:flutter/material.dart';

class FoodRecommendationPage extends StatefulWidget {
  const FoodRecommendationPage({super.key});

  @override
  State<FoodRecommendationPage> createState() => _FoodRecommendationPageState();
}

class _FoodRecommendationPageState extends State<FoodRecommendationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _dietTypes = [
    'Vegetarian',
    'Vegan',
    'Keto',
    'Paleo',
    'Mediterranean',
    'No specific diet'
  ];
  final List<String> _allergies = [
    'Peanuts',
    'Dairy',
    'Gluten',
    'Shellfish',
    'Eggs',
    'Soy',
    'None'
  ];

  String? _selectedDietType;
  final List<String> _selectedAllergies = [];
  String? _favoriteFood;
  String? _healthConditions;
  // ignore: unused_field
  String? _foodDislikes;
  String? _recommendations;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() {
        _recommendations = _generateRecommendations();
      });
    }
  }

  String _generateRecommendations() {
    String base = "Based on your preferences:\n\n";
    base += "- Diet: $_selectedDietType\n";
    base += "- Allergies: ${_selectedAllergies.join(', ')}\n";
    base += "- Favorite food: $_favoriteFood\n";
    base += "- Health conditions: $_healthConditions\n\n";
    
    base += "We recommend:\n";
    base += "1. Grilled salmon with quinoa and steamed vegetables\n";
    base += "2. Chicken stir-fry with brown rice\n";
    base += "3. Lentil soup with whole grain bread\n";
    base += "4. Greek yogurt with berries and nuts\n";
    
    if (_selectedDietType == 'Vegetarian' || _selectedDietType == 'Vegan') {
      base += "\nVegetarian options:\n";
      base += "1. Chickpea curry with basmati rice\n";
      base += "2. Tofu and vegetable stir-fry\n";
    }
    
    if (_selectedAllergies.contains('Dairy')) {
      base += "\nDairy-free alternatives:\n";
      base += "- Almond milk instead of regular milk\n";
      base += "- Coconut yogurt instead of regular yogurt\n";
    }
    
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recommendation'),
        backgroundColor: const Color(0xFFE75480),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_recommendations == null) ...[
                const Text(
                  'Please fill out this questionnaire to get personalized food recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                // Diet Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'What is your preferred diet type?',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedDietType,
                  items: _dietTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDietType = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a diet type' : null,
                ),
                const SizedBox(height: 16),
                
                // Allergies Checkboxes
                const Text('Select any food allergies:',
                  style: TextStyle(fontSize: 16)),
                ..._allergies.map((allergy) {
                  return CheckboxListTile(
                    title: Text(allergy),
                    value: _selectedAllergies.contains(allergy),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedAllergies.add(allergy);
                        } else {
                          _selectedAllergies.remove(allergy);
                        }
                      });
                    },
                  );
                }),
                const SizedBox(height: 16),
                
                // Favorite Food
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'What are your favorite foods?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your favorite foods' : null,
                  onSaved: (value) => _favoriteFood = value,
                ),
                const SizedBox(height: 16),
                
                // Health Conditions
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Any health conditions we should consider?',
                    border: OutlineInputBorder(),
                    hintText: 'e.g., diabetes, high blood pressure',
                  ),
                  onSaved: (value) => _healthConditions = value,
                ),
                const SizedBox(height: 16),
                
                // Food Dislikes
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Any foods you dislike or avoid?',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _foodDislikes = value,
                ),
                const SizedBox(height: 24),
                
                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE75480),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Get Recommendations',
                      style: TextStyle(fontSize: 18)),
                  ),
                ),
              ] else ...[
                Text(_recommendations!,
                  style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE75480),
                    ),
                    onPressed: () {
                      setState(() {
                        _recommendations = null;
                      });
                    },
                    child: const Text('Start Over'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}