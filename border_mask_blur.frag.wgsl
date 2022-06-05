var<private> v_sigma_uv : vec2<f32>;

@group(0) @binding(0) var texture_sampler : texture_2d<f32>;

@group(0) @binding(1) var texture_sampler_smplr : sampler;

var<private> v_texture_coords : vec2<f32>;

var<private> v_inner_blur_factor : f32;

var<private> v_src_factor : f32;

var<private> v_outer_blur_factor : f32;

var<private> frag_color : vec4<f32>;

fn erf_f1_(x : ptr<function, f32>) -> f32 {
  var a : f32;
  var b : f32;
  let x_24 : f32 = *(x);
  a = abs(x_24);
  let x_30 : f32 = a;
  let x_32 : f32 = a;
  let x_35 : f32 = a;
  let x_38 : f32 = a;
  b = (((0.278393 + ((0.230388999 + ((0.078107998 * x_30) * x_32)) * x_35)) * x_38) + 1.0);
  let x_42 : f32 = *(x);
  let x_44 : f32 = b;
  let x_45 : f32 = b;
  let x_47 : f32 = b;
  let x_49 : f32 = b;
  return (sign(x_42) * (1.0 - (1.0 / (((x_44 * x_45) * x_47) * x_49))));
}

fn GaussianIntegral_f1_f1_(x_1 : ptr<function, f32>, sigma : ptr<function, f32>) -> f32 {
  var param : f32;
  let x_57 : f32 = *(x_1);
  let x_59 : f32 = *(sigma);
  param = (x_57 * (0.707106769 / x_59));
  let x_63 : f32 = erf_f1_(&(param));
  return ((0.535000026 * x_63) + 0.465000004);
}

fn BoxBlurMask_vf2_(uv : ptr<function, vec2<f32>>) -> f32 {
  var param_1 : f32;
  var param_2 : f32;
  var param_3 : f32;
  var param_4 : f32;
  var param_5 : f32;
  var param_6 : f32;
  var param_7 : f32;
  var param_8 : f32;
  let x_75 : f32 = (*(uv)).x;
  param_1 = x_75;
  let x_79 : f32 = v_sigma_uv.x;
  param_2 = x_79;
  let x_80 : f32 = GaussianIntegral_f1_f1_(&(param_1), &(param_2));
  let x_84 : f32 = (*(uv)).y;
  param_3 = x_84;
  let x_87 : f32 = v_sigma_uv.y;
  param_4 = x_87;
  let x_88 : f32 = GaussianIntegral_f1_f1_(&(param_3), &(param_4));
  let x_91 : f32 = (*(uv)).x;
  param_5 = (1.0 - x_91);
  let x_96 : f32 = v_sigma_uv.x;
  param_6 = x_96;
  let x_97 : f32 = GaussianIntegral_f1_f1_(&(param_5), &(param_6));
  let x_100 : f32 = (*(uv)).y;
  param_7 = (1.0 - x_100);
  let x_105 : f32 = v_sigma_uv.y;
  param_8 = x_105;
  let x_106 : f32 = GaussianIntegral_f1_f1_(&(param_7), &(param_8));
  return (((x_80 * x_88) * x_97) * x_106);
}

fn main_1() {
  var image_color : vec4<f32>;
  var blur_factor : f32;
  var param_9 : vec2<f32>;
  var within_bounds : f32;
  var inner_factor : f32;
  var outer_factor : f32;
  var mask_factor : f32;
  var x_140 : bool;
  var x_146 : bool;
  var x_152 : bool;
  var x_141_phi : bool;
  var x_147_phi : bool;
  var x_153_phi : bool;
  let x_124 : vec2<f32> = v_texture_coords;
  let x_125 : vec4<f32> = textureSample(texture_sampler, texture_sampler_smplr, x_124);
  image_color = x_125;
  let x_128 : vec2<f32> = v_texture_coords;
  param_9 = x_128;
  let x_129 : f32 = BoxBlurMask_vf2_(&(param_9));
  blur_factor = x_129;
  let x_133 : f32 = v_texture_coords.x;
  let x_135 : bool = (x_133 >= 0.0);
  x_141_phi = x_135;
  if (x_135) {
    let x_139 : f32 = v_texture_coords.y;
    x_140 = (x_139 >= 0.0);
    x_141_phi = x_140;
  }
  let x_141 : bool = x_141_phi;
  x_147_phi = x_141;
  if (x_141) {
    let x_145 : f32 = v_texture_coords.x;
    x_146 = (x_145 < 1.0);
    x_147_phi = x_146;
  }
  let x_147 : bool = x_147_phi;
  x_153_phi = x_147;
  if (x_147) {
    let x_151 : f32 = v_texture_coords.y;
    x_152 = (x_151 < 1.0);
    x_153_phi = x_152;
  }
  let x_153 : bool = x_153_phi;
  within_bounds = select(0.0, 1.0, x_153);
  let x_157 : f32 = v_inner_blur_factor;
  let x_158 : f32 = blur_factor;
  let x_161 : f32 = v_src_factor;
  let x_163 : f32 = within_bounds;
  inner_factor = (((x_157 * x_158) + x_161) * x_163);
  let x_167 : f32 = v_outer_blur_factor;
  let x_168 : f32 = blur_factor;
  let x_170 : f32 = within_bounds;
  outer_factor = ((x_167 * x_168) * (1.0 - x_170));
  let x_174 : f32 = inner_factor;
  let x_175 : f32 = outer_factor;
  mask_factor = (x_174 + x_175);
  let x_179 : vec4<f32> = image_color;
  let x_180 : f32 = mask_factor;
  frag_color = (x_179 * x_180);
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(1) v_sigma_uv_param : vec2<f32>, @location(0) v_texture_coords_param : vec2<f32>, @location(3) v_inner_blur_factor_param : f32, @location(2) v_src_factor_param : f32, @location(4) v_outer_blur_factor_param : f32) -> main_out {
  v_sigma_uv = v_sigma_uv_param;
  v_texture_coords = v_texture_coords_param;
  v_inner_blur_factor = v_inner_blur_factor_param;
  v_src_factor = v_src_factor_param;
  v_outer_blur_factor = v_outer_blur_factor_param;
  main_1();
  return main_out(frag_color);
}
