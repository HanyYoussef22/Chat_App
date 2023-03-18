import 'package:chata_pp/Modules/add_Rooms/add_rome_navigetor.dart';
import 'package:chata_pp/Modules/add_Rooms/add_room_view_model.dart';
import 'package:chata_pp/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../reuseable.dart';
import 'package:chata_pp/models/Catagory.dart';

class AddRoomScreen extends StatefulWidget {
  static const String roudeName = 'add';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigetor {
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  var RomeNameController = TextEditingController();
  var RomeCatogryController = TextEditingController();
  var RomeDescriptionController = TextEditingController();
  var category = Category.getCategory();
  late Category selectedItem;

  @override
  void initState() {
    super.initState();
    viewModel.navigetor = this;
    selectedItem = category[0];
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('assets/backgroundScreen.png', fit: BoxFit.fill),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Chat App'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Center(
                  child: Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: mediaQuery.width * 0.85,
                      height: mediaQuery.height * 0.75,
                      child: SingleChildScrollView(
                        child: Form(
                          key: Formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Create New Room',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset('assets/Image_group.png'),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: RomeNameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      hintText: 'Rome Name'),
                                  validator: (text) {
                                    if (text!.isEmpty || text.trim().isEmpty) {
                                      return 'Pleas Enter Your Rome Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    DropdownButton<Category>(
                                        value: selectedItem,
                                        // hint: Text('Category'),
                                        items: category
                                            .map((e) =>
                                                DropdownMenuItem<Category>(
                                                    value: e,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Image.asset(e.image),
                                                        Text(e.name)
                                                      ],
                                                    )))
                                            .toList(),
                                        onChanged: (category) {
                                          if (category == null) {
                                            return;
                                          } else {
                                            selectedItem = category;
                                          }
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: RomeDescriptionController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      hintText: ' Rome description'),
                                  validator: (text) {
                                    if (text!.isEmpty || text.trim().isEmpty) {
                                      return 'Pleas Enter Your Rome Catogry';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultButton(
                                    text: 'Add',
                                    onPressed: () {
                                      AddRome();
                                    },
                                    radius: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void AddRome() {
    if (Formkey.currentState!.validate()) {
      viewModel.AddRome(
          titel: RomeNameController.text,
          catId: selectedItem.id,
          desc: RomeDescriptionController.text);
    }
  }

  @override
  void addSuccesRoom() {
    showMassage('Room Creat Sucssefull', actionName: 'Ok', voidCallback: () {
      hidMassage();
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
}
