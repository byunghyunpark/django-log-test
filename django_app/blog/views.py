from rest_framework import permissions
from rest_framework.generics import ListCreateAPIView

from .models import Blog
from .serializers import BlogSerializer


class BlogListView(ListCreateAPIView):
    serializer_class = BlogSerializer
    queryset = Blog.objects.all()
    permission_classes = (permissions.AllowAny, )
