struct FrameInfo {
  mvp : mat4x4<f32>,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> vertices : vec2<f32>;

var<private> v_dst_texture_coords : vec2<f32>;

var<private> dst_texture_coords : vec2<f32>;

var<private> v_src_texture_coords : vec2<f32>;

var<private> src_texture_coords : vec2<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_22 : mat4x4<f32> = frame_info.mvp;
  let x_26 : vec2<f32> = vertices;
  gl_Position = (x_22 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_38 : vec2<f32> = dst_texture_coords;
  v_dst_texture_coords = x_38;
  let x_41 : vec2<f32> = src_texture_coords;
  v_src_texture_coords = x_41;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  v_dst_texture_coords_1 : vec2<f32>,
  @location(1)
  v_src_texture_coords_1 : vec2<f32>,
}

@stage(vertex)
fn main(@location(0) vertices_param : vec2<f32>, @location(1) dst_texture_coords_param : vec2<f32>, @location(2) src_texture_coords_param : vec2<f32>) -> main_out {
  vertices = vertices_param;
  dst_texture_coords = dst_texture_coords_param;
  src_texture_coords = src_texture_coords_param;
  main_1();
  return main_out(gl_Position, v_dst_texture_coords, v_src_texture_coords);
}
