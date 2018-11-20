from locust import HttpLocust, TaskSet, task

class UserBehavior(TaskSet):
    @task(1)
    def home(self):
        self.client.get("/")

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000
    
# locust --host=http://localhost:80