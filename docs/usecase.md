# Wholesailor - Wholesale and Inventory Management for WooCommerce Shops

## Executive Summary
Wholesailor is a web application designed to streamline the management of wholesale suppliers and inventory updates for WooCommerce shop owners. The application offers a user-friendly interface to easily manage product information, supplier data, and track product availability from various wholesale suppliers. It will also automate the process of updating product information in the WooCommerce store and run daily crawls to check product availability, ensuring accurate and up-to-date information for the shop owners.

## Objective
The main objective of Wholesailor is to simplify and automate the process of managing wholesale and inventory-related tasks for WooCommerce shop owners, allowing them to focus on other aspects of their business.

## Key Features
1. Secure user authentication to access the web application.
2. Display and edit product information in an intuitive table format, including product ID, title, article number, wholesale company, dropshipping status, availability, and notes.
3. Search functionality within each table column for easy data filtering.
4. Manage wholesale company data, including adding, editing, and deleting companies.
5. Automate daily crawls of wholesale company websites to check product availability and update the WooCommerce store accordingly.
6. Sync updates to product information and article numbers between Wholesailor and the WooCommerce store.
7. Cloud-based architecture using AWS services such as S3, Lambda, and DynamoDB.
8. Automated CI/CD pipeline for seamless deployments and updates.
9. Infrastructure provisioning using Terraform for easy management and scalability.

## Benefits
1. Improved efficiency in managing product and wholesale information, reducing manual effort and potential for errors.
2. Enhanced visibility and control over product availability, allowing shop owners to make informed decisions about their inventory.
3. Streamlined synchronization between Wholesailor and the WooCommerce store, ensuring accurate and up-to-date product information.
4. Scalable and secure cloud-based infrastructure, allowing for future expansion and feature additions.
5. Streamlined deployment and update process using CI/CD, ensuring consistent and reliable application updates.
6. Simplified infrastructure management and scalability using Terraform for provisioning AWS resources.

## Technical Architecture
1. Frontend built using HTML, CSS, and JavaScript, with potential integration of a modern frontend framework like React.
2. Backend developed using Python, with support for a popular web framework like Flask or FastAPI.
3. Containerization using Docker and Docker Compose for local development, including a local DynamoDB instance.
4. Deployment on AWS infrastructure, utilizing services like S3 for frontend hosting, Lambda for serverless backend processing, and DynamoDB for data storage.
5. Secure management of credentials and sensitive information using environment variables and AWS Secrets Manager.
6. CI/CD pipeline using a platform like GitHub Actions, GitLab CI/CD, or AWS CodePipeline for automated testing, building, and deployment of the application.
7. Infrastructure as Code (IaC) using Terraform for provisioning and managing AWS resources.

## Conclusion
Wholesailor is a comprehensive solution for WooCommerce shop owners to manage their product information, wholesale suppliers, and inventory updates with ease. By automating critical tasks and providing a user-friendly interface, Wholesailor empowers shop owners to focus on growing their business while maintaining accurate and up-to-date product information. The addition of a CI/CD pipeline and Terraform-based infrastructure provisioning further streamlines the development, deployment, and management of the application, ensuring a reliable and scalable solution.
