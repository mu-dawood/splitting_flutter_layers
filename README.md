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
> we will have 3 packages and 1 project 
> we will use dependency injection but we will let project decide the way we inject our dependencies


- First create new empty folder with your project name like (my_project)
> run `cd path/to/my_project`
  - this will make our terminal to work in project directory

> run `flutter create --template=package domain`
  - This will contains our logic `repository interfaces` `use cases` `bloc interfaces` `entities` `services interfaces`
  

> run `flutter create --template=package core`
  - This will create the core package that will contain interfaces and their implementations for plugins that will be used `image_picker in our case`
  - This will help us make our library stable for long time as any change in the plugins will only affect our implementations not the exported interfaces
  - You may need to name this package `platform` but there is package with this name and its widely used so let it named core



> run `flutter create --template=package data`
  - This will contains our repository implementations and entity mappers

> > run `flutter create presentation`
  - This will be our project which contains `ui` `service implementations` `bloc implementations`


  # Domain layer
   + domain layer must not depend on any library it must
   + it must export only interfaces and the injection helpers
   [1]: entities folder `contains all entities that may be needed in our app`
   - 