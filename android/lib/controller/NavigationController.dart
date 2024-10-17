import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var isDetailPage = false.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    isDetailPage.value = false;
  }

  void goToDetail() {
    isDetailPage.value = true;
  }
}
