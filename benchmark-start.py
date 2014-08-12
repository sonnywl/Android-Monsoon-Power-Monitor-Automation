import commands
import sys
import os
import time

sys.path.append(os.path.dirname(os.path.realpath(__file__)))
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
from common import *

def main(argv):
	startTime = time.time()
	intervalToggle = False;
	if len(argv) >= 3 :
		type = argv[1]
		interval = argv[2]
		if(len(argv)==4) :
			intervalToggle = str2bool(argv[3])
			"""
			l = []
			l.append("IntervalToggle ")
			l.append(str(intervalToggle))
			print ''.join(l)
			"""
	else:
		print 'Not Enough Arguments "Name Interval ToggleState"'
		return
		
	# starting the application and test
	print "Connecting"
	device = MonkeyRunner.waitForConnection(1)
	print "Connected"

	unlock(device)
	homePress(device)
	startActivity(device, 'com.prac/com.prac.MainFragmentActivity')

	settings(device)
	if intervalToggle:
		touchLocation(device, 450, 670)
	else:
		touchLocation(device, 450, 770)
		
	settings(device)
	if interval == "1":
		touchLocation(device, 450, 195)
	elif interval == "2":
		touchLocation(device, 450, 270)
	elif interval == "3":
		touchLocation(device, 450, 370)
	elif interval == "4":
		touchLocation(device, 450, 470)
	elif interval == "5":
		touchLocation(device, 450, 570)
		
	if type=="accelerometer":
		touchLocation(device, 290, 475)
	elif type=="gyroscope":
		touchLocation(device, 290, 620)
	elif type=="gps":
		touchLocation(device, 290, 740)
	elif type=="barometer":
		touchLocation(device, 290, 840)
	elif type=="magnetometer":
		touchLocation(device, 290, 1040)
	elif type=="gravity":
		touchLocation(device, 290, 1140)
	
	device.shell("input keyevent KEYCODE_POWER")    # turn screen off (or on?)
	print time.time() - startTime, " seconds"
	
	
if __name__ == "__main__":
	main(sys.argv)
