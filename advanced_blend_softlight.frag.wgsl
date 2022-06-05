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
  let x_136 : f32 = (*(color)).w;
  if ((x_136 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_143 : vec4<f32> = *(color);
  let x_146 : f32 = (*(color)).w;
  let x_148 : vec3<f32> = (vec3<f32>(x_143.x, x_143.y, x_143.z) / vec3<f32>(x_146, x_146, x_146));
  let x_150 : f32 = (*(color)).w;
  return vec4<f32>(x_148.x, x_148.y, x_148.z, x_150);
}

fn MixComponents_vf3_vf3_vf3_f1_(a : ptr<function, vec3<f32>>, b : ptr<function, vec3<f32>>, weight : ptr<function, vec3<f32>>, cutoff : ptr<function, f32>) -> vec3<f32> {
  let x_37 : f32 = (*(a)).x;
  let x_39 : f32 = (*(b)).x;
  let x_41 : f32 = (*(weight)).x;
  let x_42 : f32 = *(cutoff);
  let x_48 : f32 = (*(a)).y;
  let x_50 : f32 = (*(b)).y;
  let x_52 : f32 = (*(weight)).y;
  let x_53 : f32 = *(cutoff);
  let x_58 : f32 = (*(a)).z;
  let x_60 : f32 = (*(b)).z;
  let x_62 : f32 = (*(weight)).z;
  let x_63 : f32 = *(cutoff);
  return vec3<f32>(select(x_37, x_39, (x_41 > x_42)), select(x_48, x_50, (x_52 > x_53)), select(x_58, x_60, (x_62 > x_63)));
}

fn MixHalf_vf3_vf3_vf3_(a_1 : ptr<function, vec3<f32>>, b_1 : ptr<function, vec3<f32>>, weight_1 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param : vec3<f32>;
  var param_1 : vec3<f32>;
  var param_2 : vec3<f32>;
  var param_3 : f32;
  let x_71 : vec3<f32> = *(a_1);
  param = x_71;
  let x_73 : vec3<f32> = *(b_1);
  param_1 = x_73;
  let x_75 : vec3<f32> = *(weight_1);
  param_2 = x_75;
  param_3 = 0.5;
  let x_77 : vec3<f32> = MixComponents_vf3_vf3_vf3_f1_(&(param), &(param_1), &(param_2), &(param_3));
  return x_77;
}

fn Blend_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  var D : vec3<f32>;
  var param_4 : vec3<f32>;
  var param_5 : vec3<f32>;
  var param_6 : vec3<f32>;
  var param_7 : f32;
  var param_8 : vec3<f32>;
  var param_9 : vec3<f32>;
  var param_10 : vec3<f32>;
  let x_82 : vec3<f32> = *(dst);
  let x_87 : vec3<f32> = *(dst);
  let x_92 : vec3<f32> = *(dst);
  let x_94 : vec3<f32> = *(dst);
  param_4 = (((((x_82 * 16.0) - vec3<f32>(12.0, 12.0, 12.0)) * x_87) + vec3<f32>(4.0, 4.0, 4.0)) * x_92);
  param_5 = sqrt(x_94);
  let x_100 : vec3<f32> = *(dst);
  param_6 = x_100;
  param_7 = 0.25;
  let x_102 : vec3<f32> = MixComponents_vf3_vf3_vf3_f1_(&(param_4), &(param_5), &(param_6), &(param_7));
  D = x_102;
  let x_103 : vec3<f32> = *(dst);
  let x_106 : vec3<f32> = *(src);
  let x_110 : vec3<f32> = *(dst);
  let x_112 : vec3<f32> = *(dst);
  let x_117 : vec3<f32> = *(dst);
  let x_118 : vec3<f32> = *(src);
  let x_122 : vec3<f32> = D;
  let x_123 : vec3<f32> = *(dst);
  param_8 = (x_103 - (((vec3<f32>(1.0, 1.0, 1.0) - (x_106 * 2.0)) * x_110) * (vec3<f32>(1.0, 1.0, 1.0) - x_112)));
  param_9 = (x_117 + (((x_118 * 2.0) - vec3<f32>(1.0, 1.0, 1.0)) * (x_122 - x_123)));
  let x_130 : vec3<f32> = *(src);
  param_10 = x_130;
  let x_131 : vec3<f32> = MixHalf_vf3_vf3_vf3_(&(param_8), &(param_9), &(param_10));
  return x_131;
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param_11 : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_185 : vec4<f32>;
  var param_12 : vec4<f32>;
  var blended : vec3<f32>;
  var param_13 : vec3<f32>;
  var param_14 : vec3<f32>;
  let x_171 : vec2<f32> = v_dst_texture_coords;
  let x_172 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_171);
  param_11 = x_172;
  let x_174 : vec4<f32> = Unpremultiply_vf4_(&(param_11));
  dst_1 = x_174;
  let x_183 : f32 = blend_info.color_factor;
  if ((x_183 > 0.0)) {
    let x_191 : vec4<f32> = blend_info.color;
    x_185 = x_191;
  } else {
    let x_199 : vec2<f32> = v_src_texture_coords;
    let x_200 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_199);
    param_12 = x_200;
    let x_202 : vec4<f32> = Unpremultiply_vf4_(&(param_12));
    x_185 = x_202;
  }
  let x_203 : vec4<f32> = x_185;
  src_1 = x_203;
  let x_206 : vec4<f32> = dst_1;
  param_13 = vec3<f32>(x_206.x, x_206.y, x_206.z);
  let x_209 : vec4<f32> = src_1;
  param_14 = vec3<f32>(x_209.x, x_209.y, x_209.z);
  let x_211 : vec3<f32> = Blend_vf3_vf3_(&(param_13), &(param_14));
  blended = x_211;
  let x_214 : vec3<f32> = blended;
  let x_216 : f32 = src_1.w;
  let x_217 : vec3<f32> = (x_214 * x_216);
  let x_219 : f32 = src_1.w;
  frag_color = vec4<f32>(x_217.x, x_217.y, x_217.z, x_219);
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
