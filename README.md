# Nail & Spa Springs

Currently, I live with other people who come from the same country. Especially they just run a business related to ‘Nail & Spa Rusell’ shop. Every day they are very busy because they need to write down some information in a notebook based on a customer's call to make an appointment. Sometimes they say ‘We are losing the customer when we can’t pick up the phone on time’ so they can’t call back at the moment. After they told me about their problem. Finally, I decided to collect more requirements and build the application to support this business in the future. Nail & Spa Rusell is a booking app that helps people book appointments whenever they want. This way, customers do not have to worry about waiting on the phone or physically visiting the Nail & Spa. At the same time, managers now have a way to manage their appointments effectively.


## Table of contents
* [Features](#features)
* [Technologies](#technologies)
* [Installation](#installation)
* [Screenshot](#screenshot)
* [Support this repo](#support-this-repo)
* [Social Contact](#social-contact)
* [Conact Info](#contact-info)


## Features
- Authentication
  - Create Account
  - Login 
  - Login by social (Facebook & Google)
  - Forget Password
- Home
  - promotion
  - Staff member
  - Service
  - Gallery
  - Business Hour
- Notifications
- Make an Appointment
  - Allow make an appoitment the same from 1:00AM until 11:00AM else move to next day
  - Always close shop on Monday
  - Time Slot dymanic depending on weekday
- Booking
  - Upcoming
     - Reschedule Appointment
     - Cancel Appointment
  - Completed
     - Review
- Profile
  - Our Service
  - View or Update Information
  - Change Password
  - Contact Us
  - Nail & Spa Springs
  - Term & Conditions
  - Dark Mode
- Settings
  - Feedback


## Technologies
- Swift 5.3 (Storyboard)
- Compatible OS version: 16
- Compatible Dark & Light Mode
- CoreData 
- RESTFul API
- Alamofire
- SwiftyJSON
- Calendar
- Kingfisher
- Lottie 
- Integrated (Facebook & Google)


## Installation
#### Clone the code
```sh
$ https://github.com/ithemecambo/nail_spa_ios.git
$ cd Nail & Spa Springs 
```

#### Pod install
```sh
$ pod install
```

#### Server run on port: 8000
```sh
$ # You can change the server configuration
$ # (Ex: 192.0.0.1:8000 or localhost:8000) 
$ # apiPath = "http://localhost:8000/api/v1/"
$ # BaseUrl = "http://localhost:8000/api/v1/"
```

## Screenshot
#### Light Mode
<img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/0.1.login.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/0.2.create-account.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/1.1.home.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/1.2.notification.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/2.1.appointment.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/2.2.appointment.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/2.3.appointment.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/3.1.booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/3.2.reschedule-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/3.3.cencel-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/3.4.completed-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/3.5.review-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/4.1.account-settings.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/4.2.account-info.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/light/4.3.shop-location.png" width="170">

#### Dark Mode
<img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/1.1 login.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/1.2 create account.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/2.1 home.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/2.2 notification.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/3.1 appointment.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/3.2 add service for app.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/3.3 confirmation app.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/3.4 appointment success.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/4.1 upcoming-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/4.2 upcoming-cancel.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/4.3 upcoming-reschedule.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/4.4 completed-booking.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/4.5 completed-review.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/5.1 profile.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/5.2 view-account.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/5.3 contact-us.png" width="170"><img src="https://github.com/ithemecambo/nail_spa_ios/blob/main/screenshots/dark/5.4 nail_spa_springs.png" width="170">



## Support this repo
* Star this repo <img src="https://github.com/ithemecambo/nail_spa_portal/blob/main/screenshots/give-star.png" width="60">


## Social Contact
* LinkedIn: <a href="https://www.linkedin.com/in/senghortkheang">kheang senghort</a>
* Portfolio: <a href="https://ithemecambo.github.io/portfolio">Senghort Kheang</a>
* Demo App: <a href="https://youtu.be/p5YKqSXfMMI">Nail & Spa Springs</a>


## Contact Info
* Email: senghort.rupp@gmail.com
