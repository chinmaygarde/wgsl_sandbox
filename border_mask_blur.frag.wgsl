var<private> x_70 : vec2<f32>;

@group(0) @binding(0) var x_115 : texture_2d<f32>;

@group(0) @binding(1) var x_119 : sampler;

var<private> x_123 : vec2<f32>;

var<private> x_156 : f32;

var<private> x_160 : f32;

var<private> x_166 : f32;

var<private> x_178 : vec4<f32>;

fn main_1() {
  var x_140 : bool;
  var x_146 : bool;
  var x_152 : bool;
  var x_141_phi : bool;
  var x_147_phi : bool;
  var x_153_phi : bool;
  let x_124 : vec2<f32> = x_123;
  let x_125 : vec4<f32> = textureSample(x_115, x_119, x_124);
  let x_193 : f32 = x_124.x;
  let x_195 : f32 = x_70.x;
  let x_222 : f32 = (0.707106769 / x_195);
  let x_223 : f32 = (x_193 * x_222);
  let x_232 : f32 = abs(x_223);
  let x_243 : f32 = (((0.278393 + ((0.230388999 + ((0.078107998 * x_232) * x_232)) * x_232)) * x_232) + 1.0);
  let x_198 : f32 = x_124.y;
  let x_200 : f32 = x_70.y;
  let x_261 : f32 = (0.707106769 / x_200);
  let x_262 : f32 = (x_198 * x_261);
  let x_271 : f32 = abs(x_262);
  let x_282 : f32 = (((0.278393 + ((0.230388999 + ((0.078107998 * x_271) * x_271)) * x_271)) * x_271) + 1.0);
  let x_301 : f32 = ((1.0 - x_193) * x_222);
  let x_310 : f32 = abs(x_301);
  let x_321 : f32 = (((0.278393 + ((0.230388999 + ((0.078107998 * x_310) * x_310)) * x_310)) * x_310) + 1.0);
  let x_340 : f32 = ((1.0 - x_198) * x_261);
  let x_349 : f32 = abs(x_340);
  let x_360 : f32 = (((0.278393 + ((0.230388999 + ((0.078107998 * x_349) * x_349)) * x_349)) * x_349) + 1.0);
  let x_216 : f32 = (((((0.535000026 * (sign(x_223) * (1.0 - (1.0 / (((x_243 * x_243) * x_243) * x_243))))) + 0.465000004) * ((0.535000026 * (sign(x_262) * (1.0 - (1.0 / (((x_282 * x_282) * x_282) * x_282))))) + 0.465000004)) * ((0.535000026 * (sign(x_301) * (1.0 - (1.0 / (((x_321 * x_321) * x_321) * x_321))))) + 0.465000004)) * ((0.535000026 * (sign(x_340) * (1.0 - (1.0 / (((x_360 * x_360) * x_360) * x_360))))) + 0.465000004));
  let x_133 : f32 = x_123.x;
  let x_135 : bool = (x_133 >= 0.0);
  x_141_phi = x_135;
  if (x_135) {
    let x_139 : f32 = x_123.y;
    x_140 = (x_139 >= 0.0);
    x_141_phi = x_140;
  }
  let x_141 : bool = x_141_phi;
  x_147_phi = x_141;
  if (x_141) {
    x_146 = (x_133 < 1.0);
    x_147_phi = x_146;
  }
  let x_147 : bool = x_147_phi;
  x_153_phi = x_147;
  if (x_147) {
    let x_151 : f32 = x_123.y;
    x_152 = (x_151 < 1.0);
    x_153_phi = x_152;
  }
  let x_153 : bool = x_153_phi;
  let x_154 : f32 = select(0.0, 1.0, x_153);
  let x_157 : f32 = x_156;
  let x_161 : f32 = x_160;
  let x_167 : f32 = x_166;
  x_178 = (x_125 * ((((x_157 * x_216) + x_161) * x_154) + ((x_167 * x_216) * (1.0 - x_154))));
  return;
}

struct main_out {
  @location(0)
  x_178_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(1) x_70_param : vec2<f32>, @location(0) x_123_param : vec2<f32>, @location(3) x_156_param : f32, @location(2) x_160_param : f32, @location(4) x_166_param : f32) -> main_out {
  x_70 = x_70_param;
  x_123 = x_123_param;
  x_156 = x_156_param;
  x_160 = x_160_param;
  x_166 = x_166_param;
  main_1();
  return main_out(x_178);
}
