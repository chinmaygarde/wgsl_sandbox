struct FragInfo {
  texture_sampler_y_coord_scale : f32,
}

var<private> v_texture_coords : vec2<f32>;

@group(0) @binding(2) var<uniform> frag_info : FragInfo;

@group(0) @binding(0) var texture_sampler : texture_2d<f32>;

@group(0) @binding(1) var texture_sampler_smplr : sampler;

var<private> frag_color : vec4<f32>;

var<private> v_alpha : f32;

fn main_1() {
  var coords : vec2<f32>;
  var sampled : vec4<f32>;
  let x_12 : vec2<f32> = v_texture_coords;
  coords = x_12;
  let x_20 : f32 = frag_info.texture_sampler_y_coord_scale;
  if ((x_20 < 0.0)) {
    let x_31 : f32 = coords.y;
    coords.y = (1.0 - x_31);
  }
  let x_47 : vec2<f32> = coords;
  let x_48 : vec4<f32> = textureSample(texture_sampler, texture_sampler_smplr, x_47);
  sampled = x_48;
  let x_51 : vec4<f32> = sampled;
  let x_54 : f32 = v_alpha;
  frag_color = (x_51 * x_54);
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) v_texture_coords_param : vec2<f32>, @location(1) v_alpha_param : f32) -> main_out {
  v_texture_coords = v_texture_coords_param;
  v_alpha = v_alpha_param;
  main_1();
  return main_out(frag_color);
}
