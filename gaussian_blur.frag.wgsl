var<private> v_blur_sigma : f32;

var<private> v_blur_direction : vec2<f32>;

var<private> v_texture_size : vec2<f32>;

var<private> v_blur_radius : f32;

@group(0) @binding(0) var texture_sampler : texture_2d<f32>;

@group(0) @binding(1) var texture_sampler_smplr : sampler;

var<private> v_texture_coords : vec2<f32>;

@group(0) @binding(2) var alpha_mask_sampler : texture_2d<f32>;

@group(0) @binding(3) var alpha_mask_sampler_smplr : sampler;

var<private> v_src_texture_coords : vec2<f32>;

var<private> v_inner_blur_factor : f32;

var<private> v_outer_blur_factor : f32;

var<private> frag_color : vec4<f32>;

var<private> v_src_factor : f32;

fn Gaussian_f1_(x : ptr<function, f32>) -> f32 {
  var variance : f32;
  let x_15 : f32 = v_blur_sigma;
  let x_16 : f32 = v_blur_sigma;
  variance = (x_15 * x_16);
  let x_19 : f32 = *(x);
  let x_21 : f32 = *(x);
  let x_23 : f32 = variance;
  let x_27 : f32 = v_blur_sigma;
  return (exp((((-0.5 * x_19) * x_21) / x_23)) / (2.506628275 * x_27));
}

fn main_1() {
  var total_color : vec4<f32>;
  var gaussian_integral : f32;
  var blur_uv_offset : vec2<f32>;
  var i : f32;
  var gaussian : f32;
  var param : f32;
  var blur_color : vec4<f32>;
  var src_color : vec4<f32>;
  var blur_factor : f32;
  total_color = vec4<f32>(0.0, 0.0, 0.0, 0.0);
  gaussian_integral = 0.0;
  let x_43 : vec2<f32> = v_blur_direction;
  let x_45 : vec2<f32> = v_texture_size;
  blur_uv_offset = (x_43 / x_45);
  let x_49 : f32 = v_blur_radius;
  i = -(x_49);
  loop {
    let x_56 : f32 = i;
    let x_57 : f32 = v_blur_radius;
    if ((x_56 <= x_57)) {
    } else {
      break;
    }
    let x_62 : f32 = i;
    param = x_62;
    let x_63 : f32 = Gaussian_f1_(&(param));
    gaussian = x_63;
    let x_64 : f32 = gaussian;
    let x_65 : f32 = gaussian_integral;
    gaussian_integral = (x_65 + x_64);
    let x_67 : f32 = gaussian;
    let x_79 : vec2<f32> = v_texture_coords;
    let x_80 : vec2<f32> = blur_uv_offset;
    let x_81 : f32 = i;
    let x_84 : vec4<f32> = textureSample(texture_sampler, texture_sampler_smplr, (x_79 + (x_80 * x_81)));
    let x_86 : vec4<f32> = total_color;
    total_color = (x_86 + (x_84 * x_67));

    continuing {
      let x_88 : f32 = i;
      i = (x_88 + 1.0);
    }
  }
  let x_92 : vec4<f32> = total_color;
  let x_93 : f32 = gaussian_integral;
  blur_color = (x_92 / vec4<f32>(x_93, x_93, x_93, x_93));
  let x_103 : vec2<f32> = v_src_texture_coords;
  let x_104 : vec4<f32> = textureSample(alpha_mask_sampler, alpha_mask_sampler_smplr, x_103);
  src_color = x_104;
  let x_107 : f32 = v_inner_blur_factor;
  let x_111 : f32 = src_color.w;
  let x_116 : f32 = v_outer_blur_factor;
  let x_118 : f32 = src_color.w;
  blur_factor = ((x_107 * select(0.0, 1.0, (x_111 > 0.0))) + (x_116 * select(0.0, 1.0, (x_118 == 0.0))));
  let x_125 : vec4<f32> = blur_color;
  let x_126 : f32 = blur_factor;
  let x_128 : vec4<f32> = src_color;
  let x_130 : f32 = v_src_factor;
  frag_color = ((x_125 * x_126) + (x_128 * x_130));
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(4) v_blur_sigma_param : f32, @location(3) v_blur_direction_param : vec2<f32>, @location(2) v_texture_size_param : vec2<f32>, @location(5) v_blur_radius_param : f32, @location(0) v_texture_coords_param : vec2<f32>, @location(1) v_src_texture_coords_param : vec2<f32>, @location(7) v_inner_blur_factor_param : f32, @location(8) v_outer_blur_factor_param : f32, @location(6) v_src_factor_param : f32) -> main_out {
  v_blur_sigma = v_blur_sigma_param;
  v_blur_direction = v_blur_direction_param;
  v_texture_size = v_texture_size_param;
  v_blur_radius = v_blur_radius_param;
  v_texture_coords = v_texture_coords_param;
  v_src_texture_coords = v_src_texture_coords_param;
  v_inner_blur_factor = v_inner_blur_factor_param;
  v_outer_blur_factor = v_outer_blur_factor_param;
  v_src_factor = v_src_factor_param;
  main_1();
  return main_out(frag_color);
}
