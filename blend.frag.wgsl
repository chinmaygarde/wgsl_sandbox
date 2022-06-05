var<private> frag_color : vec4<f32>;

@group(0) @binding(0) var texture_sampler_src : texture_2d<f32>;

@group(0) @binding(1) var texture_sampler_src_smplr : sampler;

var<private> v_texture_coords : vec2<f32>;

fn main_1() {
  let x_23 : vec2<f32> = v_texture_coords;
  let x_24 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_23);
  frag_color = x_24;
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) v_texture_coords_param : vec2<f32>) -> main_out {
  v_texture_coords = v_texture_coords_param;
  main_1();
  return main_out(frag_color);
}
