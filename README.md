<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
  </a>

<h3 align="center">Soundify</h3>

  <p align="center">
    Spotify/Soundcloud Music Application
    <br />

  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project

This was originally a project created in Fall 2019 in a team that I am attempting to recreate in Ruby on Rails for the backend and React on the frontend. The application strives to be an interface for both your Spotify and Soundcloud libraries, making it possible to play songs and create playlists from both platforms. The user will be able to connect to these platforms by using their respective oauth implementations.

* Note - Currently Soundcloud is not accepting application requests for developers, as they say they are working on making their API more efficient first. Thus, the Soundcloud portion will have to hold off for the time being. 

<!-- USAGE EXAMPLES -->
## Usage

### Frontend

The frontend application can be started by looking at the README in the frontend/ directory.


### Backend

Ensure that node.js and yarn are both installed first. These can be checked by the following commands: 
```
$   node --version
$   yarn --version
```
For installation instructions, you can visit [the Node.js website](https://nodejs.org/en/download/) and [the Yarn website](https://classic.yarnpkg.com/en/docs/install).
<br/>
<br/>
Ensure that PostgreSQL is installed on your system. This can be installed [here](https://www.postgresql.org/download/).
<br/>
<br/>
You will need to create a database named 'soundify_dev' and create a role with connection details in the /backend/config/database.yml file that will be created below. 
<br/>
<br/>
The backend application can be started by running the following commands:
<br/>
```
$   cd backend
$   gem install rails
$   bundle install
```
This will install all dependencies for the app.
<br/>
```
$   rails db:migrate
```
This will create the necessary schemas in the connected db. 
<br/>
Finally run:
```
$ rails s
```
to start the server.

