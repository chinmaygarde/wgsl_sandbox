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
  let x_29 : f32 = (*(color)).w;
  if ((x_29 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_37 : vec4<f32> = *(color);
  let x_40 : f32 = (*(color)).w;
  let x_42 : vec3<f32> = (vec3<f32>(x_37.x, x_37.y, x_37.z) / vec3<f32>(x_40, x_40, x_40));
  let x_44 : f32 = (*(color)).w;
  return vec4<f32>(x_42.x, x_42.y, x_42.z, x_44);
}

fn Blend_vf3_vf3_(dst : ptr<function, vec3<f32>>, src : ptr<function, vec3<f32>>) -> vec3<f32> {
  let x_20 : vec3<f32> = *(dst);
  let x_21 : vec3<f32> = *(src);
  return max(x_20, x_21);
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_79 : vec4<f32>;
  var param_1 : vec4<f32>;
  var blended : vec3<f32>;
  var param_2 : vec3<f32>;
  var param_3 : vec3<f32>;
  let x_65 : vec2<f32> = v_dst_texture_coords;
  let x_66 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_65);
  param = x_66;
  let x_68 : vec4<f32> = Unpremultiply_vf4_(&(param));
  dst_1 = x_68;
  let x_77 : f32 = blend_info.color_factor;
  if ((x_77 > 0.0)) {
    let x_85 : vec4<f32> = blend_info.color;
    x_79 = x_85;
  } else {
    let x_93 : vec2<f32> = v_src_texture_coords;
    let x_94 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_93);
    param_1 = x_94;
    let x_96 : vec4<f32> = Unpremultiply_vf4_(&(param_1));
    x_79 = x_96;
  }
  let x_97 : vec4<f32> = x_79;
  src_1 = x_97;
  let x_100 : vec4<f32> = dst_1;
  param_2 = vec3<f32>(x_100.x, x_100.y, x_100.z);
  let x_103 : vec4<f32> = src_1;
  param_3 = vec3<f32>(x_103.x, x_103.y, x_103.z);
  let x_105 : vec3<f32> = Blend_vf3_vf3_(&(param_2), &(param_3));
  blended = x_105;
  let x_108 : vec3<f32> = blended;
  let x_110 : f32 = src_1.w;
  let x_111 : vec3<f32> = (x_108 * x_110);
  let x_113 : f32 = src_1.w;
  frag_color = vec4<f32>(x_111.x, x_111.y, x_111.z, x_113);
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
