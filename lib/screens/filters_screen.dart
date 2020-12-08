import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_first_project/widgets/main_drawer.dart';


  class FilterScreen extends StatefulWidget {
    static const routeName = '/filters';
    final Function saveFilter;

    final Map<String, bool> currentFilters;
    FilterScreen(this.currentFilters ,this.saveFilter);
    @override
    _FilterScreenState createState() => _FilterScreenState();

  }

  class _FilterScreenState extends State<FilterScreen> {

    var _glutenFree = false;
    var _vegetarain = false;
    var _vegan = false;
    var _lactoseFree = false;

    @override
    initState(){
   _glutenFree = widget.currentFilters['gluten'];
   _lactoseFree = widget.currentFilters['lactose'];
   _vegetarain = widget.currentFilters['vegetarian'];
   _vegan = widget.currentFilters['vegan'];
   super.initState();
    }

    Widget _buildSwitchListTile(String title, String description, var currentValue, Function updateValue)
 {
   return SwitchListTile(title: Text(title),
       value: currentValue,
       subtitle: Text(description),
       onChanged: (newValue) {
         setState(() {
           _glutenFree= newValue;
         });
       }
       );
 }
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarain,
                  'vegan': _vegan,
                };
                widget.saveFilter(selectedFilters);
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body:  Column(children: <Widget>[
          Container(
        padding: EdgeInsets.all(20),
        child: Text('Adjust your meal selection',
          style: Theme.of(context).textTheme.title,
        ),
      ),
          Expanded(child: ListView(
            children: <Widget>[
     _buildSwitchListTile(
       'Gluten-Free',
       'Only Includes gluten-Free meals.',
       _glutenFree,
           (newValue)
        {
           setState(() {
         _glutenFree = newValue;
       },
       );
     },
     ),
              _buildSwitchListTile(
                'Lactose-Free',
                'Only Includes lactose-Free meals.',
                _lactoseFree,
                    (newValue)
                {
                  setState(() {
                    _lactoseFree = newValue;
                  },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only Includes vegetarian meals.',
                _vegetarain,
                    (newValue)
                {
                  setState(() {
                    _vegetarain = newValue;
                  },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only Includes vegan meals.',
                _vegan,
                    (newValue)
                {
                  setState(() {
                    _vegan = newValue;
                  },
                  );
                },
              ),
            ],
          ),
          ),
      ],
      ),
      );
    }
  }


