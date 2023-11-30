# Movies App for iOS

## Overview

This iOS app allows users to browse and view details about movies. It follows the principles of Clean Architecture, separating concerns into different layers. The presentation layer adheres to the MVVM (Model-View-ViewModel) design pattern. The Kingfisher library is used for efficient and asynchronous loading of images.

## Features

- Browse a list of movies.
- View detailed information about each movie.
- Dynamic loading of movie posters using Kingfisher.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/khaledmitkees/movies-app-ios.git
   cd movies-app-ios

2. **Install dependencies using CocoaPods:**

   ```bash
   pod install

3. **Open the MoviesApp.xcworkspace file:**

   ```bash
   open MoviesApp.xcworkspace

# Project Structure

The app follows the principles of Clean Architecture:

- **Presentation Layer (MVVM):** Contains UI components, including view controllers, views, and view models.
- **Domain Layer:** Defines entities, use cases, and business logic.
- **Data Layer:** Manages the flow of data between the app and external sources.

![image](https://github.com/khaledmitkees/MoviesApp/assets/42773250/c2d7c067-9532-4021-bab5-c17a5a706f99)

## Network Layer

The app uses a network layer to communicate with external APIs, including:

- **API Services:** Classes responsible for making network requests.
- **Repositories:** Implementations of repository interfaces, fetching data from APIs.
- **Mappers:** Classes responsible for mapping API responses to domain models.

## Dependencies

The app relies on the following third-party library:

- **Kingfisher:** A powerful, pure-Swift library for downloading and caching images from the web.

## Contributing

Feel free to contribute to the development of this app by opening issues or submitting pull requests.





   


