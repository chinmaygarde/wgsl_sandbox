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
  let x_30 : f32 = (*(color)).w;
  if ((x_30 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_38 : vec4<f32> = *(color);
  let x_41 : f32 = (*(color)).w;
  let x_43 : vec3<f32> = (vec3<f32>(x_38.x, x_38.y, x_38.z) / vec3<f32>(x_41, x_41, x_41));
  let x_45 : f32 = (*(color)).w;
  return vec4<f32>(x_43.x, x_43.y, x_43.z, x_45);
}

fn Blend_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  let x_20 : vec3<f32> = *(dst);
  let x_21 : vec3<f32> = *(src);
  return abs((x_20 - x_21));
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_80 : vec4<f32>;
  var param_1 : vec4<f32>;
  var blended : vec3<f32>;
  var param_2 : vec3<f32>;
  var param_3 : vec3<f32>;
  let x_66 : vec2<f32> = v_dst_texture_coords;
  let x_67 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_66);
  param = x_67;
  let x_69 : vec4<f32> = Unpremultiply_vf4_(&(param));
  dst_1 = x_69;
  let x_78 : f32 = blend_info.color_factor;
  if ((x_78 > 0.0)) {
    let x_86 : vec4<f32> = blend_info.color;
    x_80 = x_86;
  } else {
    let x_94 : vec2<f32> = v_src_texture_coords;
    let x_95 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_94);
    param_1 = x_95;
    let x_97 : vec4<f32> = Unpremultiply_vf4_(&(param_1));
    x_80 = x_97;
  }
  let x_98 : vec4<f32> = x_80;
  src_1 = x_98;
  let x_101 : vec4<f32> = dst_1;
  param_2 = vec3<f32>(x_101.x, x_101.y, x_101.z);
  let x_104 : vec4<f32> = src_1;
  param_3 = vec3<f32>(x_104.x, x_104.y, x_104.z);
  let x_106 : vec3<f32> = Blend_vf3_vf3_(&(param_2), &(param_3));
  blended = x_106;
  let x_109 : vec3<f32> = blended;
  let x_111 : f32 = src_1.w;
  let x_112 : vec3<f32> = (x_109 * x_111);
  let x_114 : f32 = src_1.w;
  frag_color = vec4<f32>(x_112.x, x_112.y, x_112.z, x_114);
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
