# My Flutter App

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Firebase Setup](#firebase-setup)
- [Running the App](#running-the-app)
- [UI Screenshots](#ui-screenshots)
- [bug created within the firebase configuration and Solution](#common-issue-and-solution)
- [Environment Details](#environment-details)

## Introduction

This is a flutter app for an assignement given 

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Flutter SDK.
- You have installed Dart SDK.
- You have a Firebase project set up.

## Getting Started

Follow these steps to get started with the project:

1. Clone the repository:

```sh
git clone https://github.com/Naluswa256/myapp.git

```
2. Navigate to the project directory:
```sh
cd myapp
```
3. Install dependencies:

```sh
flutter pub get
```
4. Run the app:

```sh
flutter run
```


![Home Screen](screenshots/home_screen.png)
![Login Screen](screenshots/login.png)
![Signup Screen](screenshots/signup.png)
![Word Game Screen](screenshots/word_game.png)


## Error created within the code 


![Firebase Configuration error](screenshots/error.png)


solution to the error create is if you dont intialize firebase within the main.dart file 

![Solution or Fix to the Error](screenshots/FIX.png)


## Enviroments 
Flutter 3.22.2
Dart 3.4.3