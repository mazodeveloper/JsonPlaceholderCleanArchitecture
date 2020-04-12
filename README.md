# JsonPlaceholderCleanArchitecture
![evi3](https://user-images.githubusercontent.com/32545306/79078632-41121500-7ccf-11ea-8cfd-77b8690ee0c4.gif)

## How To Run
Install Carthage (in case you don't have it)

go to the root folder and run the following command on your terminal

`carthage bootstrap --platform iOS`

now you're ready to run the project via XCode

## Architecture
the architecture used for this project was `clean architecture`

![Architecture Diagram](https://user-images.githubusercontent.com/32545306/79079424-a61c3980-7cd4-11ea-93a6-8617a8a36fff.jpeg)

### Pros
1. favor dependency injection and pop (Protocol oriented programming)
2. Nothing in an inner circle can know anything at all about something in an outer circle, it give us a great scalability, we can exchange networking libraries and databases without break the business logic 

## Third-party library
The only third-party library used in this project was `Realm`, I could have used Core Data but I choose realm for the following reasons:

1. Show the use of a dependency manager (Carthage in this case)

2. The schema or models creation it's pretty straightforward, you just need to inherit Object, mark the properties as dynamic and the model is done.

3. Realm is the fastest database thanks to its zero-copy design

Cons

The app's volume will grow because Realm is a third-party library.  
