import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherflut/data/repository/api_repository.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/model/city.dart';
import 'package:weatherflut/ui/cities/add/add_city_bloc.dart';
import 'package:weatherflut/ui/common/header_widget.dart';
import 'package:weatherflut/ui/common/loader_widget.dart';
import 'package:weatherflut/ui/ui_constants.dart';

class AddCityPage extends StatefulWidget {
  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  late AddCityBloc bloc;

  void handleAddTap(City city) async {
    final result = await bloc.addCity(city);
    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    bloc = AddCityBloc(
      storage: context.read<StoreRepository>(),
      apiService: context.read<ApiRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderWidget(
                  title: 'Agregar ciudad',
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextField(
                    onChanged: bloc.onChangedText,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      filled: true,
                      hintText: 'Buscar ciudad',
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                if (bloc.errorMessage != null)
                  Text(
                    bloc.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.cities.length,
                    itemBuilder: (context, index) {
                      final city = bloc.cities[index];
                      return ListTile(
                        title: Text(
                          city.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            handleAddTap(city);
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (bloc.loading)
                  Center(
                    child: LoaderWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
