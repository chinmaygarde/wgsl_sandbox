struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_160 : texture_2d<f32>;

@group(0) @binding(2) var x_164 : sampler;

var<private> x_170 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_178 : S;

@group(0) @binding(3) var x_193 : texture_2d<f32>;

@group(0) @binding(4) var x_195 : sampler;

var<private> x_198 : vec2<f32>;

var<private> x_213 : vec4<f32>;

fn main_1() {
  var x_172 : vec4<f32>;
  var x_253 : vec4<f32>;
  var x_191 : vec4<f32>;
  var x_425 : vec4<f32>;
  var x_424_phi : vec4<f32>;
  var x_426_phi : vec4<f32>;
  let x_171 : vec2<f32> = x_170;
  x_172 = textureSample(x_160, x_164, x_171);
  switch(0u) {
    default: {
      let x_238 : f32 = x_172.w;
      if ((x_238 == 0.0)) {
        x_424_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_247 : vec3<f32> = (vec3<f32>(x_172.x, x_172.y, x_172.z) / vec3<f32>(x_238, x_238, x_238));
      x_253 = vec4<f32>(x_247.x, x_247.y, x_247.z, x_238);
      x_424_phi = x_253;
    }
  }
  var x_277 : vec4<f32>;
  var x_425_phi : vec4<f32>;
  let x_424 : vec4<f32> = x_424_phi;
  let x_183 : f32 = x_178.field0;
  if ((x_183 > 0.0)) {
    x_191 = x_178.field1;
    x_426_phi = x_191;
  } else {
    var x_200 : vec4<f32>;
    let x_199 : vec2<f32> = x_198;
    x_200 = textureSample(x_193, x_195, x_199);
    switch(0u) {
      default: {
        let x_262 : f32 = x_200.w;
        if ((x_262 == 0.0)) {
          x_425_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_271 : vec3<f32> = (vec3<f32>(x_200.x, x_200.y, x_200.z) / vec3<f32>(x_262, x_262, x_262));
        x_277 = vec4<f32>(x_271.x, x_271.y, x_271.z, x_262);
        x_425_phi = x_277;
      }
    }
    x_425 = x_425_phi;
    x_426_phi = x_425;
  }
  let x_426 : vec4<f32> = x_426_phi;
  let x_207 : vec3<f32> = vec3<f32>(x_424.x, x_424.y, x_424.z);
  let x_299 : vec3<f32> = (((((x_207 * 16.0) - vec3<f32>(12.0, 12.0, 12.0)) * x_207) + vec3<f32>(4.0, 4.0, 4.0)) * x_207);
  let x_301 : vec3<f32> = sqrt(x_207);
  let x_306 : vec3<f32> = (vec3<f32>(x_426.x, x_426.y, x_426.z) * 2.0);
  let x_315 : vec3<f32> = (x_207 - (((vec3<f32>(1.0, 1.0, 1.0) - x_306) * x_207) * (vec3<f32>(1.0, 1.0, 1.0) - x_207)));
  let x_325 : vec3<f32> = (x_207 + ((x_306 - vec3<f32>(1.0, 1.0, 1.0)) * (vec3<f32>(select(x_299.x, x_301.x, (x_424.x > 0.25)), select(x_299.y, x_301.y, (x_424.y > 0.25)), select(x_299.z, x_301.z, (x_424.z > 0.25))) - x_207)));
  let x_216 : f32 = x_426.w;
  let x_217 : vec3<f32> = (vec3<f32>(select(x_315.x, x_325.x, (x_426.x > 0.5)), select(x_315.y, x_325.y, (x_426.y > 0.5)), select(x_315.z, x_325.z, (x_426.z > 0.5))) * x_216);
  x_213 = vec4<f32>(x_217.x, x_217.y, x_217.z, x_216);
  return;
}

struct main_out {
  @location(0)
  x_213_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_170_param : vec2<f32>, @location(1) x_198_param : vec2<f32>) -> main_out {
  x_170 = x_170_param;
  x_198 = x_198_param;
  main_1();
  return main_out(x_213);
}
