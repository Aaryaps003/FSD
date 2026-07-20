<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Subject</title>
    <link rel="stylesheet" href="css/admin.css">
    <style>
        /* Form specific styling to match the admin theme */
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            max-width: 500px;
            margin-top: 20px;
            border-top: 4px solid var(--primary-blue);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--primary-blue);
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-btn {
            background-color: var(--primary-blue);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .submit-btn:hover {
            background-color: var(--secondary-blue);
        }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="sidebar-header">
            <h3>Admin Portal</h3>
        </div>
        <ul class="nav-links">
            <li><a href="admin.jsp">Dashboard</a></li>
            <li class="active"><a href="add-subject.jsp">Manage Subjects</a></li>
            <li><a href="#">Student Enrollments</a></li>
            <li><a href="#">Faculty List</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <header class="top-header">
            <h2>Add New Subject</h2>
            <a href="login.html" class="logout-btn">Logout</a>
        </header>

        <div class="content-wrapper">
            <% 
                String err = request.getParameter("err");
                if (err != null) out.print("<h4 style='color:red; margin-bottom:15px;'>Error: Could not add subject. Check if course code is a duplicate.</h4>");
            %>
            
            <div class="form-container">
                <form action="add-subject" method="POST">
                    <div class="form-group">
                        <label>Course Code (e.g., CS101)</label>
                        <input type="text" name="courseCode" required maxlength="20">
                    </div>
                    <div class="form-group">
                        <label>Subject Name</label>
                        <input type="text" name="courseName" required maxlength="150">
                    </div>
                    <div class="form-group">
                        <label>Instructor Name</label>
                        <input type="text" name="instructor" required maxlength="100">
                    </div>
                    <div class="form-group">
                        <label>Total Available Seats</label>
                        <input type="number" name="availableSeats" required min="1">
                    </div>
                    <button type="submit" class="submit-btn">Save Subject</button>
                    <a href="admin.jsp" style="margin-left: 15px; text-decoration: none; color: #666;">Cancel</a>
                </form>
            </div>
        </div>
    </main>
</body>
</html>