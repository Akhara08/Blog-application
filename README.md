# 📝 Blog Application (Django + Flutter Web)

A full-stack blog web application where users can:
- Log in using JWT authentication
- View a list of blog posts
- Read full details of each post
- Create new posts (if authenticated)

This project uses **Django + Django REST Framework (DRF)** for the backend API and **Flutter Web** for the frontend

## 🚀 Features

### ✅ Backend (Django)
- JWT-based login using `djangorestframework-simplejwt`
- REST API for:
  - User login (`/api/login/`)
  - Listing all posts (`/api/posts/`)
  - Viewing a single post (`/api/posts/<id>/`)
  - Creating a post (`/api/posts/create/`)

### ✅ Frontend (Flutter Web)
- Responsive UI for browsers
- Login screen with token storage
- List view of all blog posts
- Post detail view
- Create post screen (visible only when logged in)
