struct S {
  field0 : mat4x4<f32>,
  field1 : vec2<f32>,
  field2 : vec2<f32>,
  field3 : f32,
  field4 : f32,
  field5 : f32,
  field6 : f32,
  field7 : f32,
}

@group(0) @binding(0) var<uniform> x_20 : S;

var<private> x_25 : vec2<f32>;

var<private> x_36 : vec2<f32>;

var<private> x_37 : vec2<f32>;

var<private> x_39 : vec2<f32>;

var<private> x_40 : vec2<f32>;

var<private> x_42 : vec2<f32>;

var<private> x_47 : vec2<f32>;

var<private> x_52 : f32;

var<private> x_57 : f32;

var<private> x_61 : f32;

var<private> x_65 : f32;

var<private> x_69 : f32;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_23 : mat4x4<f32> = x_20.field0;
  let x_26 : vec2<f32> = x_25;
  gl_Position = (x_23 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_38 : vec2<f32> = x_37;
  x_36 = x_38;
  let x_41 : vec2<f32> = x_40;
  x_39 = x_41;
  let x_46 : vec2<f32> = x_20.field1;
  x_42 = x_46;
  let x_50 : vec2<f32> = x_20.field2;
  x_47 = x_50;
  let x_56 : f32 = x_20.field3;
  x_52 = x_56;
  let x_60 : f32 = x_20.field4;
  x_57 = x_60;
  let x_64 : f32 = x_20.field5;
  x_61 = x_64;
  let x_68 : f32 = x_20.field6;
  x_65 = x_68;
  let x_72 : f32 = x_20.field7;
  x_69 = x_72;
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
  x_42_1 : vec2<f32>,
  @location(3)
  x_47_1 : vec2<f32>,
  @location(4)
  x_52_1 : f32,
  @location(5)
  x_57_1 : f32,
  @location(6)
  x_61_1 : f32,
  @location(7)
  x_65_1 : f32,
  @location(8)
  x_69_1 : f32,
}

@stage(vertex)
fn main(@location(0) x_25_param : vec2<f32>, @location(1) x_37_param : vec2<f32>, @location(2) x_40_param : vec2<f32>) -> main_out {
  x_25 = x_25_param;
  x_37 = x_37_param;
  x_40 = x_40_param;
  main_1();
  return main_out(gl_Position, x_36, x_39, x_42, x_47, x_52, x_57, x_61, x_65, x_69);
}
