import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/nutritional_plan_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/main/app_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import '../../../model/entitie/category.dart';
import '../../../presenter/category_presenter.dart';
import '../../../presenter/child_presenter.dart';
import '../../../presenter/child_register_presenter.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/grid_item.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class RegisterChildPreferencesPage extends StatefulWidget {
  const RegisterChildPreferencesPage({Key? key}) : super(key: key);

  @override
  State<RegisterChildPreferencesPage> createState() => _RegisterChildPreferencesPageState();
}

class _RegisterChildPreferencesPageState extends State<RegisterChildPreferencesPage> with AutomaticKeepAliveClientMixin{

  late List<Category> _categoriesList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    _categoriesList = Provider.of<CategoryPresenter>(context, listen: false).getCategoriesList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          margin: const EdgeInsets.only(right: 10.0, left: 20.0),
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TITLE
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Image.asset('assets/images/logo.png', scale: 5,),
                )
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Preferencias',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: primaryColor
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Scrollbar(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ListView.builder(
                        itemCount: _categoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = _categoriesList[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${category.name!.toTitleCase()} (${category.ingredients!.length.toString()})',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: primaryColor
                                ),
                              ),
                              Container(
                                height: screenSize.height * 0.275,
                                width: screenSize.width,
                                margin: const EdgeInsets.symmetric(vertical: 17.5, horizontal: 10.0),
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                ),
                                child: Center(
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15.0,
                                      crossAxisSpacing: 15.0,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: category.ingredients!.length,
                                    itemBuilder: (context, index) {
                                      return GridItem(
                                        ingredient: category.ingredients![index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Provider.of<ChildRegisterPresenter>(context).getLoader() ?
                const SizedBox(
                  width: 50,
                  child: LinearProgressIndicator(color: Colors.white,),
                ) :
                Button(
                  press: () {
                    Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(true);
                    Provider.of<ChildPresenter>(context, listen: false).saveRegisteredChildPreferences(context).whenComplete((){
                      Provider.of<NutritionalPlanPresenter>(context, listen: false).createNutritionalPlan(context).then((value){
                        if(value == true) {
                          Provider.of<ChildPresenter>(context, listen: false).updateLocalChildList(context).whenComplete((){
                            Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(false);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => const AppPage(),
                            ));
                          });
                        }
                        else{
                          Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(false);
                        }
                      });

                    });
                  },
                  color: secondaryColor,
                  text: 'CONTINUAR',
                ),
              ),
              const SizedBox(height: 17.5)
            ],
          ),
        ),
      ),
    );

  }
}

