struct S {
  field0 : vec2<f32>,
  field1 : vec2<f32>,
  field2 : vec4<f32>,
  field3 : vec4<f32>,
}

@group(0) @binding(0) var<uniform> x_13 : S;

var<private> x_26 : vec2<f32>;

var<private> x_44 : vec4<f32>;

fn main_1() {
  let x_18 : vec2<f32> = x_13.field1;
  let x_21 : vec2<f32> = x_13.field0;
  let x_22 : vec2<f32> = (x_18 - x_21);
  let x_23 : f32 = length(x_22);
  let x_27 : vec2<f32> = x_26;
  let x_42 : f32 = (dot((x_27 - x_21), x_22) / (x_23 * x_23));
  let x_48 : vec4<f32> = x_13.field2;
  let x_51 : vec4<f32> = x_13.field3;
  x_44 = mix(x_48, x_51, vec4<f32>(x_42, x_42, x_42, x_42));
  return;
}

struct main_out {
  @location(0)
  x_44_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_26_param : vec2<f32>) -> main_out {
  x_26 = x_26_param;
  main_1();
  return main_out(x_44);
}
