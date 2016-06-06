##Introduction
  This is the final project for III GFEC01, our goal is to provide a flea market platform which allows users to easily, quickly sell/buy stuff, food, or share/join activities and support both iOS app and websites.

##Features
 * Membership Control
 * Shopping Cart
 * Rating Mechnism
 * Online Chat


##How to Collaborate
###iOS Platform

 1. Fork this repository (absoluteyl/GFEC_Project) to your own GitHub account.
 2. Clone this repository to your local machine.
 3. Create a new branch and start making your contributions to xcode project under iOS directory.
 4. Make a commit to your changes and push it to the new branch of your fork on GitHub.
 5. Create a pull request from the new branch into master. (absoluteyl/GFEC_Project)
 6. Resolve conflicts if any util your changes can be successfully merged into master.

###RoR Platform
If you're using Cloud9 IDE, follow steps below to start your workspace, and make sure not to modify anything under iOS directory.

 1. After login to Cloud9, click on "create a new workspace"
 2. Insert workspace name and descriptions whatever you like
 3. In the text field "Clone from Git or Mercurial URL", you MUST input the SSH URL of this repository (git@github.com:absoluteyl/GFEC_Project.git)
 4. Select Ruby Template for the workspace
 5. Click on "Create workspace"
 6. Create a new branch and start making your contributions to RoR application under RoR directory.
 7. Make a commit to your changes and push it to the new branch of your fork on GitHub.
 8. Create a pull request from the new branch into master. (absoluteyl/GFEC_Project)
 9. Resolve conflicts if any util your changes can be successfully merged into master.

##API Usage:
####Get Method:
#####General Index Request:
    GET /api/merchandises
    GET /api/merchandises/:id
    <br />
    GET /api/users
    GET /api/users/:id
    <br />
    GET /api/categories
    GET /api/categories/:id<
    <br />

#####Filtered Index Request:
######Merchandise: support title and price queries.
    GET /api/merchandises?title=exactTitle
    GET /api/merchandises?price=exactPrice
Queries can also combine different items in one URL like below:<br />
    GET /api/merchandises?title=exactTitle&price=exactPrice
######User: support username queries.
    GET /api/users?username=exactUsername
######Category: support category queries.
    GET /api/categories?name=exactName
<br />

##Contributors
[Caroline Xie](https://github.com/kyujyokei) /
[Elsa Lau](https://github.com/absoluteyl) /
[Fergus Ke](https://github.com/KeJingTai) 