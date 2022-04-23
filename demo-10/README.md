# Userdata

# Userdata in AWS can be used to do any customization at launch.

## Userdata is only executed at the creation of the instance, not when the instance reboots...

In this example:

Whenever this instance spins up, we want it to attach the volume we've defined. If the volume is not formated it needs to be formatted.

The end result is we can immedeiately use our instance. If there was no data on the volume it is just formatted and mounted as an empty one. If there is already data on the volume, then it is mounted without formatting.
