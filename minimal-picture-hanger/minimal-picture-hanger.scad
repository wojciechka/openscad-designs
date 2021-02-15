// increase how smooth the output files are
$fa = 0.1;
$fs = 0.02;

// basic parameters of the object - width, height, depth define size of the base
width = 20;
height = 40;
depth = 3;

// paramaters for the hanger itself
hanger_offset = 4.0;
hanger_diameter = 1.8;
hanger_length = 2.5;
hanger_length2 = 1;
hanger_height = 6.5;
hanger_length_cosine = 10;

module hanger_lower_ending(size=[1,1,1]) {
  resize(size)
  union() {
    translate([0, -1.733 / 2.0, 1])
      intersection() {
        difference() {
          translate([0, 1.733 / 2.0, -0.5])
            cube([1, 1.733, 1], center=true);
          rotate([0, 90, 0])
            cylinder(h=2, r = 1, center=true);
        };
        union() {
          translate([0, 0, -0.5])
            cube([1, 1.733, 1], center=true);
          translate([0, 1.733, -1])
              rotate([0, 90, 0])
                cylinder(h=2, r = 1, center=true);
        };
      };
    };
};

color(c = [0.6, 0.6, 0.6])
  render()
  translate([0, 0, depth / 2.0])
  union() {
    cube([width, height, depth], center=true);

    translate([0, height / 2.0 - hanger_offset - (hanger_length2 + hanger_length) - hanger_length_cosine / 2.0, depth / 2.0])
      hanger_lower_ending(size=[hanger_diameter, hanger_length_cosine, hanger_height]);
  
    difference() {
    translate([0, height / 2.0 - hanger_offset - (hanger_length2 + hanger_length), depth / 2])
      rotate([90, 0, 270])
      linear_extrude(height = hanger_diameter, center=true) {
        polygon([
          [0, 0],
          [-hanger_length2 - hanger_length / 2.0, 0],
          [-hanger_length2 - hanger_length / 2.0, hanger_height - hanger_diameter],
          [-hanger_length2 - hanger_length, hanger_height - hanger_diameter],
          [-hanger_length2 - hanger_length, hanger_height],
          [0, hanger_height]
        ]);
      };

      translate([0, height / 2.0 - hanger_offset - hanger_length / 2.0, depth / 2.0 + (hanger_height - hanger_diameter) * 0.45])
        rotate([90, 0, 270])
        resize([hanger_length, (hanger_height - hanger_diameter) * 1.1, width])
        cylinder(h= 1, r = 1, center=true);
    };
  };
