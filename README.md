# Student Management System (Java)

This is a Student Management System built using Java, JSP/Servlets, and HTML/JavaScript for the web interface.

## Technologies Used

- **Backend Language:** Java (JSP/Servlets)
- **Frontend Languages:** HTML, JavaScript
- **Database:** MySQL

## Database Details

The system uses MySQL as its relational database. Example connection strings from the code:
```java
jdbc:mysql://localhost:3306/stud_db
```
or
```java
jdbc:mysql://localhost:3306/student_management
```
with default credentials (user: `root`, password: `roote`).

## Features

- Add, view, and delete student records
- Secure student login
- Faculty management
- Responsive HTML/CSS/JavaScript frontend

## Getting Started

1. **Clone the repository:**
   ```
   git clone https://github.com/BorudePiyush/StudentMANAGEMENTSystem-using-java.git
   ```

2. **Setup MySQL:**
   - Create a database (e.g., `stud_db` or `student_management`)
   - Update database credentials in the Java source code if needed

3. **Build and Run:**
   - Import the project into Eclipse or your preferred IDE
   - Configure your servlet container (e.g., Apache Tomcat)
   - Deploy and access via browser

## File Structure

- `src/main/java/com/demo/controller/`: Java servlets for handling backend logic
- `src/main/webapp/`: HTML, JSP, and static resources for the frontend

## License

This project is open source and available under the MIT License.
