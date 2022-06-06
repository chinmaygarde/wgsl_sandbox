struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_106 : texture_2d<f32>;

@group(0) @binding(2) var x_110 : sampler;

var<private> x_116 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_124 : S;

@group(0) @binding(3) var x_139 : texture_2d<f32>;

@group(0) @binding(4) var x_141 : sampler;

var<private> x_144 : vec2<f32>;

var<private> x_159 : vec4<f32>;

fn main_1() {
  var x_118 : vec4<f32>;
  var x_199 : vec4<f32>;
  var x_137 : vec4<f32>;
  var x_307 : vec4<f32>;
  var x_306_phi : vec4<f32>;
  var x_308_phi : vec4<f32>;
  let x_117 : vec2<f32> = x_116;
  x_118 = textureSample(x_106, x_110, x_117);
  switch(0u) {
    default: {
      let x_184 : f32 = x_118.w;
      if ((x_184 == 0.0)) {
        x_306_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_193 : vec3<f32> = (vec3<f32>(x_118.x, x_118.y, x_118.z) / vec3<f32>(x_184, x_184, x_184));
      x_199 = vec4<f32>(x_193.x, x_193.y, x_193.z, x_184);
      x_306_phi = x_199;
    }
  }
  var x_223 : vec4<f32>;
  var x_307_phi : vec4<f32>;
  let x_306 : vec4<f32> = x_306_phi;
  let x_129 : f32 = x_124.field0;
  if ((x_129 > 0.0)) {
    x_137 = x_124.field1;
    x_308_phi = x_137;
  } else {
    var x_146 : vec4<f32>;
    let x_145 : vec2<f32> = x_144;
    x_146 = textureSample(x_139, x_141, x_145);
    switch(0u) {
      default: {
        let x_208 : f32 = x_146.w;
        if ((x_208 == 0.0)) {
          x_307_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_217 : vec3<f32> = (vec3<f32>(x_146.x, x_146.y, x_146.z) / vec3<f32>(x_208, x_208, x_208));
        x_223 = vec4<f32>(x_217.x, x_217.y, x_217.z, x_208);
        x_307_phi = x_223;
      }
    }
    x_307 = x_307_phi;
    x_308_phi = x_307;
  }
  let x_308 : vec4<f32> = x_308_phi;
  let x_153 : vec3<f32> = vec3<f32>(x_306.x, x_306.y, x_306.z);
  let x_156 : vec3<f32> = vec3<f32>(x_308.x, x_308.y, x_308.z);
  let x_257 : vec3<f32> = abs((x_153 - vec3<f32>(1.0, 1.0, 1.0)));
  let x_278 : vec3<f32> = abs(x_156);
  let x_162 : f32 = x_308.w;
  let x_163 : vec3<f32> = (mix(mix((vec3<f32>(1.0, 1.0, 1.0) - min(vec3<f32>(1.0, 1.0, 1.0), ((vec3<f32>(1.0, 1.0, 1.0) - x_153) / x_156))), vec3<f32>(1.0, 1.0, 1.0), vec3<f32>(select(0.0, 1.0, (x_257.x < 0.0001)), select(0.0, 1.0, (x_257.y < 0.0001)), select(0.0, 1.0, (x_257.z < 0.0001)))), vec3<f32>(0.0, 0.0, 0.0), vec3<f32>(select(0.0, 1.0, (x_278.x < 0.0001)), select(0.0, 1.0, (x_278.y < 0.0001)), select(0.0, 1.0, (x_278.z < 0.0001)))) * x_162);
  x_159 = vec4<f32>(x_163.x, x_163.y, x_163.z, x_162);
  return;
}

struct main_out {
  @location(0)
  x_159_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_116_param : vec2<f32>, @location(1) x_144_param : vec2<f32>) -> main_out {
  x_116 = x_116_param;
  x_144 = x_144_param;
  main_1();
  return main_out(x_159);
}
