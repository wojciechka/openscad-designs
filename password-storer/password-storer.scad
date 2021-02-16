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
frame_size = 2.5;

// value of lines is sha256sum of /dev/null, divided into 3 lines

// calculate depth based number of lines
line_size = font_size * 1.2;
storer_depth = len(lines) * line_size + frame_size * 2.0;

triangle_height = (storer_depth - frame_size * 2.0) / 2.0;
storer_base_height = bottom_height + text_height;
storer_triangle_height = triangle_height + top_height;
storer_height = storer_base_height + storer_triangle_height;

module triangle_closure() {
  translate([0, 0, 0])
    rotate([90, 90, 90])
    linear_extrude(height = storer_width - frame_size * 2.0, center = true) {
      polygon([
        [0, -triangle_height],
        [-triangle_height, 0],
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

color([0.6, 0.6, 0.6, 0.4])
  render(convexity = 20)
  union() {
    translate([0, 0, storer_base_height / 2.0])
      difference() {
        cube([storer_width, storer_depth, storer_base_height], center=true);
        translate([0, 0, bottom_height])
          cube([storer_width - frame_size * 2.0, storer_depth - frame_size * 2.0, storer_base_height], center=true);
      };
    translate([0, (len(lines) - 1) * line_size / 2.0, storer_base_height - text_height / 2.0 - 0.01])
      print_lines();

    translate([0, 0, bottom_height + text_height + storer_triangle_height / 2.0 - 0.01])
    difference() {
      cube([storer_width, storer_depth, storer_triangle_height], center=true);
      translate([0, 0, - storer_triangle_height / 2.0  - 0.01])
        triangle_closure();
    };
  };
