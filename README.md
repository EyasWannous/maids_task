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

* User Authentication (using [https://dummyjson.com/auth/login]) 
* Task Management (View, add, edit, delete tasks using [https://dummyjson.com/todos?limit=3&skip=10] endpoints)
* Pagination for fetching large task lists
* Local storage for persistent data

## Additional Information

* **Design Decisions:** I choose **feature-driven directory structure** for simplicity and the way of implementing
  separation of concern and **bloc design pattern (MVVM)** becuase I used bloc as a state management
  and also I choose **repository design pattern** to build my packages that deals with the **(dummyjson.com api)**.

* **Challenges Faced:** Performance Challenge becusae there is **Shader compilation jank** at the start of the app
  and after searching abouth the problem I find this [answer](https://stackoverflow.com/questions/75920582/what-is-sksl-and-shader-jank-compilation-all-about-in-flutter)
  on **Stack overFlow** and find that the problem was from the **Skia rendering engine** and to solve it I should user **Impeller rendering engine**
  instead of **Skia**
  
* **Additional Features:** Added **Dark theme**, **Animation**, **Stats** pasge for complete and active tasks
  and **BLoC Observer** for insure that the bloc react well and change his state for every action that needs to change the state.

## Getting Started

1. Clone this repository.
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`
4. The Login page will appear to you, you should login with one of users in this [endpoint](https://dummyjson.com/users)
5. After that you will navigate automatically to home page and there will be your tasks.
6. If you want to fetch more you should scroll up to send request of more tasks
7. Your respones of tasks will appear in the first of the page and the old tasks will be in the end.

## Note

I build this app in three days for applying to a Flutter Developer position.

In this repository I change from **(reqres.in api)** to **(dummyjson.com api)**

Lack of **Unit Testing**.

I don't recommend building any app depending on **(reqres.in api)**.
