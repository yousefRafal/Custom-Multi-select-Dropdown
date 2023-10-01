import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test_gradle/bloc/select_bloc.dart';

class MultiSelectSearch extends StatelessWidget {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Select Search'),
      ),
      body: BlocBuilder<SelectBloc, SelectState>(builder: (context, state) {
        if (state is SelectLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is LoadedDataState)
          // ignore: curly_braces_in_flow_control_structures
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TypeAheadField(
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
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
        return const Center(
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
