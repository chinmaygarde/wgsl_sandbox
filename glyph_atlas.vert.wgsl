struct FrameInfo {
  mvp : mat4x4<f32>,
  atlas_size : vec2<f32>,
  @size(8)
  padding : u32,
  text_color : vec4<f32>,
}

@group(0) @binding(0) var<uniform> frame_info : FrameInfo;

var<private> glyph_position : vec2<f32>;

var<private> unit_vertex : vec2<f32>;

var<private> glyph_size : vec2<f32>;

var<private> v_unit_vertex : vec2<f32>;

var<private> v_atlas_position : vec2<f32>;

var<private> atlas_position : vec2<f32>;

var<private> v_atlas_glyph_size : vec2<f32>;

var<private> atlas_glyph_size : vec2<f32>;

var<private> v_atlas_size : vec2<f32>;

var<private> v_text_color : vec4<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  var translate : vec4<f32>;
  var translated_mvp : mat4x4<f32>;
  let x_19 : vec4<f32> = frame_info.mvp[0i];
  let x_26 : f32 = glyph_position.x;
  let x_30 : vec4<f32> = frame_info.mvp[1i];
  let x_33 : f32 = glyph_position.y;
  let x_38 : vec4<f32> = frame_info.mvp[3i];
  translate = (((x_19 * x_26) + (x_30 * x_33)) + x_38);
  let x_43 : vec4<f32> = frame_info.mvp[0i];
  let x_45 : vec4<f32> = frame_info.mvp[1i];
  let x_48 : vec4<f32> = frame_info.mvp[2i];
  let x_50 : vec4<f32> = translate;
  let x_51 : vec3<f32> = vec3<f32>(x_50.x, x_50.y, x_50.z);
  let x_55 : f32 = frame_info.mvp[3i].w;
  let x_59 : vec4<f32> = vec4<f32>(x_51.x, x_51.y, x_51.z, x_55);
  translated_mvp = mat4x4<f32>(vec4<f32>(x_43.x, x_43.y, x_43.z, x_43.w), vec4<f32>(x_45.x, x_45.y, x_45.z, x_45.w), vec4<f32>(x_48.x, x_48.y, x_48.z, x_48.w), vec4<f32>(x_59.x, x_59.y, x_59.z, x_59.w));
  let x_87 : mat4x4<f32> = translated_mvp;
  let x_90 : f32 = unit_vertex.x;
  let x_93 : f32 = glyph_size.x;
  let x_96 : f32 = unit_vertex.y;
  let x_98 : f32 = glyph_size.y;
  gl_Position = (x_87 * vec4<f32>((x_90 * x_93), (x_96 * x_98), 0.0, 1.0));
  let x_106 : vec2<f32> = unit_vertex;
  v_unit_vertex = x_106;
  let x_109 : vec2<f32> = atlas_position;
  v_atlas_position = x_109;
  let x_112 : vec2<f32> = atlas_glyph_size;
  v_atlas_glyph_size = x_112;
  let x_116 : vec2<f32> = frame_info.atlas_size;
  v_atlas_size = x_116;
  let x_119 : vec4<f32> = frame_info.text_color;
  v_text_color = x_119;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  v_unit_vertex_1 : vec2<f32>,
  @location(1)
  v_atlas_position_1 : vec2<f32>,
  @location(2)
  v_atlas_glyph_size_1 : vec2<f32>,
  @location(3)
  v_atlas_size_1 : vec2<f32>,
  @location(4)
  v_text_color_1 : vec4<f32>,
}

@stage(vertex)
fn main(@location(1) glyph_position_param : vec2<f32>, @location(0) unit_vertex_param : vec2<f32>, @location(2) glyph_size_param : vec2<f32>, @location(3) atlas_position_param : vec2<f32>, @location(4) atlas_glyph_size_param : vec2<f32>) -> main_out {
  glyph_position = glyph_position_param;
  unit_vertex = unit_vertex_param;
  glyph_size = glyph_size_param;
  atlas_position = atlas_position_param;
  atlas_glyph_size = atlas_glyph_size_param;
  main_1();
  return main_out(gl_Position, v_unit_vertex, v_atlas_position, v_atlas_glyph_size, v_atlas_size, v_text_color);
}
