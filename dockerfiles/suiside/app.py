import time
import signal
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--wait', type=int, default=0)
args = parser.parse_args()

o = {}
o['_alive'] = True
_interval = 0

def sigint(a,b):
  print 'called sigint', _interval
  o['_alive'] = False

def sigkill(a, b):
  print 'called sigkill', _interval
  sys.exit(1)

signal.signal(signal.SIGINT, sigint)
signal.signal(signal.SIGTERM, sigkill)

while o['_alive']:
  print 'ping', _interval
  time.sleep(5)
  _interval += 1

print 'waiting', args.wait
time.sleep(args.wait)

print 'completed successfully'
