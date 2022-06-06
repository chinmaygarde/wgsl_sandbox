var<private> x_9 : vec4<f32>;

var<private> x_11 : vec4<f32>;

fn main_1() {
  let x_12 : vec4<f32> = x_11;
  x_9 = x_12;
  return;
}

struct main_out {
  @location(0)
  x_9_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_11_param : vec4<f32>) -> main_out {
  x_11 = x_11_param;
  main_1();
  return main_out(x_9);
}
