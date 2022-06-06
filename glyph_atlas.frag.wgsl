var<private> x_11 : vec2<f32>;

var<private> x_13 : vec2<f32>;

var<private> x_17 : vec2<f32>;

var<private> x_23 : vec4<f32>;

@group(0) @binding(0) var x_26 : texture_2d<f32>;

@group(0) @binding(1) var x_30 : sampler;

var<private> x_34 : vec2<f32>;

var<private> x_43 : vec4<f32>;

fn main_1() {
  let x_12 : vec2<f32> = x_11;
  let x_14 : vec2<f32> = x_13;
  let x_18 : vec2<f32> = x_17;
  let x_35 : vec2<f32> = x_34;
  let x_40 : vec4<f32> = textureSample(x_26, x_30, ((x_35 * (x_12 / x_14)) + (x_18 / x_14)));
  let x_44 : vec4<f32> = x_43;
  x_23 = (vec4<f32>(x_40.w, x_40.w, x_40.w, x_40.w) * x_44);
  return;
}

struct main_out {
  @location(0)
  x_23_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(2) x_11_param : vec2<f32>, @location(3) x_13_param : vec2<f32>, @location(1) x_17_param : vec2<f32>, @location(0) x_34_param : vec2<f32>, @location(4) x_43_param : vec4<f32>) -> main_out {
  x_11 = x_11_param;
  x_13 = x_13_param;
  x_17 = x_17_param;
  x_34 = x_34_param;
  x_43 = x_43_param;
  main_1();
  return main_out(x_23);
}
