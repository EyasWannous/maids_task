# Flutter Task Manager App

This Flutter project is a task manager app designed to help users efficiently manage their tasks.
The app incorporates various features and best practices of Flutter development,
including clean code architecture, state management, local storage, and unit testing.

## Overview

This app demonstrates various Flutter development skills, including:

* Building a clean and intuitive UI
* Implementing state management (Bloc)
* Optimizing performance
* Handling local storage (Shared Preferences)

## Features

* User Authentication (using reqres.in api/login || api/register) 
* Task Management (View, add, edit, delete tasks using reqres.in /api/tasks endpoints)
* Pagination for fetching large task lists
* Local storage for persistent data

## Additional Information

* **Design Decisions:** I choose **feature-driven directory structure** for simplicity and the way of implementing
  separation of concern and **bloc design pattern (MVVM)** becuase I used bloc as a state management
  and also I choose **repository design pattern** to build my packages that deals with the **(reqres.in api)**.

* **Challenges Faced:** Almost every challenge I faced in my journey of building the app is from **(reqres.in api)**
  because they have one of the worst api I deal with it.
  for example the registration api don't work if the user is not from specific list of users that they selected
  and they don't tell you that you should try by your hand to know.
  
* **Additional Features:** Added Dark theme, Animation and BLoC Observer for insure that the bloc react well
  and change his state for every action that needs to change the state.

## Getting Started

1. Clone this repository.
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`

## Note

I build this app in three days for applying to a Flutter Developer position.

Lack of **Unit Testing**.

I don't recommend building any app depending on **(reqres.in api)**.
