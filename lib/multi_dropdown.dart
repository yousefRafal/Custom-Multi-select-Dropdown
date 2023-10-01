import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test_gradle/bloc/select_bloc.dart';

class MultiSelectSearch extends StatefulWidget {
  @override
  _MultiSelectSearchState createState() => _MultiSelectSearchState();
}

class _MultiSelectSearchState extends State<MultiSelectSearch> {
  List<String> selectedOptions = [];

  // List<String> options = [
  //   'Yemen',
  //   'Yousef',
  //   'KSA',
  //   'Oman',
  //   'YAH',
  //   'Option 6',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Select Search'),
      ),
      body: BlocBuilder<SelectBloc, SelectState>(builder: (context, state) {
        // TODO: implement listener
        if (state is SelectLoadingState) {
          return CircularProgressIndicator();
        } else if (state is LoadedDataState)
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    // Simulate an API call to fetch suggestions
                    await Future.delayed(const Duration(milliseconds: 500));
                    return state.selectedOptions.where((option) =>
                        option.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    BlocProvider.of<SelectBloc>(context)
                        .add(AddSelectEvent(suggestion));
                    // setState(() {
                    //   selectedOptions.add(suggestion);
                    // });
                  },
                ),
                const SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  children: state.options!.map((option) {
                    return Chip(
                      label: Text(option),
                      deleteIcon: const Icon(Icons.cancel),
                      onDeleted: () {
                        state.options!.remove(option);
                        BlocProvider.of<SelectBloc>(context)
                            .add(RemoveSelectEvent(option));
                        // setState(() {
                        //   selectedOptions.remove(option);
                        // });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MultiSelectSearch(),
  ));
}
