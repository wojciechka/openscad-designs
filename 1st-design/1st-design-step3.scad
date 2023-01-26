$fa = 1;
$fs = 0.1;

difference() {
  union() {
    translate([0, 0, 9.999])
      resize([39.999, 39.999, 10])
      sphere(r = 20);
    cylinder(h = 20, r1 = 20, r2 = 20, center = true);
  };

  translate([0, 0, 12])
    cube([26, 26, 40], center = true);
};