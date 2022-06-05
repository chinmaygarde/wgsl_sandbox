struct FrameInfo {
  mvp : mat4x4<f32>,
  color : vec4<f32>,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> vertices : vec2<f32>;

var<private> color : vec4<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_22 : mat4x4<f32> = frame_info.mvp;
  let x_26 : vec2<f32> = vertices;
  gl_Position = (x_22 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_39 : vec4<f32> = frame_info.color;
  color = x_39;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  color_1 : vec4<f32>,
}

@stage(vertex)
fn main(@location(0) vertices_param : vec2<f32>) -> main_out {
  vertices = vertices_param;
  main_1();
  return main_out(gl_Position, color);
}
