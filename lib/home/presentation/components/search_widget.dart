import 'package:advanced_search/advanced_search.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {

  List<String> searchableList = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Flexible(
        child: Row(
          children: [
            Container(
              color:  Color(0x0035a9a3),
              width: width * .80,
              height: 200,
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Card(
                elevation: 15,
                child: AdvancedSearch(
                  searchItems: searchableList,
                  maxElementsToDisplay: 10,
                  singleItemHeight: 50,
                  minLettersForSearch: 0,
                  selectedTextColor: const Color(0xFF3363D9),
                  fontSize: 14,
                  borderRadius: 10.0,
                  hintText: AppStrings.search,
                  cursorColor: Colors.white,
                  autoCorrect: false,
                  focusedBorderColor: Colors.blue,
                  searchResultsBgColor: const Color(0x00fafafa),
                  disabledBorderColor: Colors.cyan,
                  enabledBorderColor: const Color(0x0035a9a3),
                  enabled: true,
                  caseSensitive: true,
                  inputTextFieldBgColor: Colors.white54,
                  clearSearchEnabled: true,
                  itemsShownAtStart: 10,
                  searchMode: SearchMode.CONTAINS,
                  showListOfResults: true,
                  unSelectedTextColor: Colors.white,
                  verticalPadding: 15,
                  horizontalPadding: 20,
                  hideHintOnTextInputFocus: true,
                  hintTextColor: Colors.grey,
                  searchItemsWidget: searchWidget,
                  onItemTap: (index, value) {
                    print("selected item Index is $index");



                  },
                  onSearchClear: () {
                    print("Cleared Search");
                  },
                  onSubmitted: (value, value2) {
                    print("Submitted: " + value);
                  },
                  onEditingProgress: (value, value2) {
                    print("TextEdited: " + value);
                    print("LENGTH: " + value2.length.toString());
                    print('/////////////////////////////////////////////////////////////');
                    print(searchableList.length);
                  },
                ),
              ),
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff04914F),
                                    Color(0xff1D71B8),
                                  ])
                ),
                width: width * .1,
                height: height * .05,
                child: const Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget(String text) {
    return ListTile(
      title:  Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
