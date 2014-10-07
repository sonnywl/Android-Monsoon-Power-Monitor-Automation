import commands
import sys
import os
import time

sys.path.append(os.path.dirname(os.path.realpath(__file__)))
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
from common import *

def main(argv):
	if len(argv) == 2:
		type = argv[1]
	else:
		print 'Not Enough Arguments "START, STOP, RESET, SHUTDOWN"'
		return
	
	startTime = time.time()

	# starting the application and test
	print "Connecting"
	device = MonkeyRunner.waitForConnection(1)
	print "Connected"

	unlock(device)
	homePress(device)
	startActivity(device, 'com.systemprofiler/com.systemprofiler.activity.Main')
	
	if type == "RESET":
		touchLocation(device, 300, 1130)
	elif type == "START":
		touchLocation(device, 600, 1130)
	elif type == "STOP":
		touchLocation(device, 100, 1130)
	else: # REMOVE INSTANCE SHUTDOWN
		backPress(device)

	print time.time() - startTime, " seconds"
	
	
if __name__ == "__main__":
	main(sys.argv)
