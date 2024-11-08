from rest_framework.throttling import UserRateThrottle,AnonRateThrottle

class CustomUserRateThrottle(UserRateThrottle):
    rate = '2/min'

class CustomAnonRateThrottle(AnonRateThrottle):
    rate = '2/min'