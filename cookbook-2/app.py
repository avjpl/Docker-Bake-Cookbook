import os
import datatime

version = os.getenv('APP_VERSION', 'unknown')
print(f'Application Version: { version }')
print(f'Started at: { datetime.datetime.now() }')
