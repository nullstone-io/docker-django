# -*- coding: utf-8 -*-

import multiprocessing
import os

wsgi_app = os.getenv('WSGI_APP', 'app:application')
bind = os.getenv('BINDING', '0.0.0.0:80')
workers = int(os.getenv('WEB_CONCURRENCY', multiprocessing.cpu_count() * 2))
threads = int(os.getenv('PYTHON_MAX_THREADS', 1))
