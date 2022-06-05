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
  let x_35 : f32 = (*(color)).w;
  if ((x_35 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_43 : vec4<f32> = *(color);
  let x_46 : f32 = (*(color)).w;
  let x_48 : vec3<f32> = (vec3<f32>(x_43.x, x_43.y, x_43.z) / vec3<f32>(x_46, x_46, x_46));
  let x_50 : f32 = (*(color)).w;
  return vec4<f32>(x_48.x, x_48.y, x_48.z, x_50);
}

fn Blend_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  let x_20 : vec3<f32> = *(dst);
  let x_21 : vec3<f32> = *(src);
  let x_24 : vec3<f32> = *(dst);
  let x_26 : vec3<f32> = *(src);
  return ((x_20 + x_21) - ((x_24 * 2.0) * x_26));
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_85 : vec4<f32>;
  var param_1 : vec4<f32>;
  var blended : vec3<f32>;
  var param_2 : vec3<f32>;
  var param_3 : vec3<f32>;
  let x_71 : vec2<f32> = v_dst_texture_coords;
  let x_72 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_71);
  param = x_72;
  let x_74 : vec4<f32> = Unpremultiply_vf4_(&(param));
  dst_1 = x_74;
  let x_83 : f32 = blend_info.color_factor;
  if ((x_83 > 0.0)) {
    let x_91 : vec4<f32> = blend_info.color;
    x_85 = x_91;
  } else {
    let x_99 : vec2<f32> = v_src_texture_coords;
    let x_100 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_99);
    param_1 = x_100;
    let x_102 : vec4<f32> = Unpremultiply_vf4_(&(param_1));
    x_85 = x_102;
  }
  let x_103 : vec4<f32> = x_85;
  src_1 = x_103;
  let x_106 : vec4<f32> = dst_1;
  param_2 = vec3<f32>(x_106.x, x_106.y, x_106.z);
  let x_109 : vec4<f32> = src_1;
  param_3 = vec3<f32>(x_109.x, x_109.y, x_109.z);
  let x_111 : vec3<f32> = Blend_vf3_vf3_(&(param_2), &(param_3));
  blended = x_111;
  let x_114 : vec3<f32> = blended;
  let x_116 : f32 = src_1.w;
  let x_117 : vec3<f32> = (x_114 * x_116);
  let x_119 : f32 = src_1.w;
  frag_color = vec4<f32>(x_117.x, x_117.y, x_117.z, x_119);
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
