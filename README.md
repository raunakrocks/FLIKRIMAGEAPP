# FLIKRIMAGEAPP

An app using collection view to display images in 3 columns. 

MVVM pattern is used to implement it and protocol injection to easily write unit tests.

The project has the following main components:

1. ImageStorageService -> Responsible for saving and loading images from disk(tmp folder on the users phone).

2. ImageAPI -> API class responsible for fetching the list of photo model data and fetching the a image for a particular image url.

3. ImageService -> It's the class responsible interacting with ImageStorageService and ImageAPI. Before fetching a image from APIService, it checks with the ImageStorage service to check if the image is already present. If not, then it fetches the image from newwork API using ImageAPI and stores in disk using ImageStorageService for future.

4. ImageModel -> Model class that stores data of image like farm, server etc. 

5. FlikrHomeViewModel -> It's the viewModel class for the ViewController. It talks with the Imageservice to fetch image models and image for a url and updates UI present in controller class using completionhandler callbacks.

6. FlikrHomeViewController -> It the ViewController layer responsible for rendering the UI. It interacts with it's ViewModel to fetch data from Service layer.

I've created most of the service classes as a protocol, so that mock objects can be injected in ViewModel for unit testing and reduce coupling between classes.
 
      
     
     
     
