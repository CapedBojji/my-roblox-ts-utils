# My Roblox TS Utils



## Description

My Roblox TS Utils is a collection of utility functions and classes for Roblox development using RobloxTS. It provides commonly used functionalities to simplify the development process and improve productivity.

## Installation

You can install the latest version of this package by adding this to your package

```json
"@capedbojji/utils": "git+ssh://git@github.com/CapedBojji/my-roblox-ts-utils.git#latest"
```

## Utility Classes

This package provides the following utility classes:

- `GRect`: Utility class for rectangle operations, aswell as representing Parts as rects from their top down view 
- `Segment`: Utility class for line segment operations
- `Point2D`: Extension of the Vector2 class
- `Grid`: Utility class for Grid operations
- `RandomSynced`: A Utility class for generating random values, provides functions like 
  - **Random:numberAt(t)**: Which will return the nth random number, from the seed. 
  Basically, if you created a new random object and called *getNext* t times what would it return

## Utility Modules

- `getX_2MB`: Function for getthing where 2 line segments intersection given thier slopes and yintercept,
- `getY_XMB`: Slope intercept formula,
- `getX_YMB`: Finding x in slope intercept formula,
- `centroid`: Calculating the centriod of points,
- `getAngle_2Points`: Calculating the angle between 2 points,
- `getDistance_2Points`: Calculating the distance between 2 points,
- `rotatePoint`: Rotating a point b a given angle, around the origin,