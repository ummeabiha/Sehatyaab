

<p align="center">
  <img src="assets/images/sehatyaab-logo.png" alt="Sehatyaab Logo" width="200">
</p>

<h3 align="center">
 <b>Bridging the Gap in Medical Facilities</b> 
</h3>

<br/>

Sehatyaab is an app that connects people in remote or underserved areas with healthcare providers through telemedicine. This could help improve access to healthcare services, especially in areas with limited medical facilities such as villages.

## Features

- **Appointment Scheduling**: Patients can easily schedule appointments with doctors based on their availability.
  
- **Chat Between Doctors and Patients**: Seamless communication between doctors and patients for consultations and follow-ups.
  
- **Login and Sign Up for Patients and Doctors**: Secure authentication for both patients and doctors to access the app's features.
  
- **Payment Feature**: Enable secure transactions for doctor fees to ensure seamless payment processing.

## Folder Structure

### Folders By Type/Domain: The project files are organized based on their functionality or type.
- **Screens:** DoctorPanel and PatientPanel screens are in their respective folders under 'screens'.
- **Services:** CRUD operations and API interactions are handled in 'firestore_service.dart' under 'services'.
- **Models:** Data models like 'patient.dart' are in the 'models' folder.
- **Widgets:** Panel-specific widgets are in their folders under 'widgets'.
- **Theme:** Styling and theme configurations are in 'app_theme.dart' under 'theme'.
- **Routes:** Navigation routes are managed in 'app_routes.dart' under 'routes'.

      lib/
        main.dart
      
        services/
          FirestoreService.dart
      
        models/
          Patient.dart
      
        screens/
          DoctorProfile/
            DoctorForm.dart
          PatientProfile/
            PatientForm.dart
          HomeScreen.dart
            
      
        widgets/
            CustomDropDown.dart
            TextField.dart
      
        theme/
          AppTheme.dart
      
        routes/
          AppRoutes.dart


## Guidelines:

- Use a single FirestoreService class located in services/firestore_service.dart for performing Firestore CRUD operations.
- Follow CamelCase for file names (e.g., FirestoreService.dart).
- Use camel casing for defining class names (e.g., FirestoreService).
- Use camel casing for defining folder names (e.g., DoctorProfile).
- Utilize themes defined in AppTheme.dart for consistent styling across the app.
- Name arrays using camel case with the prefix "arr_" (e.g., arrPatientList).

## Getting Started with Flutter in Android Studio

### Step 1: Install Required Software

1. **Install Android Studio**: Download and install Android Studio from the official website: [Android Studio](https://developer.android.com/studio).

2. **Install Flutter SDK**: Follow the instructions provided on the official Flutter website to download and install the Flutter SDK: [Flutter Install](https://flutter.dev/docs/get-started/install).

### Step 2: Set Up Android Studio for Flutter Development

1. **Install Flutter and Dart plugins**: Open Android Studio, go to `File` -> `Settings` -> `Plugins`, and search for "Flutter" and "Dart". Install both plugins.

2. **Set Flutter SDK Path**: In Android Studio, go to `File` -> `Settings` -> `Languages & Frameworks` -> `Flutter`. Set the Flutter SDK path to the directory where you installed Flutter.

### Step 3: Create a New Flutter Project

1. **Create New Project**: Click on `File` -> `New` -> `New Flutter Project`. Select `Flutter Application` and click `Next`.

2. **Configure New Project**: Enter your project name, project location, and other details. Click `Next`.

3. **Select Flutter SDK Path**: Verify the Flutter SDK path and select the Flutter SDK version. Click `Finish`.

### Step 4: Explore Project Structure

1. **Understand Project Structure**: After creating the project, you'll see various folders and files in the project directory. Key folders include:
   - `android`: Contains Android-specific code and configuration files.
   - `ios`: Contains iOS-specific code and configuration files.
   - `lib`: Contains Dart code for your Flutter application.
   - `test`: Contains test code for your Flutter application.

### Step 5: Run Your Flutter App

1. **Run on Emulator/Device**: Connect an Android device or start an Android emulator. Then, click on the green play button (Run) in Android Studio to run your Flutter app.

2. **Run from Command Line**: Alternatively, you can run your app from the command line using `flutter run` command from the root of your project directory.

### Step 6: Start Developing

1. **Edit Dart Code**: Open `lib/main.dart` and start editing Dart code to modify your app's behavior and UI.

2. **Hot Reload**: Flutter's hot reload feature allows you to quickly see the changes you've made in your app without restarting it. Make changes in your Dart code and press `Ctrl + S` to trigger hot reload.

### Step 7: Learn Flutter Basics

1. **Explore Flutter Documentation**: Refer to the official Flutter documentation and resources to learn more about building Flutter apps: [Flutter Documentation](https://flutter.dev/docs).

2. **Join Flutter Community**: Join the Flutter community on platforms like Stack Overflow, Reddit, and Discord to get help and connect with other developers.

That's it! You're now ready to start building your Flutter app in Android Studio. Happy coding!
