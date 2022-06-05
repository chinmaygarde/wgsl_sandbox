struct FrameInfo {
  mvp : mat4x4<f32>,
  texture_size : vec2<f32>,
  blur_direction : vec2<f32>,
  blur_sigma : f32,
  blur_radius : f32,
  src_factor : f32,
  inner_blur_factor : f32,
  outer_blur_factor : f32,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> vertices : vec2<f32>;

var<private> v_texture_coords : vec2<f32>;

var<private> texture_coords : vec2<f32>;

var<private> v_src_texture_coords : vec2<f32>;

var<private> src_texture_coords : vec2<f32>;

var<private> v_texture_size : vec2<f32>;

var<private> v_blur_direction : vec2<f32>;

var<private> v_blur_sigma : f32;

var<private> v_blur_radius : f32;

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
  let x_41 : vec2<f32> = src_texture_coords;
  v_src_texture_coords = x_41;
  let x_46 : vec2<f32> = frame_info.texture_size;
  v_texture_size = x_46;
  let x_50 : vec2<f32> = frame_info.blur_direction;
  v_blur_direction = x_50;
  let x_56 : f32 = frame_info.blur_sigma;
  v_blur_sigma = x_56;
  let x_60 : f32 = frame_info.blur_radius;
  v_blur_radius = x_60;
  let x_64 : f32 = frame_info.src_factor;
  v_src_factor = x_64;
  let x_68 : f32 = frame_info.inner_blur_factor;
  v_inner_blur_factor = x_68;
  let x_72 : f32 = frame_info.outer_blur_factor;
  v_outer_blur_factor = x_72;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  v_texture_coords_1 : vec2<f32>,
  @location(1)
  v_src_texture_coords_1 : vec2<f32>,
  @location(2)
  v_texture_size_1 : vec2<f32>,
  @location(3)
  v_blur_direction_1 : vec2<f32>,
  @location(4)
  v_blur_sigma_1 : f32,
  @location(5)
  v_blur_radius_1 : f32,
  @location(6)
  v_src_factor_1 : f32,
  @location(7)
  v_inner_blur_factor_1 : f32,
  @location(8)
  v_outer_blur_factor_1 : f32,
}

@stage(vertex)
fn main(@location(0) vertices_param : vec2<f32>, @location(1) texture_coords_param : vec2<f32>, @location(2) src_texture_coords_param : vec2<f32>) -> main_out {
  vertices = vertices_param;
  texture_coords = texture_coords_param;
  src_texture_coords = src_texture_coords_param;
  main_1();
  return main_out(gl_Position, v_texture_coords, v_src_texture_coords, v_texture_size, v_blur_direction, v_blur_sigma, v_blur_radius, v_src_factor, v_inner_blur_factor, v_outer_blur_factor);
}
