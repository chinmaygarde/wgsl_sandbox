struct FrameInfo {
  mvp : mat4x4<f32>,
  sigma_uv : vec2<f32>,
  src_factor : f32,
  inner_blur_factor : f32,
  outer_blur_factor : f32,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> vertices : vec2<f32>;

var<private> v_texture_coords : vec2<f32>;

var<private> texture_coords : vec2<f32>;

var<private> v_sigma_uv : vec2<f32>;

var<private> v_src_factor : f32;

var<private> v_inner_blur_factor : f32;

var<private> v_outer_blur_factor : f32;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_23 : mat4x4<f32> = frame_info.mvp;
  let x_26 : vec2<f32> = vertices;
  gl_Position = (x_23 * vec4<f32>(x_26.x, x_26.y, 0.0, 1.0));
  let x_38 : vec2<f32> = texture_coords;
  v_texture_coords = x_38;
  let x_43 : vec2<f32> = frame_info.sigma_uv;
  v_sigma_uv = x_43;
  let x_49 : f32 = frame_info.src_factor;
  v_src_factor = x_49;
  let x_53 : f32 = frame_info.inner_blur_factor;
  v_inner_blur_factor = x_53;
  let x_57 : f32 = frame_info.outer_blur_factor;
  v_outer_blur_factor = x_57;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  v_texture_coords_1 : vec2<f32>,
  @location(1)
  v_sigma_uv_1 : vec2<f32>,
  @location(2)
  v_src_factor_1 : f32,
  @location(3)
  v_inner_blur_factor_1 : f32,
  @location(4)
  v_outer_blur_factor_1 : f32,
}

@stage(vertex)
fn main(@location(0) vertices_param : vec2<f32>, @location(1) texture_coords_param : vec2<f32>) -> main_out {
  vertices = vertices_param;
  texture_coords = texture_coords_param;
  main_1();
  return main_out(gl_Position, v_texture_coords, v_sigma_uv, v_src_factor, v_inner_blur_factor, v_outer_blur_factor);
}
