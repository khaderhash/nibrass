import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/explore_controller.dart';
import '../../data/models/explore_models.dart';

class ExplorePage extends StatelessWidget {
  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Explore Campus"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Services", icon: Icon(Icons.local_activity)),
              Tab(text: "Available Rooms", icon: Icon(Icons.bedroom_parent)),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [
              _buildServicesList(),
              _buildRoomsList(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildServicesList() {
    if (controller.servicesList.isEmpty) {
      return _emptyState("No services available right now.");
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.servicesList.length,
      itemBuilder: (context, index) {
        final service = controller.servicesList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(service.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                    Chip(
                      label: Text("\$${service.price}"),
                      backgroundColor: Colors.blue.shade50,
                      labelStyle: TextStyle(color: Colors.blue.shade900),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${service.openingTime} - ${service.closingTime}", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(service.days, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoomsList() {
    if (controller.roomsList.isEmpty) {
      return _emptyState("No rooms available.");
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.roomsList.length,
      itemBuilder: (context, index) {
        final room = controller.roomsList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(room.dormCode, style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold)),
            ),
            title: Text("Room ${room.roomCode}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text("Floor: ${room.floor}"),
                const SizedBox(height: 4),
                Text("Fees: \$${room.monthlyFee} / month"),
                Text("Electricity: \$${room.electricityFee} (est.)", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
              Get.snackbar("Info", "Visit the administration office to book this room.");
            },
          ),
        );
      },
    );
  }

  Widget _emptyState(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}