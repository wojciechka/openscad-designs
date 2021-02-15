box_width = 100;
box_depth = 55;
box_height = 32;
middle_offset = 0;

module wall_with_x_pattern(width = 500, height = 250, depth = 2, border_size = undef, x_increment = 12, x_width = 1.65) {
  half_width = width / 2.0;
  half_height = height / 2.0;
  half_depth = depth / 2.0;
  half_x_width = x_width / 2.0;
  border_size = is_undef(border_size) ? depth : border_size;

  union() {
    difference() {
      cube(size=[width, height, depth], center=true);
      cube(size=[width - border_size * 2, height - border_size * 2, depth * 2], center=true);
    }
    for (i = [-height : x_increment : width]) {
      intersection() {
        cube(size=[width, height, depth], center=true);
        linear_extrude(height = depth * 2, center = true) {
          polygon(points=[
            [-half_width - half_x_width + i, -half_height],
            [-half_width - half_x_width + i + height, half_height],
            [-half_width - half_x_width + i + height + x_width, half_height],
            [-half_width - half_x_width + i + x_width, -half_height],
          ]);
          polygon(points=[
            [-half_width - half_x_width + i + height, -half_height],
            [-half_width - half_x_width + i, half_height],
            [-half_width - half_x_width + i + x_width, half_height],
            [-half_width - half_x_width + i + height + x_width, -half_height],
          ]);
        };
      };
    }
  };
}

z_base = 1;
wall_size = 0.66;

half_box_width = box_width / 2.0;
half_box_height = box_height / 2.0;
half_box_depth = box_depth / 2.0;
half_wall_size = wall_size / 2.0;

color(c = [0.6, 0.6, 0.6])
  render()
  union() {
    translate([0, 0, z_base])
      wall_with_x_pattern(width = box_width, height = box_depth);

    translate([0, -half_box_depth + half_wall_size, half_box_height])
      cube([box_width, wall_size, box_height], center=true);

    translate([0, middle_offset - half_wall_size, half_box_height])
      cube([box_width, wall_size, box_height], center=true);

    translate([0, half_box_depth - half_wall_size, half_box_height])
      cube([box_width, wall_size, box_height], center=true);

    translate([half_box_width - half_wall_size, 0, half_box_height])
      cube([wall_size, box_depth, box_height], center=true);

    translate([-half_box_width + half_wall_size, 0, half_box_height])
      cube([wall_size, box_depth, box_height], center=true);
  };
