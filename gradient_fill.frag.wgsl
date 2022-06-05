struct GradientInfo {
  start_point : vec2<f32>,
  end_point : vec2<f32>,
  start_color : vec4<f32>,
  end_color : vec4<f32>,
}

@group(0) @binding(0) var<uniform> gradient_info : GradientInfo;

var<private> interpolated_vertices : vec2<f32>;

var<private> frag_color : vec4<f32>;

fn main_1() {
  var len : f32;
  var dot_v : f32;
  var interp : f32;
  let x_18 : vec2<f32> = gradient_info.end_point;
  let x_21 : vec2<f32> = gradient_info.start_point;
  len = length((x_18 - x_21));
  let x_27 : vec2<f32> = interpolated_vertices;
  let x_29 : vec2<f32> = gradient_info.start_point;
  let x_32 : vec2<f32> = gradient_info.end_point;
  let x_34 : vec2<f32> = gradient_info.start_point;
  dot_v = dot((x_27 - x_29), (x_32 - x_34));
  let x_38 : f32 = dot_v;
  let x_39 : f32 = len;
  let x_40 : f32 = len;
  interp = (x_38 / (x_39 * x_40));
  let x_48 : vec4<f32> = gradient_info.start_color;
  let x_51 : vec4<f32> = gradient_info.end_color;
  let x_52 : f32 = interp;
  frag_color = mix(x_48, x_51, vec4<f32>(x_52, x_52, x_52, x_52));
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) interpolated_vertices_param : vec2<f32>) -> main_out {
  interpolated_vertices = interpolated_vertices_param;
  main_1();
  return main_out(frag_color);
}
