import commands
import sys
import os
import time

sys.path.append(os.path.dirname(os.path.realpath(__file__)))
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
from common import *
from datetime import datetime

def main(argv):
	if len(argv) == 2 :
		type = argv[1]
		'''
		l = []
		l.append(type)
		l.append(" ")
		print ''.join(l)
		'''
	else:
		print 'Arguments not matched'
		return
	'''
	d = datetime.now()
	l = []
	l.append(os.getcwd())
	l.append(datetime.now().strftime('%Y-%m-%d-%H-%M-%S')+'-'+type+".png")
	''.join(l)
	'''
	
	startTime = time.time()
	device = MonkeyRunner.waitForConnection(1)
	print "Connected"
	unlock(device)
	'''
	if type=="accelerometer":
		touchLocation(device, 290, 475)
	elif type=="gyroscope":
		touchLocation(device, 290, 620)
	elif type=="gps":
		touchLocation(device, 290, 740)
	'''
	device.shell('am force-stop com.prac')
	device.shell("input keyevent KEYCODE_POWER")    # turn screen off (or on?)
	print time.time() - startTime, " seconds"

if __name__ == "__main__":
	main(sys.argv)
