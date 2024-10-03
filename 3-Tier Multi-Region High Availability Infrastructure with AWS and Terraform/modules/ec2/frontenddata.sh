#!/bin/bash
# Update the package index
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Start the Apache service
systemctl start httpd

# Enable Apache to start on boot
systemctl enable httpd

# Create a styled index.html with real images and URLs
cat <<EOM > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My Web Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #5D5C61;
            font-size: 48px;
            margin-bottom: 20px;
        }
        p {
            font-size: 24px;
            color: #379683;
        }
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to My Web Server!</h1>
        <p>This is a simple web page served by Apache on EC2.</p>
        <img src="https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=800&q=60" alt="Image 1">
        <p>Explore the world of cloud computing!</p>
        <img src="https://images.unsplash.com/photo-1519999482648-25049ddd37b1?auto=format&fit=crop&w=800&q=60" alt="Image 2">
        <p>Keep learning and building!</p>
    </div>
</body>
</html>
EOM

# Restart Apache service to serve the new content
systemctl restart httpd