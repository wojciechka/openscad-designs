keychain_radius = 16;
bottom_height = 1.4;
border_height = 1.3;
border_radius = 1.2;
holder_outer_radius = 5.0;
holder_inner_radius = 2.5;
image_filename = "./influxdata-logo.svg";
image_width = 20;
image_height = 20;
image_embed = 1.0;
image_translate_x = -10.7;
image_translate_y = -17;
image_rotate = 0;

$fa = 2;
$fs = 0.2;

module KeychainBase() {
  union() {
    cylinder(h=bottom_height, r=keychain_radius);

    translate([0, 0, bottom_height])
      resize([keychain_radius * 2.0, keychain_radius * 2.0, border_height * 2.0])
      rotate_extrude(angle=360) {
        translate([keychain_radius - border_radius, 0, 0])
        circle(r = border_radius);
      };

    translate([0, keychain_radius + holder_inner_radius, 0])
      difference() {
        cylinder(h=bottom_height, r=holder_outer_radius);
        translate([0, 0, -bottom_height / 2.0])
        cylinder(h=bottom_height * 2.0, r=holder_inner_radius);
      };
  };
};

color([0.6, 0.6, 0.6])
  render()
  union() {
    KeychainBase();
    rotate([0, 0, image_rotate])
      translate([image_translate_x, image_translate_y, bottom_height - 0.01])
      resize([image_width, image_height, image_embed])
      linear_extrude(height = image_embed) {
        import(image_filename);
      };
  };
