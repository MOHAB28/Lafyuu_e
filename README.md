# **Lafyuu**
I have made this app with flutter using clean architecture and I used Bloc as state management at the presentation layer.

## Brief explanation

An e-commerce app through it you can add products to favourite and every user have a cart that he can add products to it and every user has its own profile and can edit his data at any time. You can see a video [in this link](https://youtu.be/PGp-13gLV9s)

## Screenshots

  Splash screen                 |   Login screen        |  Register screen | Home screen 
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/splash_screen.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/login.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/register.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/home.jpg?raw=true)


  Login validation                 |   Register validation        |  Home No Internet | Profile No Internet 
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/login_with_val.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/register_with_val.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/home_with_no_internet_connection.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/profile_with_no_internet_connection.jpg?raw=true)


  Cart screen                 |   Favourites screen        |  Product details | Profile Screen 
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/cart.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/favourties.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/product_details.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/profie.jpg?raw=true)

  Search screen                 |   Search result screen        |  Update Profile 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/search.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/search_result.jpg?raw=true)|![](https://github.com/MOHAB28/e-commerce_clean_arch_with_bloc/blob/master/screenshots/update_profile.jpg?raw=true)

## Dependencies
```yaml
  dio: ^4.0.6
  connectivity_plus: ^2.3.7
  dartz: ^0.10.1
  get_it: ^7.2.0
  lottie: ^1.3.0
  shared_preferences: ^2.0.15
  another_flushbar: ^1.10.29
  flutter_svg: ^1.1.5
  equatable: ^2.0.5
  carousel_slider: ^4.1.1
  flutter_bloc: ^8.1.1
```

## Directory Structure for project

```
├───core
│   ├───error
│   ├───network
│   ├───resources
│   └───usecase
└───features
    ├───cart
    │   ├───data
    │   │   ├───datasources
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       ├───pages
    │       │   └───cart_page
    │       └───widgets
    ├───favourite
    │   ├───data
    │   │   ├───datasources
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       └───pages
    ├───home
    │   ├───data
    │   │   ├───datasources
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       │   └───bottom_nav_cubit
    │       ├───pages
    │       │   └───layout
    │       │       └───home
    │       └───widgets
    ├───login
    │   ├───data
    │   │   ├───datasources
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       ├───pages
    │       │   ├───login
    │       │   └───splash
    │       └───widgets
    ├───product_details
    │   ├───data
    │   │   ├───datasources
    │   │   └───repositories
    │   ├───domain
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       ├───pages
    │       │   └───product_details
    │       └───widgets
    ├───profile
    │   ├───data
    │   │   ├───datasources
    │   │   └───repositories
    │   ├───domain
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       └───pages
    ├───register
    │   ├───data
    │   │   ├───datasources
    │   │   └───repositories
    │   ├───domain
    │   │   ├───repositories
    │   │   └───usecases
    │   └───presentation
    │       ├───bloc
    │       └───pages
    └───search
        ├───data
        │   ├───datasources
        │   ├───models
        │   └───repositories
        ├───domain
        │   ├───entities
        │   ├───repositories
        │   └───usecases
        └───presentation
            ├───bloc
            ├───pages
            └───widgets
```
