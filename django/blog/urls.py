from django.urls import path
from .views import PostListView, PostDetailView, PostCreateView
from rest_framework_simplejwt.views import TokenObtainPairView

urlpatterns = [
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('posts/', PostListView.as_view(), name='post-list'),                 # GET
    path('posts/<int:pk>/', PostDetailView.as_view(), name='post-detail'),   # GET
    path('posts/create/', PostCreateView.as_view(), name='post-create'),     # POST
]
