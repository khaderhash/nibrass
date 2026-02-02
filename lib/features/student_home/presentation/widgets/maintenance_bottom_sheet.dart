import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/student_home_controller.dart';

class MaintenanceBottomSheet extends StatelessWidget {
  final StudentHomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Report an Issue", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          // Dropdown for Kind
          const Text("Issue Type"),
          Obx(() => DropdownButton<String>(
            value: controller.selectedMaintenanceType.value,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: "ELECTRICITY", child: Text("Electricity")),
              DropdownMenuItem(value: "PLUMBING", child: Text("Plumbing")),
              DropdownMenuItem(value: "FURNITURE", child: Text("Furniture")),
              DropdownMenuItem(value: "INTERNET", child: Text("Internet")),
              DropdownMenuItem(value: "OTHER", child: Text("Other")),
            ],
            onChanged: (v) => controller.selectedMaintenanceType.value = v!,
          )),

          const SizedBox(height: 10),

          // Description
          TextField(
            controller: controller.maintenanceDescController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Describe the problem...",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.submitMaintenance, // Call API
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Text("Submit Request"),
            ),
          )
        ],
      ),
    );
  }
}