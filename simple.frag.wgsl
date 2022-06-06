struct S {
  field0 : vec4<f32>,
}

var<private> x_9 : vec4<f32>;

@group(0) @binding(0) var<uniform> x_12 : S;

fn main_1() {
  let x_17 : vec4<f32> = x_12.field0;
  x_9 = x_17;
  return;
}

struct main_out {
  @location(0)
  x_9_1 : vec4<f32>,
}

@stage(fragment)
fn main() -> main_out {
  main_1();
  return main_out(x_9);
}
