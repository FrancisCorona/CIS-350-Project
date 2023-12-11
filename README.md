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
Grand Valley State University students do not have a place to express their thoughts anonymously with their peers. LakerVent is a mobile application that empowers GVSU students to communicate without revealing their identity. Share your thoughts openly, categorize posts, and explore topics like academics, relationships, mental health, and more. Connect with peers through likes, comments, and supportive messages.

## 2 Introduction
With the rise in popularity of social media applications in the past decade, people have started to worry about what they post online and how their digital footprint may affect their future. Additionally, cyberbullying has become a significant problem with social media. Due to this, we introduce a new form of social media for anonymous posting so you can openly share your thoughts and opinions without any worries. The application will still have community guidelines that users need to follow, along with a reporting system to ensure a safe environment for everyone. LakerVent will provide a community for GVSU students to openly share their thoughts, easily find interesting posts through the AI topic modeling tagging system, and bring everyone closer together. The user just needs an Android or iOS device to join the LakeVent community.

## 3 Architectural Design
<p align="center"><img width="600" alt="Architectural Design" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/63f33ca1-6556-48e2-819c-d4709549a111">

## 3.1 Use Case Diagram
<p align="center"><img width="600" alt="Use Case Diagram" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/bd1d5ed2-4c0f-4de8-8517-83c77bbf857d">

## 3.2 Class Diagram
<p align="center"><img width="800" alt="Class Diagram" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/2cc1146e-4126-44f9-9aba-347a1eca8861">

## 3.3 Sequence Diagram
<p align="center"><img width="700" alt="Sequence Diagram" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/b4623c62-cd4a-48f2-b10a-b8a56f22b5aa">

## 4 User Guide/Implementation
### Client Side:
#### 4.1 Installation
The user must install the “LakerVent” application on Android or iOS. After installation, the app icon will feature on the Home Screen of the user’s device.

<p align="center"><img width="300" alt="iOSHomeScreen" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/a0f916c2-c4a1-41fd-a87c-35272dbe140a">

#### 4.2 Home
The user can create a new post, comment, view, like, dislike, and report posts from this window. The user can also search and filter posts.

<p align="center"><img width="300" alt="HomePage" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/7ccca519-dca0-4c4c-b743-7e070d34e606">

#### 4.3 Create a Post
Users can write their posts and create them by clicking the post button. A tag will be assigned based on the content of the post.

<p align="center"><img width="300" alt="PostPage" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/7a4244e1-e15e-4c6f-b5fd-df5f50788066">

#### 4.4 Comment on Post
The user can comment on other users' posts and click enter to submit a comment.

<p align="center"><img width="300" alt="CommentPage" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/eb3f690f-762a-4ee6-9823-606eab6e1d33">

#### 4.5 Search
Users can search based on content in the posts or the tag.

<p align="center"><img width="300" alt="SearchBox" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/8f065176-593c-4f91-80d1-6bc7db55a8c8">

#### 4.6 Filter
Users can filter posts based on Recent, Oldest, and Most liked.

<p align="center"><img width="300" alt="FilterBox" src="https://github.com/FrancisCorona/CIS-350-Project/assets/19364963/2cb87e8d-6cfd-464b-a049-650af7269169">

### Server Side:
#### 4.7 Server
Firebase is used as the server for the application. When a new post is created, it is stored in the server along with the tag, time stamp, how many times the post has been reported, and how many likes the post has. The like counter increments are based on likes and dislikes. The administrator manually controls whether or not to remove a reported post.

<img width="1138" alt="Screenshot 2023-11-16 at 2 14 04 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/05412f9a-c9f2-45de-a697-b90e8d9541ad">

<img width="1142" alt="Screenshot 2023-11-16 at 2 13 43 PM" src="https://github.com/FrancisCorona/CIS-350-Project/assets/117117993/f809ffc4-0f5a-4a3a-94b3-ca80583180e1">

#### 4.8 AI Topic Modeling
We utilized Google's PaLM 2 large language model for feature extraction to automatically tag a post based on this content so users can easily find interesting posts. We chose PaLM 2 because of it's easy to use API, it's power, and there are no associated costs.

## 5 Risk Analysis and Retrospective
### 1. Risk: Abuse and Harassment:
Due to anonymity users may feel less accountable for their actions and it could lead to abusive behavior
- **Likelihood:** High
- **Impact:** Moderate to High
### 2. Risk: Fake News and Misinformation:
Users make spread misinformation in order to cause controversy and drama
- **Likeligood:** Moderate
- **Impact:** Moderate
### Mitigation Strategies:
#### What was done:
We created a report button for every post so that users could report a post if they felt it should be removed. Posts with high report counts could then be reviewed and a dececion could be made whether to keep the post or remove it.
#### How it could have been done better:
- Multiple options could have been provided when reporting so the user could specify why they feel the post should be removed
- Implement an AI to automatically monitor every post created
- Add a report option on comments
## 6 Conclusion
LakerVent is an essential platform for fostering anonymous communication among Grand Valley State University students, offering refuge from the constraints of mainstream social media. LakerVent is not just an application; it is a dynamic and evolving contribution to the GVSU community, and we look forward to its ongoing success.
