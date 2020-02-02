import 'package:flutter/material.dart';
import 'package:nutrition/models/meal_plan_model.dart';
import 'package:nutrition/screens/meals_screen.dart';
import 'package:nutrition/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _diets = [
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30',
  ];

  double _targetCalories = 2200;
  String _diet = 'None';

  void _searchMealPlan() async {
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      targetCalories: _targetCalories.toInt(),
      diet: _diet,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealsScreen(mealPlan: mealPlan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/27/87/4c/27874cdabda0d2866ea786ab41fca258.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(30.0),
            height: 400.0,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Daily Meal Planner',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 25.0),
                    children: [
                      TextSpan(
                          text: _targetCalories.truncate().toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: 'cal',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Colors.lightBlue[100],
                    trackHeight: 6.0,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: 4400,
                    value: _targetCalories,
                    onChanged: (value) => setState(() {
                      _targetCalories = value.round().toDouble();
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButtonFormField(
                    items: _diets.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Diet',
                      labelStyle: TextStyle(fontSize: 18.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _diet = value;
                      });
                    },
                    value: _diet,
                  ),
                ),
                SizedBox(height: 30.0),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 8.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: _searchMealPlan,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
