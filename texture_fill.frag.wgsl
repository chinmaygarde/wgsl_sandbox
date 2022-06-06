struct S {
  field0 : f32,
}

var<private> x_11 : vec2<f32>;

@group(0) @binding(2) var<uniform> x_15 : S;

@group(0) @binding(0) var x_39 : texture_2d<f32>;

@group(0) @binding(1) var x_43 : sampler;

var<private> x_50 : vec4<f32>;

var<private> x_53 : f32;

fn main_1() {
  var x_58 : vec2<f32>;
  var x_59_phi : vec2<f32>;
  let x_12 : vec2<f32> = x_11;
  let x_20 : f32 = x_15.field0;
  x_59_phi = x_12;
  if ((x_20 < 0.0)) {
    x_58 = x_12;
    x_58.y = (1.0 - x_12.y);
    x_59_phi = x_58;
  }
  let x_59 : vec2<f32> = x_59_phi;
  let x_48 : vec4<f32> = textureSample(x_39, x_43, x_59);
  let x_54 : f32 = x_53;
  x_50 = (x_48 * x_54);
  return;
}

struct main_out {
  @location(0)
  x_50_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_11_param : vec2<f32>, @location(1) x_53_param : f32) -> main_out {
  x_11 = x_11_param;
  x_53 = x_53_param;
  main_1();
  return main_out(x_50);
}
