storer_width = 96;
lines = [
  "E3B0C44298FC1C149AFBF4",
  "C8996FB92427AE41E4649B",
  "934CA495991B7852B855",
];
font_name = "Arial Narrow";
font_size = 5.5;
text_height = 1.3;
bottom_height = 2.6;
top_height = 0.65;
frame_size = 1.4;
hole_depth = 0.6;
hole_height = 0.8;

keychain_height = bottom_height - 0.2;
keychain_outer_range = 6;
keychain_inner_range = 4;
keychain_offset = 1;

// value of lines is sha256sum of /dev/null, divided into 3 lines

// calculate depth based number of lines
line_size = font_size * 1.2;
storer_depth = len(lines) * line_size + frame_size * 2.0;

triangle_height = (storer_depth - frame_size * 2.0) / 2.0;
storer_base_height = bottom_height + text_height + hole_height;
storer_triangle_height = triangle_height + top_height;
storer_height = storer_base_height + storer_triangle_height;

module triangle_closure() {
  translate([0, 0, 0])
    rotate([90, 90, 90])
    linear_extrude(height = storer_width - frame_size * 2.0, center = true) {
      polygon([
        [0, -triangle_height],
        [-triangle_height - 0.1, 0],
        [0, triangle_height],
      ]);
    };
};

module print_lines() {
  union() {
    for (line = [0 : len(lines) - 1]) {
      translate([0, - line * line_size, 0])
        linear_extrude(height = text_height, center = true) {
          text(lines[line], font=font_name, size = font_size, halign="center", valign="center");
        };
    };
  };
}

module hole_helper(angle, height) {
  rotate([90, 0, angle])
  linear_extrude(height = height) {
    polygon(points=[
      [0, 0],
      [hole_depth, hole_height],
      [0, hole_height * 2],
    ]);
  }
}

color([0.6, 0.6, 0.6, 0.4])
  render(convexity = 200)
  difference() {
    union() {
      translate([0, 0, storer_base_height / 2.0])
        difference() {
          cube([storer_width, storer_depth, storer_base_height], center=true);
          translate([0, 0, bottom_height])
            cube([storer_width - frame_size * 2.0, storer_depth - frame_size * 2.0, storer_base_height], center=true);
        };
      translate([0, (len(lines) - 1) * line_size / 2.0, bottom_height + text_height / 2.0 - 0.01])
        print_lines();

      translate([0, 0, storer_base_height + storer_triangle_height / 2.0 - 0.01])
      difference() {
        cube([storer_width, storer_depth, storer_triangle_height], center=true);
        translate([0, 0, - storer_triangle_height / 2.0  - 0.01])
          triangle_closure();
      };

      translate([0, -storer_depth / 2 - keychain_offset, 0])
      difference() {
        cylinder(h=keychain_height, r=keychain_outer_range);
        translate([0, 0, -1])
        cylinder(h=keychain_height + 2, r=keychain_inner_range);
      };
    };

    // helpers for cutting the box open
    translate([-storer_width / 2 - 1, -storer_depth  / 2 - 0.001, bottom_height + text_height])
      hole_helper(90, storer_width + 2);
    translate([storer_width / 2 + 1, storer_depth  / 2 + 0.001, bottom_height + text_height])
      hole_helper(270, storer_width + 2);
    translate([-storer_width / 2 - 0.01, storer_depth  / 2 + 1, bottom_height + text_height])
      hole_helper(0, storer_depth + 2);
    translate([storer_width / 2 + 0.01, -storer_depth  / 2 - 1, bottom_height + text_height])
      hole_helper(180, storer_depth + 2);
  };
