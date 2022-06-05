var<private> frag_color : vec4<f32>;

var<private> stroke_color : vec4<f32>;

var<private> v_pen_down : f32;

fn main_1() {
  let x_12 : vec4<f32> = stroke_color;
  let x_15 : f32 = v_pen_down;
  frag_color = (x_12 * floor(x_15));
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) stroke_color_param : vec4<f32>, @location(1) v_pen_down_param : f32) -> main_out {
  stroke_color = stroke_color_param;
  v_pen_down = v_pen_down_param;
  main_1();
  return main_out(frag_color);
}
