from rest_framework import viewsets, routers

from .models import Post
from .serializers import PostSerializer

# Create your views here.

class PostViewSet(viewsets.ModelViewSet):
    """A viewset for viewing and editing post instances."""
    serializer_class = PostSerializer
    queryset = Post.objects.all()

router = routers.SimpleRouter()
router.register(r'post', PostViewSet, base_name='post')
