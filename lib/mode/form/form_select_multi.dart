import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class FormSelectMulti extends StatefulWidget {
  const FormSelectMulti({Key? key}) : super(key: key);

  String? get title => null;

  @override
  State<FormSelectMulti> createState() => _FormSelectMultiState();
}

class _FormSelectMultiState extends State<FormSelectMulti> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Bird"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('临时标题'),
      // ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              //################################################################################################
              // Rounded blue MultiSelectDialogField
              //################################################################################################
              MultiSelectDialogField(
                items: _items,
                title: Text("Animals"),
                selectedColor: Colors.blue,
                searchable: true,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Favorite Animals",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  //_selectedAnimals = results;
                },
              ),
              SizedBox(height: 50),
              //################################################################################################
              // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
              // decoration applied. This allows the ChipDisplay to render inside the same Container.
              //################################################################################################
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    // 这里报错type '(List<Animal>) => void' is not a subtype of type '((List<Animal?>) => void)?'是啥原因，要如何修改? 这个是因为onConfirm的参数是List<Animal?>，而你传入的是List<Animal>，所以要修改onConfirm的参数类型为List<Animal>，或者传入List<Animal?>。你可以修改onConfirm的参数类型为List<Animal>，然后传入List<Animal>，这样就不会报错了。
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Favorite Animals2"),
                      title: Text("Animals"),
                      items: _items,
                      onConfirm: (values) {
                        // _selectedAnimals2 = values;
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            _selectedAnimals2.remove(value);
                          });
                        },
                      ),
                    ),
                    _selectedAnimals2 == null || _selectedAnimals2.isEmpty
                        ? Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "None selected",
                          style: TextStyle(color: Colors.black54),
                        ))
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectBottomSheetField with validators
              //################################################################################################
              // MultiSelectBottomSheetField<Animal>(
              //   key: _multiSelectKey,
              //   initialChildSize: 0.7,
              //   maxChildSize: 0.95,
              //   title: Text("Animals"),
              //   buttonText: Text("Favorite Animals"),
              //   items: _items,
              //   searchable: true,
              //   validator: (values) {
              //     if (values == null || values.isEmpty) {
              //       return "Required";
              //     }
              //     List<String> names = values.map((e) => e.name).toList();
              //     if (names.contains("Frog")) {
              //       return "Frogs are weird!";
              //     }
              //     return null;
              //   },
              //   onConfirm: (values) {
              //     setState(() {
              //       _selectedAnimals3 = values;
              //     });
              //     // _multiSelectKey.currentState.validate();
              //   },
              //   chipDisplay: MultiSelectChipDisplay(
              //     onTap: (item) {
              //       setState(() {
              //         _selectedAnimals3.remove(item);
              //       });
              //       // _multiSelectKey.currentState.validate();
              //     },
              //   ),
              // ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectChipField
              //################################################################################################
              // MultiSelectChipField(
              //   items: _items,
              //   initialValue: [_animals[4], _animals[7], _animals[9]],
              //   title: Text("Animals"),
              //   headerColor: Colors.blue.withOpacity(0.5),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blue[300]!),
              //   ),
              //   selectedChipColor: Colors.blue.withOpacity(0.5),
              //   selectedTextStyle: TextStyle(color: Colors.blue[800]),
              //   onTap: (values) {
              //     //_selectedAnimals4 = values;
              //   },
              // ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectDialogField with initial values
              //################################################################################################
              MultiSelectDialogField(
                onConfirm: (val) {
                  _selectedAnimals5 = val;
                },
                searchable: true,
                dialogWidth: MediaQuery.of(context).size.width * 0.7,
                items: _items,
                initialValue:
                _selectedAnimals5, // setting the value of this in initState() to pre-select values.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
