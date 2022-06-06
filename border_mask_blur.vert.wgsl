struct S {
  field0 : mat4x4<f32>,
  field1 : vec2<f32>,
  field2 : f32,
  field3 : f32,
  field4 : f32,
}

@group(0) @binding(0) var<uniform> x_20 : S;

var<private> x_25 : vec2<f32>;

var<private> x_36 : vec2<f32>;

var<private> x_37 : vec2<f32>;

var<private> x_39 : vec2<f32>;

var<private> x_45 : f32;

var<private> x_50 : f32;

var<private> x_54 : f32;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_23 : mat4x4<f32> = x_20.field0;
  let x_26 : vec2<f32> = x_25;
  gl_Position = (x_23 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_38 : vec2<f32> = x_37;
  x_36 = x_38;
  let x_43 : vec2<f32> = x_20.field1;
  x_39 = x_43;
  let x_49 : f32 = x_20.field2;
  x_45 = x_49;
  let x_53 : f32 = x_20.field3;
  x_50 = x_53;
  let x_57 : f32 = x_20.field4;
  x_54 = x_57;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  x_36_1 : vec2<f32>,
  @location(1)
  x_39_1 : vec2<f32>,
  @location(2)
  x_45_1 : f32,
  @location(3)
  x_50_1 : f32,
  @location(4)
  x_54_1 : f32,
}

@stage(vertex)
fn main(@location(0) x_25_param : vec2<f32>, @location(1) x_37_param : vec2<f32>) -> main_out {
  x_25 = x_25_param;
  x_37 = x_37_param;
  main_1();
  return main_out(gl_Position, x_36, x_39, x_45, x_50, x_54);
}
