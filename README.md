### Class: CIS 350
### Section: 03
### LakerVent: An Anonymous Venting Application.
### Made by:
___
#### Charlie Greco
#### Francis Corona
#### Ian Stewart
___
## 1 Abstract
Grand Vally State University students do not have a place to express their thoughts anonymously with their peers. LakerVent is a mobile application that empowers GVSU students to communicate without revealing their identity. Share your thoughts openly, categorize posts, and explore topics like academics, relationships, mental health, and more. Connect with peers through likes, comments, and supportive messages.

## 2 Introduction
With the rise in popularity of social media applications in the past decade, people have started to worry about what they post online and how their digital footprint may affect their future. Additionally, cyberbullying has become a significant problem with social media. Due to this, we introduce a new form of social media for anonymous posting so you can openly share your thoughts and opinions without any worries. The application will still have community guidelines that users need to follow, along with a reporting system to ensure a safe environment for everyone. LakerVent will provide a community for GVSU students to openly share their thoughts, easily find interesting posts through the AI topic modeling tagging system, and bring everyone closer together. The user just needs an Android or iOS device to join the LakeVent community.

## 3 Architectural Design
![LakerVent Architecture Diagram](https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/071e8db4-3465-49ad-8234-505646bb3874)

## 3.1 Use Case Diagram
![LakerVent UML](https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/73b81003-8046-40e4-a9ba-c31b21e9f788)
## 3.2 Class Diagram
![LakerVent Class Diagram](https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/b748fb77-79d5-493b-a4fd-694573b73e5d)
## 3.3 Sequence Diagram
![LakerVent Sequence Diagram](https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/fa8fcbfb-66e5-43c4-ae6d-adca81fe9537)

## 4 User Guide/Implementation
### Client Side:
#### 4.1 Installation
The user must install the “LakerVent” application on Android or IOS. After installation, the app icon will feature on the Home Screen of the user’s device.

<img width="306" alt="Screenshot 2023-11-16 at 6 50 16 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/51c1588f-2b4d-4cfb-9514-ddf318ad88f6">


#### 4.2 Home
The user can create a new post, comment, view, like, dislike, and report posts from this window. The user can also search and filter posts.

<img width="290" alt="Screenshot 2023-11-16 at 6 51 10 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/9c500730-7acc-4e36-bc1d-7d7f3f308879">


#### 4.3 Create a Post
Users can write their posts and create them by clicking the post button. A tag will be assigned based on the content of the post.

<img width="287" alt="Screenshot 2023-11-16 at 6 53 16 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/61e975ce-0e17-4600-8443-eea0f21ca666">

#### 4.4 Comment on Post
The user can comment on other users' posts and click enter to submit a comment.

<img width="290" alt="Screenshot 2023-11-16 at 6 55 08 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/94989524-e7f4-4669-9393-9befdf9a5577">

#### 4.5 Search
Users can search based on content in the posts or the tag.

<img width="289" alt="Screenshot 2023-11-16 at 6 53 46 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/4218a0ce-e0e2-4809-9fa5-1fbf2440cae3">


#### 4.6 Filter
Users can filter posts based on Recent, Oldest, and Most liked.

<img width="289" alt="Screenshot 2023-11-16 at 6 54 32 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/3e395de8-a83e-46d2-a31e-be8e4be2da24">


### Server Side:
#### 4.7 Server
Firebase is used as the server for the application. When a new post is created, it is stored in the server along with the tag, time stamp, how many times the post has been reported, and how many likes the post has. The like counter increments based on likes and dislikes. The administrator manually controls whether or not to remove a reported post.

<img width="1138" alt="Screenshot 2023-11-16 at 2 14 04 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/05412f9a-c9f2-45de-a697-b90e8d9541ad">

<img width="1142" alt="Screenshot 2023-11-16 at 2 13 43 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/f809ffc4-0f5a-4a3a-94b3-ca80583180e1">

## 5 Conclusion
