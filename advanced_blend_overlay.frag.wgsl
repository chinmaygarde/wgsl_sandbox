struct BlendInfo {
  color_factor : f32,
  @size(12)
  padding : u32,
  color : vec4<f32>,
}

@group(0) @binding(1) var texture_sampler_dst : texture_2d<f32>;

@group(0) @binding(2) var texture_sampler_dst_smplr : sampler;

var<private> v_dst_texture_coords : vec2<f32>;

@group(0) @binding(0) var<uniform> blend_info : BlendInfo;

@group(0) @binding(3) var texture_sampler_src : texture_2d<f32>;

@group(0) @binding(4) var texture_sampler_src_smplr : sampler;

var<private> v_src_texture_coords : vec2<f32>;

var<private> frag_color : vec4<f32>;

fn Unpremultiply_vf4_(color : ptr<function, vec4<f32>>) -> vec4<f32> {
  let x_127 : f32 = (*(color)).w;
  if ((x_127 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_134 : vec4<f32> = *(color);
  let x_137 : f32 = (*(color)).w;
  let x_139 : vec3<f32> = (vec3<f32>(x_134.x, x_134.y, x_134.z) / vec3<f32>(x_137, x_137, x_137));
  let x_141 : f32 = (*(color)).w;
  return vec4<f32>(x_139.x, x_139.y, x_139.z, x_141);
}

fn BlendScreen_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  let x_88 : vec3<f32> = *(dst);
  let x_89 : vec3<f32> = *(src);
  let x_91 : vec3<f32> = *(dst);
  let x_92 : vec3<f32> = *(src);
  return ((x_88 + x_89) - (x_91 * x_92));
}

fn MixComponents_vf3_vf3_vf3_f1_(a : ptr<function, vec3<f32>>, b : ptr<function, vec3<f32>>, weight : ptr<function, vec3<f32>>, cutoff : ptr<function, f32>) -> vec3<f32> {
  let x_45 : f32 = (*(a)).x;
  let x_47 : f32 = (*(b)).x;
  let x_49 : f32 = (*(weight)).x;
  let x_50 : f32 = *(cutoff);
  let x_56 : f32 = (*(a)).y;
  let x_58 : f32 = (*(b)).y;
  let x_60 : f32 = (*(weight)).y;
  let x_61 : f32 = *(cutoff);
  let x_66 : f32 = (*(a)).z;
  let x_68 : f32 = (*(b)).z;
  let x_70 : f32 = (*(weight)).z;
  let x_71 : f32 = *(cutoff);
  return vec3<f32>(select(x_45, x_47, (x_49 > x_50)), select(x_56, x_58, (x_60 > x_61)), select(x_66, x_68, (x_70 > x_71)));
}

fn MixHalf_vf3_vf3_vf3_(a_1 : ptr<function, vec3<f32>>, b_1 : ptr<function, vec3<f32>>, weight_1 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param : vec3<f32>;
  var param_1 : vec3<f32>;
  var param_2 : vec3<f32>;
  var param_3 : f32;
  let x_79 : vec3<f32> = *(a_1);
  param = x_79;
  let x_81 : vec3<f32> = *(b_1);
  param_1 = x_81;
  let x_83 : vec3<f32> = *(weight_1);
  param_2 = x_83;
  param_3 = 0.5;
  let x_85 : vec3<f32> = MixComponents_vf3_vf3_vf3_f1_(&(param), &(param_1), &(param_2), &(param_3));
  return x_85;
}

fn BlendHardLight_vf3_vf3_(dst_1 : ptr<function, vec3<f32>>, src_1 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param_4 : vec3<f32>;
  var param_5 : vec3<f32>;
  var param_6 : vec3<f32>;
  var param_7 : vec3<f32>;
  var param_8 : vec3<f32>;
  let x_97 : vec3<f32> = *(dst_1);
  let x_99 : vec3<f32> = *(src_1);
  let x_102 : vec3<f32> = *(src_1);
  let x_108 : vec3<f32> = *(dst_1);
  param_4 = x_108;
  param_5 = ((x_102 * 2.0) - vec3<f32>(1.0, 1.0, 1.0));
  let x_110 : vec3<f32> = BlendScreen_vf3_vf3_(&(param_4), &(param_5));
  param_6 = (x_97 * (x_99 * 2.0));
  param_7 = x_110;
  let x_114 : vec3<f32> = *(src_1);
  param_8 = x_114;
  let x_115 : vec3<f32> = MixHalf_vf3_vf3_vf3_(&(param_6), &(param_7), &(param_8));
  return x_115;
}

fn Blend_vf3_vf3_(dst_2 : ptr<function, vec3<f32>>, src_2 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param_9 : vec3<f32>;
  var param_10 : vec3<f32>;
  let x_119 : vec3<f32> = *(src_2);
  param_9 = x_119;
  let x_121 : vec3<f32> = *(dst_2);
  param_10 = x_121;
  let x_122 : vec3<f32> = BlendHardLight_vf3_vf3_(&(param_9), &(param_10));
  return x_122;
}

fn main_1() {
  var dst_3 : vec4<f32>;
  var param_11 : vec4<f32>;
  var src_3 : vec4<f32>;
  var x_176 : vec4<f32>;
  var param_12 : vec4<f32>;
  var blended : vec3<f32>;
  var param_13 : vec3<f32>;
  var param_14 : vec3<f32>;
  let x_162 : vec2<f32> = v_dst_texture_coords;
  let x_163 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_162);
  param_11 = x_163;
  let x_165 : vec4<f32> = Unpremultiply_vf4_(&(param_11));
  dst_3 = x_165;
  let x_174 : f32 = blend_info.color_factor;
  if ((x_174 > 0.0)) {
    let x_182 : vec4<f32> = blend_info.color;
    x_176 = x_182;
  } else {
    let x_190 : vec2<f32> = v_src_texture_coords;
    let x_191 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_190);
    param_12 = x_191;
    let x_193 : vec4<f32> = Unpremultiply_vf4_(&(param_12));
    x_176 = x_193;
  }
  let x_194 : vec4<f32> = x_176;
  src_3 = x_194;
  let x_197 : vec4<f32> = dst_3;
  param_13 = vec3<f32>(x_197.x, x_197.y, x_197.z);
  let x_200 : vec4<f32> = src_3;
  param_14 = vec3<f32>(x_200.x, x_200.y, x_200.z);
  let x_202 : vec3<f32> = Blend_vf3_vf3_(&(param_13), &(param_14));
  blended = x_202;
  let x_205 : vec3<f32> = blended;
  let x_207 : f32 = src_3.w;
  let x_208 : vec3<f32> = (x_205 * x_207);
  let x_210 : f32 = src_3.w;
  frag_color = vec4<f32>(x_208.x, x_208.y, x_208.z, x_210);
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) v_dst_texture_coords_param : vec2<f32>, @location(1) v_src_texture_coords_param : vec2<f32>) -> main_out {
  v_dst_texture_coords = v_dst_texture_coords_param;
  v_src_texture_coords = v_src_texture_coords_param;
  main_1();
  return main_out(frag_color);
}
