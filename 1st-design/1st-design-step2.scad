$fa = 1;
$fs = 0.1;

difference() {
  cylinder(h = 20, r1 = 20, r2 = 20, center = true);

  translate([0, 0, 12])
    cube([26, 26, 40], center = true);
};