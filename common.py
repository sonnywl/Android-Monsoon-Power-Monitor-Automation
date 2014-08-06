from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

def touchLocation(device, x, y):
	device.touch(x, y, 'downAndUp')
	MonkeyRunner.sleep(0.5)

def settings(device):
	touchLocation(device, 660, 100)	# Settings
	
def backPress(device):
	# Nexus 4
	touchLocation(device, 125, 1220)
	#device.press('KEYCODE_BACK', MonkeyDevice.DOWN_AND_UP)
def homePress(device):
	touchLocation(device, 350, 1220)
	#device.press('KEYCODE_HOME', MonkeyDevice.DOWN_AND_UP)

def star(device):
#	touchLocation(device, 736, 162) # Nexus 4
	touchLocation(device, 680, 162)

def load(device):
#	touchLocation(device, 554, 280) # Nexus 4
	touchLocation(device, 480, 280)
	
def play(device):
#	touchLocation(device, 736, 234) # Nexus 4
	touchLocation(device, 679, 280)
	
def runLinpack(device):
#	touchLocation(device, 45, 666) # Nexus 4
	touchLocation(device, 45, 600)

def startActivity(device, activityName):
	device.startActivity(component=activityName)
	MonkeyRunner.sleep(1)	

def unlock(device):
	device.shell("input keyevent 82")    # unlock
	MonkeyRunner.sleep(1)
	
def str2bool(v):
	return v.lower() in ("yes", "true", "t", "1")
