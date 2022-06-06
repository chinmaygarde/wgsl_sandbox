struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_55 : texture_2d<f32>;

@group(0) @binding(2) var x_59 : sampler;

var<private> x_65 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_73 : S;

@group(0) @binding(3) var x_88 : texture_2d<f32>;

@group(0) @binding(4) var x_90 : sampler;

var<private> x_93 : vec2<f32>;

var<private> x_108 : vec4<f32>;

fn main_1() {
  var x_67 : vec4<f32>;
  var x_149 : vec4<f32>;
  var x_86 : vec4<f32>;
  var x_191 : vec4<f32>;
  var x_190_phi : vec4<f32>;
  var x_192_phi : vec4<f32>;
  let x_66 : vec2<f32> = x_65;
  x_67 = textureSample(x_55, x_59, x_66);
  switch(0u) {
    default: {
      let x_134 : f32 = x_67.w;
      if ((x_134 == 0.0)) {
        x_190_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_143 : vec3<f32> = (vec3<f32>(x_67.x, x_67.y, x_67.z) / vec3<f32>(x_134, x_134, x_134));
      x_149 = vec4<f32>(x_143.x, x_143.y, x_143.z, x_134);
      x_190_phi = x_149;
    }
  }
  var x_173 : vec4<f32>;
  var x_191_phi : vec4<f32>;
  let x_190 : vec4<f32> = x_190_phi;
  let x_78 : f32 = x_73.field0;
  if ((x_78 > 0.0)) {
    x_86 = x_73.field1;
    x_192_phi = x_86;
  } else {
    var x_95 : vec4<f32>;
    let x_94 : vec2<f32> = x_93;
    x_95 = textureSample(x_88, x_90, x_94);
    switch(0u) {
      default: {
        let x_158 : f32 = x_95.w;
        if ((x_158 == 0.0)) {
          x_191_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_167 : vec3<f32> = (vec3<f32>(x_95.x, x_95.y, x_95.z) / vec3<f32>(x_158, x_158, x_158));
        x_173 = vec4<f32>(x_167.x, x_167.y, x_167.z, x_158);
        x_191_phi = x_173;
      }
    }
    x_191 = x_191_phi;
    x_192_phi = x_191;
  }
  let x_192 : vec4<f32> = x_192_phi;
  let x_111 : f32 = x_192.w;
  let x_112 : vec3<f32> = (abs((vec3<f32>(x_190.x, x_190.y, x_190.z) - vec3<f32>(x_192.x, x_192.y, x_192.z))) * x_111);
  x_108 = vec4<f32>(x_112.x, x_112.y, x_112.z, x_111);
  return;
}

struct main_out {
  @location(0)
  x_108_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_65_param : vec2<f32>, @location(1) x_93_param : vec2<f32>) -> main_out {
  x_65 = x_65_param;
  x_93 = x_93_param;
  main_1();
  return main_out(x_108);
}
