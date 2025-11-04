# ALX Travel App

A modular, scalable Django-based travel listing platform with REST APIs, Swagger documentation, MySQL database integration, and Docker support. This project is built following industry-standard practices for maintainable backend development and scalable web applications.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Environment Configuration](#environment-configuration)
- [Database Setup](#database-setup)
- [Running the Project](#running-the-project)
- [API Documentation](#api-documentation)
- [Docker Setup](#docker-setup)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## Project Overview

`alx_travel_app` is a travel listing platform designed with a modular Django backend. It leverages:

- **Django REST Framework (DRF)** for building RESTful APIs.
- **Swagger / drf-yasg** for automatic API documentation.
- **MySQL** as the primary relational database.
- **Celery and RabbitMQ** for task queuing and background processing.
- **Docker** for containerized deployment.

This setup ensures scalability, maintainability, and readiness for production.

---

## Features

- User-friendly REST APIs for listings, bookings, and user management.
- Environment-driven configuration using `.env` and `django-environ`.
- Cross-Origin Resource Sharing (CORS) support for frontend integration.
- Swagger UI (`/swagger/`) and ReDoc (`/redoc/`) documentation.
- Containerized services for MySQL and RabbitMQ using Docker Compose.

---

## Requirements

- Python 3.12+
- Django 5.x
- MySQL 8.x
- Docker & Docker Compose (optional for local container setup)
- RabbitMQ (required for Celery background tasks)

---

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/alx_travel_app.git
   cd alx_travel_app

   ```

2. **Create a virtual environment:**

   ```bash
   uv venv
   source venv/bin/activate  # Linux / Mac
   venv\Scripts\activate     # Windows
   ```

3. **Install dependencies:**

   **Recommended**

   ```bash
   uv sync
   ```

   **Alternative**

   ```bash
   pip install -r requirement.txt
   ```

---

## Environment Configuration

1. Copy the `.env.example` file to `.env`:

   ```bash
   cp .env.example .env
   ```

2. Update your `.env` file with:

   ```env
   DATABASE_URL=mysql://user:password@localhost:3306/alx_travel_app
   SECRET_KEY=your-django-secret-key
   DEBUG=True
   CELERY_BROKER_URL=amqp://guest:guest@localhost:5672//
   ```

---

## Database Setup

1. Create the MySQL database (if not using Docker):

   ```sql
   CREATE DATABASE alx_travel_app;
   ```

2. Apply migrations:

   ```bash
   python manage.py migrate
   ```

3. (Optional) Create a superuser:

   ```bash
   python manage.py createsuperuser
   ```

---

## Running the Project

1. **Start Django server:**

   ```bash
   python manage.py runserver
   ```

2. Access the app at:

   ```link
   http://127.0.0.1:8000/
   ```

---

## API Documentation

Swagger and ReDoc endpoints:

- Swagger UI: [http://127.0.0.1:8000/swagger/](http://127.0.0.1:8000/swagger/)
- ReDoc: [http://127.0.0.1:8000/redoc/](http://127.0.0.1:8000/redoc/)

These endpoints automatically document all API routes.

---

## Docker Setup

1. **Start services with Docker Compose:**

   ```bash
   docker-compose up -d
   ```

2. Services included:

   - **Django app**
   - **MySQL**
   - **RabbitMQ**

3. Apply migrations inside the Django container:

   ```bash
   docker-compose exec django python manage.py migrate
   ```

4. Access the Django app at `http://localhost:8000/`.

---

## Future Enhancements

- Implement user authentication and permissions.
- Add advanced search and filtering for listings.
- Integrate frontend SPA (React) with REST API.
- Add background tasks for notifications, emails, and reporting.
