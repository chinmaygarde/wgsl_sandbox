struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_69 : texture_2d<f32>;

@group(0) @binding(2) var x_73 : sampler;

var<private> x_79 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_87 : S;

@group(0) @binding(3) var x_102 : texture_2d<f32>;

@group(0) @binding(4) var x_104 : sampler;

var<private> x_107 : vec2<f32>;

var<private> x_122 : vec4<f32>;

fn main_1() {
  var x_81 : vec4<f32>;
  var x_163 : vec4<f32>;
  var x_100 : vec4<f32>;
  var x_215 : vec4<f32>;
  var x_214_phi : vec4<f32>;
  var x_216_phi : vec4<f32>;
  let x_80 : vec2<f32> = x_79;
  x_81 = textureSample(x_69, x_73, x_80);
  switch(0u) {
    default: {
      let x_148 : f32 = x_81.w;
      if ((x_148 == 0.0)) {
        x_214_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_157 : vec3<f32> = (vec3<f32>(x_81.x, x_81.y, x_81.z) / vec3<f32>(x_148, x_148, x_148));
      x_163 = vec4<f32>(x_157.x, x_157.y, x_157.z, x_148);
      x_214_phi = x_163;
    }
  }
  var x_187 : vec4<f32>;
  var x_215_phi : vec4<f32>;
  let x_214 : vec4<f32> = x_214_phi;
  let x_92 : f32 = x_87.field0;
  if ((x_92 > 0.0)) {
    x_100 = x_87.field1;
    x_216_phi = x_100;
  } else {
    var x_109 : vec4<f32>;
    let x_108 : vec2<f32> = x_107;
    x_109 = textureSample(x_102, x_104, x_108);
    switch(0u) {
      default: {
        let x_172 : f32 = x_109.w;
        if ((x_172 == 0.0)) {
          x_215_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_181 : vec3<f32> = (vec3<f32>(x_109.x, x_109.y, x_109.z) / vec3<f32>(x_172, x_172, x_172));
        x_187 = vec4<f32>(x_181.x, x_181.y, x_181.z, x_172);
        x_215_phi = x_187;
      }
    }
    x_215 = x_215_phi;
    x_216_phi = x_215;
  }
  let x_216 : vec4<f32> = x_216_phi;
  let x_116 : vec3<f32> = vec3<f32>(x_214.x, x_214.y, x_214.z);
  let x_119 : vec3<f32> = vec3<f32>(x_216.x, x_216.y, x_216.z);
  let x_125 : f32 = x_216.w;
  let x_126 : vec3<f32> = (((x_116 + x_119) - (x_116 * x_119)) * x_125);
  x_122 = vec4<f32>(x_126.x, x_126.y, x_126.z, x_125);
  return;
}

struct main_out {
  @location(0)
  x_122_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_79_param : vec2<f32>, @location(1) x_107_param : vec2<f32>) -> main_out {
  x_79 = x_79_param;
  x_107 = x_107_param;
  main_1();
  return main_out(x_122);
}
