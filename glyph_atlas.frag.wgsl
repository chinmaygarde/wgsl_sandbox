var<private> v_atlas_glyph_size : vec2<f32>;

var<private> v_atlas_size : vec2<f32>;

var<private> v_atlas_position : vec2<f32>;

var<private> frag_color : vec4<f32>;

@group(0) @binding(0) var glyph_atlas_sampler : texture_2d<f32>;

@group(0) @binding(1) var glyph_atlas_sampler_smplr : sampler;

var<private> v_unit_vertex : vec2<f32>;

var<private> v_text_color : vec4<f32>;

fn main_1() {
  var scale_perspective : vec2<f32>;
  var offset_1 : vec2<f32>;
  let x_12 : vec2<f32> = v_atlas_glyph_size;
  let x_14 : vec2<f32> = v_atlas_size;
  scale_perspective = (x_12 / x_14);
  let x_18 : vec2<f32> = v_atlas_position;
  let x_19 : vec2<f32> = v_atlas_size;
  offset_1 = (x_18 / x_19);
  let x_35 : vec2<f32> = v_unit_vertex;
  let x_36 : vec2<f32> = scale_perspective;
  let x_38 : vec2<f32> = offset_1;
  let x_40 : vec4<f32> = textureSample(glyph_atlas_sampler, glyph_atlas_sampler_smplr, ((x_35 * x_36) + x_38));
  let x_44 : vec4<f32> = v_text_color;
  frag_color = (vec4<f32>(x_40.w, x_40.w, x_40.w, x_40.w) * x_44);
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(2) v_atlas_glyph_size_param : vec2<f32>, @location(3) v_atlas_size_param : vec2<f32>, @location(1) v_atlas_position_param : vec2<f32>, @location(0) v_unit_vertex_param : vec2<f32>, @location(4) v_text_color_param : vec4<f32>) -> main_out {
  v_atlas_glyph_size = v_atlas_glyph_size_param;
  v_atlas_size = v_atlas_size_param;
  v_atlas_position = v_atlas_position_param;
  v_unit_vertex = v_unit_vertex_param;
  v_text_color = v_text_color_param;
  main_1();
  return main_out(frag_color);
}
