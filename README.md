pi builder
==========

[![CircleCI](https://circleci.com/gh/sourcebots/pi-image.svg?style=shield)](https://circleci.com/gh/sourcebots/pi-image)

Scripts for building images and updates ready for deploying to a Raspberry Pi. It should work on any version of Raspberry Pi, however the scripts are only tested on a Raspberry Pi 3.

Scripts:

- `build-image.sh` is the driver
- `main.sh` is run in the image.


### Getting the latest build

You can get the latest build from CircleCI.

1. Go to the [lastest master][latest-master] of circleci.
2. Click on the number of the latest successful build (the topmost one which succeeds).
3. Click on the 'Artifacts' tab
4. Download the `pi-image.tar.xz` file for a pi image to flash to the pi, see [the docs][docs-flashing-pi] for how to flash a raspberry pi with this file.

[latest-master]: https://circleci.com/gh/sourcebots/pi-image/tree/master
[docs-flashing-pi]: https://docs.sourcebots.co.uk/kit/pi/#updating-your-pi
