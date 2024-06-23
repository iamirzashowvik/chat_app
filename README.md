# Chat App - The ultimate way to connect people

<table>
  <tr>
    <td>
      <img src="assets/logo.png" height=70 align="left"> 
    <p>

      </p>
    </td>

  </tr>
</table>
<table>
  <tr>
     <td>Splash Screen</td>
     <td>Login Screen</td>
     <td>Home Screen</td>
     <td>Details Screen</td>
  </tr>
  <tr>
    <td><img src="/assets/screenshots/Splash.png" width=270 ></td>
    <td><img src="/assets/screenshots/Login.png" width=270 ></td>
    <td><img src="/assets/screenshots/Home.png" width=270 ></td>
    <td><img src="/assets/screenshots/Details.png" width=270 ></td>
  </tr>
 </table>

## Project Environment:

```
Flutter 2.5.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 18116933e7 (4 weeks ago) • 2021-10-15 10:46:35 -0700
Engine • revision d3ea636dc5
Tools • Dart 2.14.4
```

## Code Flow:

Project is following MVC pattern. For managing state I am using Riverpod 1.0.0. All the UI components are inside views folder. Business logic is handled inside controller folder. Model is used to parse data.

```
‣ lib
  ‣ src
    ‣ common_widgets
    ‣ constants
    ‣ features
      ‣ authentication
      ‣ chat
      ‣ settings
    ‣ routing
    ‣ utils
```

## Feature List

```
├── Sign in using Google Sign In
├── Get People List
├── Chat with people
├── Get notifications on chat
└── Logout
```

`P.S - To see on going work, feature list please check issues section and projects section`

To learn more about riverpod:<br>
https://codewithandrea.com/videos/flutter-state-management-riverpod/<br>
To learn more about MVC pattern:<br>
https://medium.flutterdevs.com/design-patterns-in-flutter-part-1-c32a3ddb00e2<br>
To Install flutter:<br>
https://flutter.dev/docs/get-started/install
