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
  let x_83 : f32 = (*(color)).w;
  if ((x_83 == 0.0)) {
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
  }
  let x_89 : vec4<f32> = *(color);
  let x_92 : f32 = (*(color)).w;
  let x_94 : vec3<f32> = (vec3<f32>(x_89.x, x_89.y, x_89.z) / vec3<f32>(x_92, x_92, x_92));
  let x_96 : f32 = (*(color)).w;
  return vec4<f32>(x_94.x, x_94.y, x_94.z, x_96);
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
  let x_60 : vec3<f32> = *(src);
  color_1 = (vec3<f32>(1.0, 1.0, 1.0) - min(vec3<f32>(1.0, 1.0, 1.0), ((vec3<f32>(1.0, 1.0, 1.0) - x_57) / x_60)));
  let x_65 : vec3<f32> = color_1;
  let x_67 : vec3<f32> = *(dst);
  param = x_67;
  param_1 = 1.0;
  let x_69 : vec3<f32> = ComponentIsValue_vf3_f1_(&(param), &(param_1));
  color_1 = mix(x_65, vec3<f32>(1.0, 1.0, 1.0), x_69);
  let x_71 : vec3<f32> = color_1;
  let x_74 : vec3<f32> = *(src);
  param_2 = x_74;
  param_3 = 0.0;
  let x_76 : vec3<f32> = ComponentIsValue_vf3_f1_(&(param_2), &(param_3));
  color_1 = mix(x_71, vec3<f32>(0.0, 0.0, 0.0), x_76);
  let x_78 : vec3<f32> = color_1;
  return x_78;
}

fn main_1() {
  var dst_1 : vec4<f32>;
  var param_4 : vec4<f32>;
  var src_1 : vec4<f32>;
  var x_131 : vec4<f32>;
  var param_5 : vec4<f32>;
  var blended : vec3<f32>;
  var param_6 : vec3<f32>;
  var param_7 : vec3<f32>;
  let x_117 : vec2<f32> = v_dst_texture_coords;
  let x_118 : vec4<f32> = textureSample(texture_sampler_dst, texture_sampler_dst_smplr, x_117);
  param_4 = x_118;
  let x_120 : vec4<f32> = Unpremultiply_vf4_(&(param_4));
  dst_1 = x_120;
  let x_129 : f32 = blend_info.color_factor;
  if ((x_129 > 0.0)) {
    let x_137 : vec4<f32> = blend_info.color;
    x_131 = x_137;
  } else {
    let x_145 : vec2<f32> = v_src_texture_coords;
    let x_146 : vec4<f32> = textureSample(texture_sampler_src, texture_sampler_src_smplr, x_145);
    param_5 = x_146;
    let x_148 : vec4<f32> = Unpremultiply_vf4_(&(param_5));
    x_131 = x_148;
  }
  let x_149 : vec4<f32> = x_131;
  src_1 = x_149;
  let x_152 : vec4<f32> = dst_1;
  param_6 = vec3<f32>(x_152.x, x_152.y, x_152.z);
  let x_155 : vec4<f32> = src_1;
  param_7 = vec3<f32>(x_155.x, x_155.y, x_155.z);
  let x_157 : vec3<f32> = Blend_vf3_vf3_(&(param_6), &(param_7));
  blended = x_157;
  let x_160 : vec3<f32> = blended;
  let x_162 : f32 = src_1.w;
  let x_163 : vec3<f32> = (x_160 * x_162);
  let x_165 : f32 = src_1.w;
  frag_color = vec4<f32>(x_163.x, x_163.y, x_163.z, x_165);
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
