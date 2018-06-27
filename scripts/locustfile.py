#-*- coding: utf-8 -*-
import uuid
import json

import locust
from locust import HttpLocust

class PostTaskSet(locust.TaskSet):
    data_weight = 100

    def _list(self):
        """List all posts"""
        self.client.get('/api/v1/post/')

    def _create(self):
        """Create a new post"""
        title = uuid.uuid4()
        description = str(uuid.uuid4()) * self.data_weight
        post_data = {
            'title': title,
            'description': description
        }
        self.client.post('/api/v1/post/', post_data)

    def _delete(self):
        """Delete a post"""
        resp = self.client.get('/api/v1/post/')
        posts = json.loads(resp.text)
        if len(posts) < 1:
            return
        post_id = int(posts[0]["id"])
        self.client.delete('/api/v1/post/{post_id}/'.format(**locals()))

    @locust.task(10)
    def add_benchmark(self):
        self._create()
        self._list()

    @locust.task(3)
    def delete_benchmark(self):
        self._delete()

class PostLocust(HttpLocust):
    task_set = PostTaskSet
    min_wait = 1000
    max_wait = 1000


