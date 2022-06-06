struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_104 : texture_2d<f32>;

@group(0) @binding(2) var x_108 : sampler;

var<private> x_114 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_122 : S;

@group(0) @binding(3) var x_137 : texture_2d<f32>;

@group(0) @binding(4) var x_139 : sampler;

var<private> x_142 : vec2<f32>;

var<private> x_157 : vec4<f32>;

fn main_1() {
  var x_116 : vec4<f32>;
  var x_197 : vec4<f32>;
  var x_135 : vec4<f32>;
  var x_303 : vec4<f32>;
  var x_302_phi : vec4<f32>;
  var x_304_phi : vec4<f32>;
  let x_115 : vec2<f32> = x_114;
  x_116 = textureSample(x_104, x_108, x_115);
  switch(0u) {
    default: {
      let x_182 : f32 = x_116.w;
      if ((x_182 == 0.0)) {
        x_302_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_191 : vec3<f32> = (vec3<f32>(x_116.x, x_116.y, x_116.z) / vec3<f32>(x_182, x_182, x_182));
      x_197 = vec4<f32>(x_191.x, x_191.y, x_191.z, x_182);
      x_302_phi = x_197;
    }
  }
  var x_221 : vec4<f32>;
  var x_303_phi : vec4<f32>;
  let x_302 : vec4<f32> = x_302_phi;
  let x_127 : f32 = x_122.field0;
  if ((x_127 > 0.0)) {
    x_135 = x_122.field1;
    x_304_phi = x_135;
  } else {
    var x_144 : vec4<f32>;
    let x_143 : vec2<f32> = x_142;
    x_144 = textureSample(x_137, x_139, x_143);
    switch(0u) {
      default: {
        let x_206 : f32 = x_144.w;
        if ((x_206 == 0.0)) {
          x_303_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_215 : vec3<f32> = (vec3<f32>(x_144.x, x_144.y, x_144.z) / vec3<f32>(x_206, x_206, x_206));
        x_221 = vec4<f32>(x_215.x, x_215.y, x_215.z, x_206);
        x_303_phi = x_221;
      }
    }
    x_303 = x_303_phi;
    x_304_phi = x_303;
  }
  let x_304 : vec4<f32> = x_304_phi;
  let x_151 : vec3<f32> = vec3<f32>(x_302.x, x_302.y, x_302.z);
  let x_154 : vec3<f32> = vec3<f32>(x_304.x, x_304.y, x_304.z);
  let x_253 : vec3<f32> = abs(x_151);
  let x_274 : vec3<f32> = abs((x_154 - vec3<f32>(1.0, 1.0, 1.0)));
  let x_160 : f32 = x_304.w;
  let x_161 : vec3<f32> = (mix(mix(min(vec3<f32>(1.0, 1.0, 1.0), (x_151 / (vec3<f32>(1.0, 1.0, 1.0) - x_154))), vec3<f32>(0.0, 0.0, 0.0), vec3<f32>(select(0.0, 1.0, (x_253.x < 0.0001)), select(0.0, 1.0, (x_253.y < 0.0001)), select(0.0, 1.0, (x_253.z < 0.0001)))), vec3<f32>(1.0, 1.0, 1.0), vec3<f32>(select(0.0, 1.0, (x_274.x < 0.0001)), select(0.0, 1.0, (x_274.y < 0.0001)), select(0.0, 1.0, (x_274.z < 0.0001)))) * x_160);
  x_157 = vec4<f32>(x_161.x, x_161.y, x_161.z, x_160);
  return;
}

struct main_out {
  @location(0)
  x_157_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_114_param : vec2<f32>, @location(1) x_142_param : vec2<f32>) -> main_out {
  x_114 = x_114_param;
  x_142 = x_142_param;
  main_1();
  return main_out(x_157);
}
