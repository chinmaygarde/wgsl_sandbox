struct S {
  field0 : vec4<f32>,
  field1 : f32,
}

struct S_1 {
  field0 : mat4x4<f32>,
}

var<private> x_11 : vec2<f32>;

@group(0) @binding(1) var<uniform> x_16 : S;

@group(0) @binding(0) var<uniform> x_36 : S_1;

var<private> x_40 : vec2<f32>;

var<private> x_52 : vec4<f32>;

var<private> x_57 : f32;

var<private> x_59 : f32;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_12 : vec2<f32> = x_11;
  let x_21 : f32 = x_16.field1;
  let x_23 : f32 = (x_21 * 0.5);
  let x_39 : mat4x4<f32> = x_36.field0;
  let x_41 : vec2<f32> = x_40;
  let x_43 : vec2<f32> = (x_41 + (x_12 * vec2<f32>(x_23, x_23)));
  gl_Position = (x_39 * vec4<f32>(x_43.x, x_43.y, 0.0, 1.0));
  let x_55 : vec4<f32> = x_16.field0;
  x_52 = x_55;
  let x_60 : f32 = x_59;
  x_57 = x_60;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  x_52_1 : vec4<f32>,
  @location(1)
  x_57_1 : f32,
}

@stage(vertex)
fn main(@location(1) x_11_param : vec2<f32>, @location(0) x_40_param : vec2<f32>, @location(2) x_59_param : f32) -> main_out {
  x_11 = x_11_param;
  x_40 = x_40_param;
  x_59 = x_59_param;
  main_1();
  return main_out(gl_Position, x_52, x_57);
}
