# Visual Gears

A Garmin Connect IQ data field for displaying electronic shifting gear information on Edge cycling computers.

## Overview

Visual Gears is a custom data field for Garmin Edge devices that provides a clear visual representation of your electronic shifting system's current gear selection. Designed for both Shimano Di2 and SRAM AXS electronic shifting systems, this app displays the current gear selection with an intuitive graphical interface.

## Features

- **Visual Gear Display**: Shows front and rear gear positions with rectangular indicators
- **Current Gear Ratio**: Displays the current gear ratio in teeth (e.g., "42 / 15")
- **Consistent Sizing**: All gear indicators are sized appropriately for easy viewing
- **High Contrast**: Black and white design for maximum visibility even in bright sunlight
- **Debug Information** (optional): Shows additional technical information about gear status



## Supported Devices

**Edge cycling computers**

- Edge 530 / 830 / 1030 / 1030 Plus / 1030 Bontrager
- Edge 540 / 840 / 1040
- Edge 550 / 850 / 1050
- Edge Explore 2
- Edge MTB

**Watches** (require a paired electronic shifting sensor; layout adapts to round screens)

- fenix 6 / 7 / 8 series
- epix (Gen 2) / epix Pro
- Enduro / Enduro 3
- Forerunner 255 / 265 / 745 / 945 / 955 / 965 / 970
- vivoactive 4 / 5
- Venu 2 / 3
- Instinct 2 / Instinct Crossover
- MARQ (Gen 2)

> Note: gear-shifting data is only shown on devices that support pairing an
> electronic shifting system. On unsupported devices the field falls back to a
> default 2×11 display.



## Supported Electronic Shifting Systems

- Shimano Di2
- SRAM AXS
- Other electronic groupsets that can connect to Garmin devices



## Installation

1. Download the app from the [Garmin Connect IQ Store](https://apps.garmin.com/)
2. Use Garmin Express or the Garmin Connect mobile app to install the data field on your device
3. Add the data field to one of your data screens in your cycling activity profile



## Setup

Before using this data field, make sure your electronic shifting system is properly paired with your Garmin device:

1. On your Edge device, go to Menu > Settings > Sensors
2. Select "Add Sensor" > "Shifting" (or similar)
3. Follow the pairing process for your specific electronic shifter
4. Configure your gear setup (number of teeth for each chainring/cog)



## How to Use

1. Start a cycling activity
2. Navigate to the data screen containing the Visual Gears data field
3. The display will show:
  - Top row: Front gear selection (chainrings)
  - Bottom row: Rear gear selection (cassette cogs)
  - Selected gears are shown in solid black
  - Current gear ratio is displayed below the visual indicators



## Development Information

This data field was developed using the Garmin Connect IQ SDK. The source code is available on GitHub under an open-source license.

### Building from Source

1. Install the [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/)
2. Clone this repository
3. Open the project in Visual Studio Code with the Monkey C extension
4. Build and deploy to your device



## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests with improvements or bug fixes.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- Thanks to Garmin for providing the Connect IQ platform
- Inspired by the need for better visual gear information while cycling

