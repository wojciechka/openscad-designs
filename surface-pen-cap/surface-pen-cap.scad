$fa = 2;
$fs = 0.1;

lid_slant_height = 0.8;
lid_slant_width = 0.6;
radius = 5.1;
minimal_radius = 1.0;
outer_radius = radius + 1.5;
end_radius = radius - 0.3;
end_radius_height = 0.6;
cutoff_offset = radius * 0.75;
height = 30;
tip_placeholder_size = 18;

tip_height = 1.6;

color([0.6, 0.6, 0.6, 0.4])
  render(convexity = 20)
  difference() {
    rotate_extrude(angle = 360) {
      polygon(points=[
        [0, height + tip_placeholder_size + tip_height],
        [outer_radius, height + tip_placeholder_size + tip_height],
        [outer_radius, lid_slant_height],
        [outer_radius - lid_slant_width, 0],
        [0, 0],
      ]);
    };

  translate([0, cutoff_offset + 0.001 - lid_slant_width, -0.001])
    rotate([0, -90, 0])
    linear_extrude(height = outer_radius * 2 + 0.1, center=true) {
      polygon(points=[
          [0, lid_slant_width],
          [lid_slant_height, lid_slant_width],
          [0, 0],
      ]);
    };

    translate([0, 0, tip_placeholder_size + tip_height + 0.001])
      rotate([180, 0, 0])
      rotate_extrude(angle = 360) {
        polygon(points=[
          [0, -height],
          [end_radius, -height],
          [radius, -height + end_radius_height],
          [radius, 0],
          [minimal_radius, tip_placeholder_size],
          [0, tip_placeholder_size],
          [0, -height],
        ]);
      };
    translate([-outer_radius - 0.1, cutoff_offset, -0.001])
      cube(size=[outer_radius * 2 + 0.2, outer_radius * 2 + 0.2, height + tip_placeholder_size + tip_height + 0.2]);
  };
