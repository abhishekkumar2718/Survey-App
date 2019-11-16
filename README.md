# Survey App

A Full Stack Web Application created as part of [Web Club NITK Googe DSC Recruitments 2019](https://github.com/WebClub-NITK/Google-DSC-NITK-Recruitments-2019/blob/master/RECRUITMENTS_2019.md).

`Task ID: Survey_App`

A survey application for creating and answering simple mutliple choice questions.

> I had to remove heroku instances since I had reached 5 apps limit. Please check out instructions for running this application locally below.
## Screenshots

![Log in page](/screenshots/login.png)
![Index](/screenshots/index.png)
![Options not filled](/screenshots/options_not_filled.png)
![Invite](/screenshots/invite.png)
![Show](/screenshots/show.png)
![Load results](/screenshots/load_result.png)
![Load Survey](/screenshots/load_survey.png)

## Features Implemented

- Authentication
- Answering survey
- Aggregrate results
- Authorization for surveys
- Creating Surveys

## Installation

#### 1. Install and configure Postgresql

The application uses Postgresql to maintain compatablity with Heroku.

[Instructions for Ubuntu]()

#### 2. Clone the repository and change directory 

`git clone https://github.com/abhishekkumar2718/Survey-App; cd Survey-App`

#### 3. Install required gems

Gems are the ruby equivalent of third party libraries.

**Optional**: Install RVM (an environment manager for ruby) and create a gemset. [Read more here]()

Install Bundler (a package manager for ruby gems)

`gem install bundler`

Install required gems.

`bundle install`

#### 4. Set up the database

This command creates the database, the tables and sets up the neccesary data seed.

`rails db:setup`

#### 5. Run your server

The application has been installed and can be used. Use the following command to run the server.

`rails s`

## Milestones

- [x] Setup Materialize
- [x] Setup Devise
- [x] Generate model
- [x] Create seed data
- [x] Answer flow
- [x] Host on Heroku
- [x] Authorization for surveys
- [x] Creating surveys
- [ ] Improvements to UX

## Possible Extensions

- Comment Chains
- Time bound surveys
