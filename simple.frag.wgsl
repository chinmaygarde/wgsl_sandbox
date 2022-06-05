struct Hello {
  color : vec4<f32>,
}

var<private> frag_color : vec4<f32>;

@group(0) @binding(0) var<uniform> hello : Hello;

fn main_1() {
  let x_17 : vec4<f32> = hello.color;
  frag_color = x_17;
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main() -> main_out {
  main_1();
  return main_out(frag_color);
}
