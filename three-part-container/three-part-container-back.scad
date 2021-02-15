container_width = 85;
container_height = 114.5;
container_depth = 30;

frame_base = 2.63;
frame_bottom_size = 2.63;
frame_side_size = 2.63;

width = container_width + frame_side_size * 2;
depth = container_height + frame_bottom_size;
height = container_depth / 2.0 + frame_base;

spacing_other_extend = 1.2;
spacing_keep = 4.5;
spacing_depth_offset = -0.5;

tip_size = 1.2;
tip_height = 1.5;
tip_extrude_size = depth * 0.75;

close_tip_offset = 2.0;

module tip(tip_size_difference = 0.0, tip_height_difference = 0.0, size_difference = 0.0, tip_extrude = tip_extrude_size) {
  rotate([90, 0, 0])
    linear_extrude(height = tip_extrude - size_difference, center=true) {
      polygon(points=[
        [-tip_size + tip_size_difference, 0],
        [0, tip_height - tip_height_difference],
        [tip_size - tip_size_difference, 0]
      ]);
    };
}

module keep_hole() {
  cube([width / 2.0 - spacing_keep, depth / 2.0 - spacing_keep, height * 2], center = true);
}

color(c = [0.6, 0.6, 0.6])
  render()
  translate([0, 0, height / 2.0])
  union() {  
    difference() {
      translate([0, 0, 0])
        cube([width, depth, height], center = true);

      translate([0, 0, frame_base])
        cube([width - frame_side_size * 2, depth - frame_side_size * 2, height], center = true);

      translate([0, frame_bottom_size / 2.0 + 0.01, frame_base])
        cube([width - frame_side_size * 2, depth - frame_bottom_size, height], center = true);

      translate([0, depth / 2.0 - close_tip_offset, -height / 2.0 - 0.001])
        rotate([0, 0, 90])
        tip(tip_extrude = width - frame_side_size * 2);

    };

    translate([-width / 2.0 + frame_side_size / 2.0, 0, height / 2.0 - 0.001])
      tip(tip_size_difference = 0.2, tip_height_difference = 0.2, size_difference = 0.2);

    translate([width / 2.0 - frame_side_size / 2.0, 0, height / 2.0 - 0.001])
      tip(tip_size_difference = 0.2, tip_height_difference = 0.2, size_difference = 0.2);
  };
