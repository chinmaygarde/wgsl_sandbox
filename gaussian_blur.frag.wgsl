var<private> x_14 : f32;

var<private> x_42 : vec2<f32>;

var<private> x_44 : vec2<f32>;

var<private> x_48 : f32;

@group(0) @binding(0) var x_70 : texture_2d<f32>;

@group(0) @binding(1) var x_74 : sampler;

var<private> x_78 : vec2<f32>;

@group(0) @binding(2) var x_97 : texture_2d<f32>;

@group(0) @binding(3) var x_99 : sampler;

var<private> x_102 : vec2<f32>;

var<private> x_106 : f32;

var<private> x_115 : f32;

var<private> x_124 : vec4<f32>;

var<private> x_129 : f32;

fn main_1() {
  var x_153 : f32;
  var x_152 : vec4<f32>;
  var x_153_phi : f32;
  var x_152_phi : vec4<f32>;
  var x_151_phi : f32;
  let x_43 : vec2<f32> = x_42;
  let x_45 : vec2<f32> = x_44;
  let x_46 : vec2<f32> = (x_43 / x_45);
  let x_49 : f32 = x_48;
  let x_50 : f32 = -(x_49);
  x_153_phi = 0.0;
  x_152_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
  x_151_phi = x_50;
  loop {
    var x_66 : f32;
    var x_87 : vec4<f32>;
    var x_90 : f32;
    x_153 = x_153_phi;
    x_152 = x_152_phi;
    let x_151 : f32 = x_151_phi;
    if ((x_151 <= x_49)) {
    } else {
      break;
    }

    continuing {
      let x_136 : f32 = x_14;
      let x_148 : f32 = (exp((((-0.5 * x_151) * x_151) / (x_136 * x_136))) / (2.506628275 * x_136));
      x_66 = (x_153 + x_148);
      let x_79 : vec2<f32> = x_78;
      let x_84 : vec4<f32> = textureSample(x_70, x_74, (x_79 + (x_46 * x_151)));
      x_87 = (x_152 + (x_84 * x_148));
      x_90 = (x_151 + 1.0);
      x_153_phi = x_66;
      x_152_phi = x_87;
      x_151_phi = x_90;
    }
  }
  let x_103 : vec2<f32> = x_102;
  let x_104 : vec4<f32> = textureSample(x_97, x_99, x_103);
  let x_107 : f32 = x_106;
  let x_111 : f32 = x_104.w;
  let x_116 : f32 = x_115;
  let x_130 : f32 = x_129;
  x_124 = (((x_152 / vec4<f32>(x_153, x_153, x_153, x_153)) * ((x_107 * select(0.0, 1.0, (x_111 > 0.0))) + (x_116 * select(0.0, 1.0, (x_111 == 0.0))))) + (x_104 * x_130));
  return;
}

struct main_out {
  @location(0)
  x_124_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(4) x_14_param : f32, @location(3) x_42_param : vec2<f32>, @location(2) x_44_param : vec2<f32>, @location(5) x_48_param : f32, @location(0) x_78_param : vec2<f32>, @location(1) x_102_param : vec2<f32>, @location(7) x_106_param : f32, @location(8) x_115_param : f32, @location(6) x_129_param : f32) -> main_out {
  x_14 = x_14_param;
  x_42 = x_42_param;
  x_44 = x_44_param;
  x_48 = x_48_param;
  x_78 = x_78_param;
  x_102 = x_102_param;
  x_106 = x_106_param;
  x_115 = x_115_param;
  x_129 = x_129_param;
  main_1();
  return main_out(x_124);
}
