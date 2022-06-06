struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_151 : texture_2d<f32>;

@group(0) @binding(2) var x_155 : sampler;

var<private> x_161 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_169 : S;

@group(0) @binding(3) var x_184 : texture_2d<f32>;

@group(0) @binding(4) var x_186 : sampler;

var<private> x_189 : vec2<f32>;

var<private> x_204 : vec4<f32>;

fn main_1() {
  var x_163 : vec4<f32>;
  var x_244 : vec4<f32>;
  var x_182 : vec4<f32>;
  var x_364 : vec4<f32>;
  var x_363_phi : vec4<f32>;
  var x_365_phi : vec4<f32>;
  let x_162 : vec2<f32> = x_161;
  x_163 = textureSample(x_151, x_155, x_162);
  switch(0u) {
    default: {
      let x_229 : f32 = x_163.w;
      if ((x_229 == 0.0)) {
        x_363_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_238 : vec3<f32> = (vec3<f32>(x_163.x, x_163.y, x_163.z) / vec3<f32>(x_229, x_229, x_229));
      x_244 = vec4<f32>(x_238.x, x_238.y, x_238.z, x_229);
      x_363_phi = x_244;
    }
  }
  var x_268 : vec4<f32>;
  var x_364_phi : vec4<f32>;
  let x_363 : vec4<f32> = x_363_phi;
  let x_174 : f32 = x_169.field0;
  if ((x_174 > 0.0)) {
    x_182 = x_169.field1;
    x_365_phi = x_182;
  } else {
    var x_191 : vec4<f32>;
    let x_190 : vec2<f32> = x_189;
    x_191 = textureSample(x_184, x_186, x_190);
    switch(0u) {
      default: {
        let x_253 : f32 = x_191.w;
        if ((x_253 == 0.0)) {
          x_364_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_262 : vec3<f32> = (vec3<f32>(x_191.x, x_191.y, x_191.z) / vec3<f32>(x_253, x_253, x_253));
        x_268 = vec4<f32>(x_262.x, x_262.y, x_262.z, x_253);
        x_364_phi = x_268;
      }
    }
    x_364 = x_364_phi;
    x_365_phi = x_364;
  }
  let x_365 : vec4<f32> = x_365_phi;
  let x_198 : vec3<f32> = vec3<f32>(x_363.x, x_363.y, x_363.z);
  let x_287 : vec3<f32> = (vec3<f32>(x_365.x, x_365.y, x_365.z) * 2.0);
  let x_288 : vec3<f32> = (x_198 * x_287);
  let x_292 : vec3<f32> = (x_287 - vec3<f32>(1.0, 1.0, 1.0));
  let x_305 : vec3<f32> = ((x_198 + x_292) - (x_198 * x_292));
  let x_207 : f32 = x_365.w;
  let x_208 : vec3<f32> = (vec3<f32>(select(x_288.x, x_305.x, (x_365.x > 0.5)), select(x_288.y, x_305.y, (x_365.y > 0.5)), select(x_288.z, x_305.z, (x_365.z > 0.5))) * x_207);
  x_204 = vec4<f32>(x_208.x, x_208.y, x_208.z, x_207);
  return;
}

struct main_out {
  @location(0)
  x_204_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_161_param : vec2<f32>, @location(1) x_189_param : vec2<f32>) -> main_out {
  x_161 = x_161_param;
  x_189 = x_189_param;
  main_1();
  return main_out(x_204);
}
