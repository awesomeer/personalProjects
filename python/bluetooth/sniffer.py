import bluetooth
from time import sleep

devices = bluetooth.discover_devices(lookup_names=True);
print(str(len(devices)) + " devices found")
for device in devices:
    print(device)

sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
sock.connect((devices[0][0], 1))

sleep(3)
sock.close()

