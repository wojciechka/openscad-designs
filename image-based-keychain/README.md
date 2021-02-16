# Image based keychain

Create a keychain for keeping your key with any logo of your choice.

The design uses InfluxData logo, but any image can be used, as long as its size and rotation parameters are set to match the keychain size.

# image-based-keychain.scad

[Output STL file in 3D preview](./image-based-keychain.stl)

![Preview](./image-based-keychain.png)

## Customizations

The following are variables that can be customized in the OpenSCAD file:

| Variable             | Default | Unit | Description                                                                                                       |
|----------------------|---------|------|-------------------------------------------------------------------------------------------------------------------|
| keychain_radius      | 16      | mm   | Radius of the keychain                                                                                            |
| bottom_height        | 1.4     | mm   | Height of the bottom (base) of keychain                                                                           |
| border_height        | 1.6     | mm   | Height of the outer border of the keychain                                                                        |
| border_radius        | 1.2     | mm   | Radius of the outer border of the keychain                                                                        |
| holder_outer_radius  | 1.8     | mm   | Radius of the outer part of the holder                                                                            |
| holder_inner_radius  | 2.5     | mm   | Radius of the inner part of the holder                                                                            |
| image_filename       | ...     | file | Name of the SVG file to use for the image inside keychain                                                         |
| image_width          | 20      | mm   | Width to which the SVG image should be scaled                                                                     |
| image_height         | 20      | mm   | Height to which the SVG image should be scaled                                                                    |
| image_embed          | 1.0     | mm   | Height / depth of the embed with the SVG image                                                                    |
| image_translate_x    | -10.7   | mm   | Move the image X positionrelative to the center of keychain, allows using SVG images with different viewPorts     |
| image_translate_y    | -17     | mm   | Move the image Y positionrelative to the center of keychain, allows using SVG images with different viewPorts     |
| image_rotate         | 0       | deg  | Rotate the SVG image, allows for rotating logos for convenience                                                   |
