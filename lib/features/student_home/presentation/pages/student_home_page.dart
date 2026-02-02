import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/student_home_controller.dart';
import '../widgets/maintenance_bottom_sheet.dart';
import 'explore_page.dart';

class StudentHomePage extends StatelessWidget {
  final StudentHomeController controller = Get.put(StudentHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Dashboard")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.studentData.value!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, ${data.firstName}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.major, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              const Text(
                "My Housing",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (controller.hasRoom)
                _buildRoomCard(data.room!)
              else
                _buildNoRoomCard(),
              const SizedBox(height: 20),
              const Text(
                "My Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...data.services.map(
                (s) => ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(s.name),
                  subtitle: Text(s.status),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => ExplorePage()),
        label: const Text("Explore Campus"),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }

  Widget _buildRoomCard(room) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.home, size: 40, color: Colors.blue),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dorm ${room.dormCode}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Room ${room.roomCode} - Floor ${room.floor}"),
                  ],
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.build),
                label: const Text("Request Maintenance"),
                onPressed: () {
                  Get.bottomSheet(MaintenanceBottomSheet());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoRoomCard() {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.hotel_class_outlined),
        title: Text("No Active Housing"),
        subtitle: Text("Visit available rooms tab to subscribe."),
      ),
    );
  }
}
