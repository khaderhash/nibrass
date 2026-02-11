import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/transport_controller.dart';
import '../../data/models/trip_model.dart';

class TransportPage extends StatelessWidget {
  final TransportController controller = Get.put(TransportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bus Schedule")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.tripsList.isEmpty) {
          return const Center(child: Text("No scheduled trips right now."));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tripsList.length,
          itemBuilder: (context, index) {
            return _buildTripCard(controller.tripsList[index]);
          },
        );
      }),
    );
  }

  Widget _buildTripCard(TripModel trip) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.destination,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trip.formattedDate,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    trip.busCode,
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event_seat, color: Colors.grey, size: 20),
                    const SizedBox(width: 4),
                    Text("${trip.availableSeats} seats left"),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Book / Confirm"),
                  onPressed: () => _showBookingOptions(trip),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingOptions(TripModel trip) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Booking Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.card_membership, color: Colors.green),
              title: const Text("I have a Semester Plan"),
              subtitle: const Text("Confirm attendance (Free)"),
              onTap: () {
                Get.back();
                controller.confirmSemesterTrip(trip.id);
              },
            ),

            ListTile(
              leading: const Icon(Icons.attach_money, color: Colors.blue),
              title: const Text("Book One Trip"),
              subtitle: Text("Charge account: \$${trip.price}"),
              onTap: () {
                Get.back();
                controller.bookOneTrip(trip.id);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text("Cancel Booking"),
              subtitle: const Text("Remove my reservation"),
              onTap: () {
                Get.back();
                Get.defaultDialog(
                  title: "Cancel Trip?",
                  middleText: "Are you sure you want to cancel?",
                  textConfirm: "Yes, Cancel",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    Get.back();
                    controller.cancelTrip(trip.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
