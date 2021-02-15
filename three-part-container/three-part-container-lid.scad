container_width = 85;
container_depth = 30;

title = "CONTAINER TITLE GOES HERE";
title_embed = 0.55;

inner_height = 1.32;
width_outer_size = 1.32;
depth_outer_size = 3.95;

width = 85 + 2.63 * 2 + width_outer_size * 2;
depth = container_depth / 2.0 * 2 + 2.63 * 2 + depth_outer_size * 2;
height = 5 + inner_height;

tip_size = 1.2;
tip_height = 0.6;
tip_extrude_size = 85 - 2.63 * 2;

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

color(c = [0.6, 0.6, 0.6])
  render()
  translate([0, 0, height / 2.0])
  rotate([0, 0, 90])
  union() {
    difference() {
      cube([width, depth, height], center = true);
      translate([0, 0, inner_height])
      cube([width - width_outer_size * 2, depth - depth_outer_size * 2, height], center = true);

      translate([0, -depth / 2.0, 0])
        rotate([90, 180, 0])
        linear_extrude(height = title_embed * 2.0, center = true) {
          text(title, font="Calibri", size = 5, halign="center", valign="center");
        };
    };

    translate([0, -depth / 2.0 + depth_outer_size - 0.01, -height / 2.0 + inner_height + close_tip_offset])
      rotate([0, 90, 90])
      tip();

    translate([0, depth / 2.0 - depth_outer_size + 0.01, -height / 2.0 + inner_height + close_tip_offset])
      rotate([0, 90, 270])
      tip();
  };

