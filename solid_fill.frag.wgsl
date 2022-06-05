var<private> frag_color : vec4<f32>;

var<private> color : vec4<f32>;

fn main_1() {
  let x_12 : vec4<f32> = color;
  frag_color = x_12;
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) color_param : vec4<f32>) -> main_out {
  color = color_param;
  main_1();
  return main_out(frag_color);
}
