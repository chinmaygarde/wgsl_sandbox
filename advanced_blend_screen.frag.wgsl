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
  let x_44 : f32 = (*(color)).w;
  if ((x_44 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_52 : vec4<f32> = *(color);
  let x_55 : f32 = (*(color)).w;
  let x_57 : vec3<f32> = (vec3<f32>(x_52.x, x_52.y, x_52.z) / vec3<f32>(x_55, x_55, x_55));
  let x_59 : f32 = (*(color)).w;
  return vec4<f32>(x_57.x, x_57.y, x_57.z, x_59);
}

fn BlendScreen_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  let x_24 : vec3<f32> = *(dst);
  let x_25 : vec3<f32> = *(src);
  let x_27 : vec3<f32> = *(dst);
  let x_28 : vec3<f32> = *(src);
  return ((x_24 + x_25) - (x_27 * x_28));
}

fn Blend_vf3_vf3_(dst_1 : ptr<function, vec3<f32>>, src_1 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param : vec3<f32>;
  var param_1 : vec3<f32>;
  let x_34 : vec3<f32> = *(dst_1);
  param = x_34;
  let x_36 : vec3<f32> = *(src_1);
  param_1 = x_36;
  let x_37 : vec3<f32> = BlendScreen_vf3_vf3_(&(param), &(param_1));
  return x_37;
}

fn main_1() {
  var dst_2 : vec4<f32>;
  var param_2 : vec4<f32>;
  var src_2 : vec4<f32>;
  var x_94 : vec4<f32>;
  var param_3 : vec4<f32>;
  var blended : vec3<f32>;
  var param_4 : vec3<f32>;
  var param_5 : vec3<f32>;
  let x_80 : vec2<f32> = v_dst_texture_coords;
  let x_81 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_80);
  param_2 = x_81;
  let x_83 : vec4<f32> = Unpremultiply_vf4_(&(param_2));
  dst_2 = x_83;
  let x_92 : f32 = blend_info.color_factor;
  if ((x_92 > 0.0)) {
    let x_100 : vec4<f32> = blend_info.color;
    x_94 = x_100;
  } else {
    let x_108 : vec2<f32> = v_src_texture_coords;
    let x_109 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_108);
    param_3 = x_109;
    let x_111 : vec4<f32> = Unpremultiply_vf4_(&(param_3));
    x_94 = x_111;
  }
  let x_112 : vec4<f32> = x_94;
  src_2 = x_112;
  let x_115 : vec4<f32> = dst_2;
  param_4 = vec3<f32>(x_115.x, x_115.y, x_115.z);
  let x_118 : vec4<f32> = src_2;
  param_5 = vec3<f32>(x_118.x, x_118.y, x_118.z);
  let x_120 : vec3<f32> = Blend_vf3_vf3_(&(param_4), &(param_5));
  blended = x_120;
  let x_123 : vec3<f32> = blended;
  let x_125 : f32 = src_2.w;
  let x_126 : vec3<f32> = (x_123 * x_125);
  let x_128 : f32 = src_2.w;
  frag_color = vec4<f32>(x_126.x, x_126.y, x_126.z, x_128);
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
