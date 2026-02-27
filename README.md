# Nibrass Hub 🎓

Nibrass Hub is a comprehensive mobile application designed to streamline the daily life of university students. It serves as a central platform for managing campus services, housing, transportation, and financial records.

Built with **Flutter** using a strict **Clean Architecture** approach and **MVVM** pattern to ensure scalability, testability, and maintainability.

## 📱 Features

*   **Secure Authentication:** JWT-based login with auto-refresh mechanism and secure token storage.
*   **Student Dashboard:** View academic profile, major details, and active subscriptions.
*   **Housing Management:**
    *   View assigned dorm room details.
    *   Check available rooms for booking.
    *   **Maintenance System:** Submit maintenance requests (Plumbing, Electricity, etc.) directly for the assigned room.
*   **Smart Transportation:**
    *   View bus schedules and available seats in real-time.
    *   **Booking System:** Book a single trip (pay-per-ride) or confirm attendance via semester subscription.
    *   Cancel bookings with auto-refund logic.
*   **Finance & Wallet:**
    *   Real-time balance tracking (Credit/Debt logic).
    *   Detailed transaction history (Payments, Penalties, Service Fees).
*   **Service Explorer:** Browse and subscribe to campus amenities (Gym, Pool, etc.).

## 🏗️ Architecture & Tech Stack

The project follows **Clean Architecture** principles, separating the codebase into three main layers: **Data**, **Domain**, and **Presentation**.

*   **Framework:** Flutter (Dart).
*   **State Management:** GetX (Reactive programming).
*   **Networking:** Dio with custom **Interceptors** for centralized error handling and token injection.
*   **Local Storage:** Flutter Secure Storage (for sensitive data like Tokens).
*   **Design Pattern:** MVVM (Model-View-ViewModel).

### Folder Structure
