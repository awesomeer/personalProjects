import bluetooth

devices = bluetooth.discover_devices(lookup_names=True);
print(str(len(devices)) + " devices found")
for device in devices:
    print(device)
