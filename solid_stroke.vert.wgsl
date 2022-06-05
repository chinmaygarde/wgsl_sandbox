struct StrokeInfo {
  color : vec4<f32>,
  size : f32,
}

struct FrameInfo {
  mvp : mat4x4<f32>,
}

var<private> vertex_normal : vec2<f32>;

@group(0) @binding(1) var<uniform> stroke_info : StrokeInfo;

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> vertex_position : vec2<f32>;

var<private> stroke_color : vec4<f32>;

var<private> v_pen_down : f32;

var<private> pen_down : f32;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  var offset_1 : vec2<f32>;
  let x_12 : vec2<f32> = vertex_normal;
  let x_21 : f32 = stroke_info.size;
  let x_23 : f32 = (x_21 * 0.5);
  offset_1 = (x_12 * vec2<f32>(x_23, x_23));
  let x_39 : mat4x4<f32> = frame_info.mvp;
  let x_41 : vec2<f32> = vertex_position;
  let x_42 : vec2<f32> = offset_1;
  let x_43 : vec2<f32> = (x_41 + x_42);
  gl_Position = (x_39 * vec4<f32>(x_43.x, x_43.y, 0.0, 1.0));
  let x_55 : vec4<f32> = stroke_info.color;
  stroke_color = x_55;
  let x_60 : f32 = pen_down;
  v_pen_down = x_60;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  stroke_color_1 : vec4<f32>,
  @location(1)
  v_pen_down_1 : f32,
}

@stage(vertex)
fn main(@location(1) vertex_normal_param : vec2<f32>, @location(0) vertex_position_param : vec2<f32>, @location(2) pen_down_param : f32) -> main_out {
  vertex_normal = vertex_normal_param;
  vertex_position = vertex_position_param;
  pen_down = pen_down_param;
  main_1();
  return main_out(gl_Position, stroke_color, v_pen_down);
}
