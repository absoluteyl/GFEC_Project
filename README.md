##Introduction
  This is the final project for III GFEC01, our goal is to provide a flea market platform which allows users to easily, quickly sell/buy stuff, food, or share/join activities and support both iOS app and Website.

##Features
 + **User Management:**  
 Uses devise, including registration, email confirmation for registration, login/logout, forget password, delete account.  

 + **User Location Management:**  
 Allows users to configure their location profile for merchandise location, shipping address usages.  

 + **Merchandise Management:**  
 Allows users to upload, update, delete merchandises.  

 + **File Upload:**  
 Uses paperclip + AWS S3, so users can upload images for their avatar or merchandises.  

 + **Shopping Cart & Order:**  
 Uses Stripe Payment, allow users to pay with credit cards.  

 + **RESTful API support:**  
 Support JSON API for iOS App to create/read/update/delete data from databse.  

 + **Online Chat (iOS App only)**

##Database Architecture
![DB architecture](/app/assets/images/database.png)

##API Usage:
####API Authentication:
To access API resources, you must contact with administrator for applying an API key,
every HTTP(S) request should add this API key in URL to pass authentication.

    api/users?api_key=your-api-key

####User Autnentication
User Login:

    POST /api/login
    
    Accept: application/json
    Content-type: application/json
    
    {
        "user_login":{
            #Mandatory Fields
            "email": "string",
            "password": "string"
        }
    }
    
User Logout:

    DELETE /api/logout
    
    Accept: application/json
    Content-type: application/json
    
    {
        "user_login":{
            #Mandatory Fields
            "email": "string"
        }
    }
    
####Image Path Namine Rule:
    :class/:attachment/000/000/:id_partition/:style/:filename
    #=> users/avatar/000/000/013/small/my_pic.png
    
####Merchandise:
#####GET:
General Query:
    
    GET /api/merchandises
    GET /api/merchandises/:id

Filtered Query:
    
    GET /api/merchandises?title=exactTitle
    GET /api/merchandises?price=exactPrice
    
    GET /api/merchandises?title=exactTitle&price=exactPrice
#####POST:
    
    POST /api/merchandises
    
    Accept: application/json
    Content-type: application/json
    
    {
        "merchandise":{
            #Mandatory Fields
            "title": "string",
            "description": "string",
            "price": integer,
            "amount": integer,
            "user_id": integer,
            "category_id": integer,
            "location_id": integer,
            "image_1": attachment
            
            #Optional Fields
            "image_2": attachment,
            "image_3": attachment
        }
    }
    
#####PUT/PATCH:
    
    PUT /api/merchandises/:id
    PATCH /api/merchandises/:id
    
    Accept: application/json
    Content-type: application/json
    
    {
        "merchandise":{
            #Available Fields
            "title": "string",
            "description": "string",
            "price": integer,
            "amount": integer,
            "category_id": integer,
            "image_1": attachment,
            "image_2": attachment,
            "image_3": attachment
        }
    }
    
#####DELETE:
    
    DELETE /api/merchandises/:id
    
    Accept: application/json
    Content-type: application/json
    
####Category:
#####GET:
General Query:
    
    GET /api/categories

Filtered Query:
    
    GET /api/categories?id=id
    GET /api/categories?name=exactName
    
#####POST:
Not support
#####PUT/PATCH:
Not support
#####DELETE:
Not support

####User:
#####GET:
General Query:
    
    GET /api/users
    GET /api/users/:id

Filtered Query:
    
    GET /api/users?username=exactUsername
    
#####POST:
    
    POST /api/users
    
    Accept: application/json
    Content-type: application/json
    
    {
        "user":{
            #Mandatory Fields
            "username": "string",
            "email": "string",
            "mobile": "string",
            "password": "string",
            
            #Optional Fields
            "admin": boolean,
            "avatar": attachment
        }
    }
    
#####PUT/PATCH:
    
    PUT /api/users/:id
    PATCH /api/users/:id
    
    Accept: application/json
    Content-type: application/json
    
    {
        "user":{
            #Available Fields
            "email": "string",
            "mobile": "string",
            "password": "string",
            "avatar": attachment
        }
    }
    
#####DELETE:
    
    DELETE /api/users/:id
    
    Accept: application/json
    Content-type: application/json
    
####Location:
#####GET:
General Query:
    
    GET /api/locations?id=[id]
    GET /api/locations?user=[user_id]
    GET /api/locations?city=[city_id]

#####POST:
    
    POST /api/locations
    
    Accept: application/json
    Content-type: application/json
    
    {
        "location":{
            #Mandatory Fields
            "user_id": "integer",
            
            #Optional Fields
            "postcode": integer,
            "city": "string",
            "address": "string",
            "recipient": "string",
            "phone": "string",
            "lat": float,
            "long": float
        }
    }
    
#####PUT/PATCH:
    
    PUT /api/locations/:id
    PATCH /api/locations/:id
    
    Accept: application/json
    Content-type: application/json
    
    {
        "location":{
            #Available Fields
            "postcode": integer,
            "city": "string",
            "address": "string",
            "recipient": "string",
            "phone": "string",
            "lat": float,
            "long": float
        }
    }
    
#####DELETE:
    
    DELETE /api/locations/:id
    
    Accept: application/json
    Content-type: application/json
    
####City:
#####GET:
General Query:
    
    GET /api/cities

Filtered Query:
    
    GET /api/cities?id=id
    GET /api/cities?name=exactName

<br />

##How to Collaborate
###iOS Platform

 1. Fork this repository (absoluteyl/GFEC_Project) to your own GitHub account.
 2. Clone this repository to your local machine.
 3. Create a new branch and start making your contributions to xcode project under iOS directory.
 4. Make a commit to your changes and push it to the new branch of your fork on GitHub.
 5. Create a pull request from the new branch into master. (absoluteyl/GFEC_Project)
 6. Resolve conflicts if any until your changes can be successfully merged into master.

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
 9. Resolve conflicts if any until your changes can be successfully merged into master.


##Contributors
iOS App - [Caroline Xie](https://github.com/kyujyokei)  
Rails App - [Elsa Lau](https://github.com/absoluteyl)  
Frontend - [Fergus Ke](https://github.com/KeJingTai) 
