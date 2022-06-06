var<private> x_9 : vec4<f32>;

@group(0) @binding(0) var x_12 : texture_2d<f32>;

@group(0) @binding(1) var x_16 : sampler;

var<private> x_22 : vec2<f32>;

fn main_1() {
  let x_23 : vec2<f32> = x_22;
  let x_24 : vec4<f32> = textureSample(x_12, x_16, x_23);
  x_9 = x_24;
  return;
}

struct main_out {
  @location(0)
  x_9_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_22_param : vec2<f32>) -> main_out {
  x_22 = x_22_param;
  main_1();
  return main_out(x_9);
}
