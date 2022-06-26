# Surface Pen cap

Cap for surface pen that is designed to be strong and guard the tip from being damaged in transport.

Designed for being put with other things and inside bags, therefore it's stronger than other designs I have tried.

This works fine with _Surface Pen with single button on flat edge_ and _Surface Pen with no clip_, but should also work with most non-slim pens.

# surface-pen-cap.scad

[Output STL file in 3D preview](./surface-pen-cap.stl)

![Preview](./surface-pen-cap.png)

## Customizations

The following are variables that can be customized in the OpenSCAD file:

| Variable             | Default | Unit | Description                                                                                                       |
|----------------------|---------|------|-------------------------------------------------------------------------------------------------------------------|
| lid_slant_height     | 0.8     | mm   | Height of the slanting that makes the top of the tip more friendly                                                |
| lid_slant_width      | 0.6     | mm   | Width of the slanting that makes the top of the tip more friendly                                                 |
| radius               | 5.1     | mm   | Radius of the surface pen to use                                                                                  |
| minimal_radius       | 1.0     | mm   | Inner radius of the tip at the end of the cap                                                                     |
| outer_radius         | 6.6     | mm   | Outer radius of the lid, defaults to `radius + 1.5`                                                               |
| end_radius           | 4.8     | mm   | Rounding at the end of the cap that is meant to improve grip against Surface Pen, defaults to `radius - 0.3`      |
| end_radius_height    | 0.6     | mm   | Height to use for the rounding at the end of the cap                                                              |
| cutoff_offset        | 3.825   | mm   | Offset at which to cut off one side to mimic Surface Pen not being fully round; defaults to `radius * 0.75`       |
| height               | 30      | mm   | Height of the holder, without without the cap itself                                                              |
| tip_placeholder_size | 18      | mm   | Height of the tip placeholder, the part where radius is reduced to secure the tip                                 |
