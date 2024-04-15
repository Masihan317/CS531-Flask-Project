# Flask Role-Based Access Control System

Implementing a backend permission management system using Python's Flask WEB framework, including: user management, role management, resource management, and institution management.

The system's default login information:
Username: admin
Password: 123456

### Frontend Tech Stack
- Vue
- Vuex
- ElementUI
- Axios

### Backend Tech Stack
- Flask
- Flask-SQLAlchemy
- Flask-Login
- Flask-Excel

### Quick Start Guide
Frontend
1. Install Node.js
2. Navigate to the ui directory of the source code. ```cd ui```
3. ```npm install```
4. ```npm run dev```

Backend
1. Import the db.sql database script found in the root directory into a MySQL database.
2. ```pip3 install -r requirements.txt```
3. Change the database connection in the config.py DevelopmentConfig class, providing the username and password.
4. ```python3 -m flask --app start run -h 0.0.0.0 -p 5000```