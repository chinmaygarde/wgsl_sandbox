struct S {
  field0 : mat4x4<f32>,
  field1 : vec4<f32>,
}

@group(0) @binding(0) var<uniform> x_19 : S;

var<private> x_25 : vec2<f32>;

var<private> x_35 : vec4<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_22 : mat4x4<f32> = x_19.field0;
  let x_26 : vec2<f32> = x_25;
  gl_Position = (x_22 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_39 : vec4<f32> = x_19.field1;
  x_35 = x_39;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  x_35_1 : vec4<f32>,
}

@stage(vertex)
fn main(@location(0) x_25_param : vec2<f32>) -> main_out {
  x_25 = x_25_param;
  main_1();
  return main_out(gl_Position, x_35);
}
