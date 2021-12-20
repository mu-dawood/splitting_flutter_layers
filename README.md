# Splitting flutter project layers to multiple packages

> - coming from .net visual studio ide allow us to split our project into multiple libraries so what prevent us to do this in flutter

### Why 

* Test every layer separately
* Export only what you need from library like interfaces only and prevent other libraries to import your implementations
* Make multiple developers work in the project without affect each other
* Make your code more clean

### How can we do this
> its simple .net has libraries  - dart has packages

## Lets start
> we will create an app that pick an image from gallery
> we will have 2 packages and 1 project 
> we will use dependency injection but we will let project decide the way we inject our dependencies


- First create new empty folder with your project name like (my_project)
> run `cd path/to/my_project`
  - this will make our terminal to work in project directory

> run `flutter create --template=package domain`
  - This will contains our logic `repository interfaces` `use cases` `bloc interfaces` `entities` `services interfaces`

> run `flutter create --template=package data`
  - This will contains our repository implementations and entity mappers

> > run `flutter create presentation`
  - This will be our project which contains `ui` `service implementations` `bloc implementations`


  # Domain layer
   + domain layer must not depend on any library it must
   + it must export only interfaces and the injection helpers
   + see exports at `domain/lib/domain.dart`
   + see injector at `domain/lib/src/injector.dart`
   + injector take a `registerFactory` ang `getInstance` where you can use get it or your own injection
   ```dart
      GetIt injector = GetIt.I;
      DomainDependencies.registerUseCases(getInstance: injector, registerFactory: injector.registerFactory);
   ```
   + in `pubspec.yaml` we don't add ay packages
   + note you can also use constructor injection , in this case you don't need `DomainDependencies` at all
     but i prefer to inject my dependencies this way


  # Data layer
   + This layer is for implementing repository interfaces from domain
   + this layer only exports injector nothing else
   + see injector at `data/lib/src/injector.dart`
   + injector take a `registerFactory` ang `getInstance` where you can use get it or your own injection
   ```dart
      GetIt injector = GetIt.I;
      DataDependencies.registerRepositories(registerSingleton: injector.registerLazySingleton);
   ```
   + if you want constructor injection your injector may be like
   ```dart
   class DataDependencies{
     static ImagePickerRepo get imagePickerRepo => ImagePickerRepoImpl();
   }
   ```
   + in `pubspec.yaml` we add domain as this layer depend on it
   ``` yaml
     domain:
       path: ../domain
   ```

  # Presentation layers
   + This layer contains the ui and bloc implementation
   + This layer where we inject our decencies
   + in your main first inject `DomainDependencies` and `DataDependencies`
   ```dart
    GetIt injector = GetIt.I;
    DomainDependencies.registerRepositories(getInstance: injector, registerSingleton: injector.registerFactory);
    DataDependencies.registerRepositories(registerSingleton: injector.registerLazySingleton);
   ```
   + then you need to inject the implementations of  domain services 
   
   ```dart
    injector.registerLazySingleton<IMessenger>(() => MessengerImpl());
    injector.registerLazySingleton<INavigator>(() => NavigatorImpl());
   ```