import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../chatbot/presentation/pages/chat_page.dart';
import '../../../finance/presentation/pages/finance_page.dart';
import 'student_home_page.dart';
import 'profile_page.dart';

class MainLayoutController extends GetxController {
  var currentIndex = 0.obs;

  final pages = [StudentHomePage(), ChatPage(), FinancePage(), ProfilePage()];

  void changePage(int index) {
    currentIndex.value = index;
  }
}

class MainLayout extends StatelessWidget {
  final MainLayoutController controller = Get.put(MainLayoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Colors.blue.shade800,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: "Chatbot",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money_off),
                label: "finance",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
