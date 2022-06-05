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
  let x_81 : f32 = (*(color)).w;
  if ((x_81 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_87 : vec4<f32> = *(color);
  let x_90 : f32 = (*(color)).w;
  let x_92 : vec3<f32> = (vec3<f32>(x_87.x, x_87.y, x_87.z) / vec3<f32>(x_90, x_90, x_90));
  let x_94 : f32 = (*(color)).w;
  return vec4<f32>(x_92.x, x_92.y, x_92.z, x_94);
}

fn ComponentIsValue_vf3_f1_(n : ptr<function, vec3<f32>>, value : ptr<function, f32>) -> vec3<f32> {
  var diff : vec3<f32>;
  let x_27 : vec3<f32> = *(n);
  let x_28 : f32 = *(value);
  diff = abs((x_27 - vec3<f32>(x_28, x_28, x_28)));
  let x_35 : f32 = diff.x;
  let x_44 : f32 = diff.y;
  let x_49 : f32 = diff.z;
  return vec3<f32>(select(0.0, 1.0, (x_35 < 0.0001)), select(0.0, 1.0, (x_44 < 0.0001)), select(0.0, 1.0, (x_49 < 0.0001)));
}

fn Blend_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  var color_1 : vec3<f32>;
  var param : vec3<f32>;
  var param_1 : f32;
  var param_2 : vec3<f32>;
  var param_3 : f32;
  let x_57 : vec3<f32> = *(dst);
  let x_58 : vec3<f32> = *(src);
  color_1 = min(vec3<f32>(1.0, 1.0, 1.0), (x_57 / (vec3<f32>(1.0, 1.0, 1.0) - x_58)));
  let x_63 : vec3<f32> = color_1;
  let x_66 : vec3<f32> = *(dst);
  param = x_66;
  param_1 = 0.0;
  let x_68 : vec3<f32> = ComponentIsValue_vf3_f1_(&(param), &(param_1));
  color_1 = mix(x_63, vec3<f32>(0.0, 0.0, 0.0), x_68);
  let x_70 : vec3<f32> = color_1;
  let x_72 : vec3<f32> = *(src);
  param_2 = x_72;
  param_3 = 1.0;
  let x_74 : vec3<f32> = ComponentIsValue_vf3_f1_(&(param_2), &(param_3));
  color_1 = mix(x_70, vec3<f32>(1.0, 1.0, 1.0), x_74);
  let x_76 : vec3<f32> = color_1;
  return x_76;
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param_4 : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_129 : vec4<f32>;
  var param_5 : vec4<f32>;
  var blended : vec3<f32>;
  var param_6 : vec3<f32>;
  var param_7 : vec3<f32>;
  let x_115 : vec2<f32> = v_dst_texture_coords;
  let x_116 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_115);
  param_4 = x_116;
  let x_118 : vec4<f32> = Unpremultiply_vf4_(&(param_4));
  dst_1 = x_118;
  let x_127 : f32 = blend_info.color_factor;
  if ((x_127 > 0.0)) {
    let x_135 : vec4<f32> = blend_info.color;
    x_129 = x_135;
  } else {
    let x_143 : vec2<f32> = v_src_texture_coords;
    let x_144 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_143);
    param_5 = x_144;
    let x_146 : vec4<f32> = Unpremultiply_vf4_(&(param_5));
    x_129 = x_146;
  }
  let x_147 : vec4<f32> = x_129;
  src_1 = x_147;
  let x_150 : vec4<f32> = dst_1;
  param_6 = vec3<f32>(x_150.x, x_150.y, x_150.z);
  let x_153 : vec4<f32> = src_1;
  param_7 = vec3<f32>(x_153.x, x_153.y, x_153.z);
  let x_155 : vec3<f32> = Blend_vf3_vf3_(&(param_6), &(param_7));
  blended = x_155;
  let x_158 : vec3<f32> = blended;
  let x_160 : f32 = src_1.w;
  let x_161 : vec3<f32> = (x_158 * x_160);
  let x_163 : f32 = src_1.w;
  frag_color = vec4<f32>(x_161.x, x_161.y, x_161.z, x_163);
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
