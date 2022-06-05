struct FrameInfo {
  mvp : mat4x4<f32>,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> point : vec2<f32>;

var<private> color : vec4<f32>;

var<private> vertex_color : vec4<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_22 : mat4x4<f32> = frame_info.mvp;
  let x_26 : vec2<f32> = point;
  gl_Position = (x_22 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_38 : vec4<f32> = vertex_color;
  color = x_38;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  color_1 : vec4<f32>,
}

@stage(vertex)
fn main(@location(0) point_param : vec2<f32>, @location(1) vertex_color_param : vec4<f32>) -> main_out {
  point = point_param;
  vertex_color = vertex_color_param;
  main_1();
  return main_out(gl_Position, color);
}
