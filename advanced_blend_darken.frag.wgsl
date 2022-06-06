struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_54 : texture_2d<f32>;

@group(0) @binding(2) var x_58 : sampler;

var<private> x_64 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_72 : S;

@group(0) @binding(3) var x_87 : texture_2d<f32>;

@group(0) @binding(4) var x_89 : sampler;

var<private> x_92 : vec2<f32>;

var<private> x_107 : vec4<f32>;

fn main_1() {
  var x_66 : vec4<f32>;
  var x_148 : vec4<f32>;
  var x_85 : vec4<f32>;
  var x_189 : vec4<f32>;
  var x_188_phi : vec4<f32>;
  var x_190_phi : vec4<f32>;
  let x_65 : vec2<f32> = x_64;
  x_66 = textureSample(x_54, x_58, x_65);
  switch(0u) {
    default: {
      let x_133 : f32 = x_66.w;
      if ((x_133 == 0.0)) {
        x_188_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_142 : vec3<f32> = (vec3<f32>(x_66.x, x_66.y, x_66.z) / vec3<f32>(x_133, x_133, x_133));
      x_148 = vec4<f32>(x_142.x, x_142.y, x_142.z, x_133);
      x_188_phi = x_148;
    }
  }
  var x_172 : vec4<f32>;
  var x_189_phi : vec4<f32>;
  let x_188 : vec4<f32> = x_188_phi;
  let x_77 : f32 = x_72.field0;
  if ((x_77 > 0.0)) {
    x_85 = x_72.field1;
    x_190_phi = x_85;
  } else {
    var x_94 : vec4<f32>;
    let x_93 : vec2<f32> = x_92;
    x_94 = textureSample(x_87, x_89, x_93);
    switch(0u) {
      default: {
        let x_157 : f32 = x_94.w;
        if ((x_157 == 0.0)) {
          x_189_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_166 : vec3<f32> = (vec3<f32>(x_94.x, x_94.y, x_94.z) / vec3<f32>(x_157, x_157, x_157));
        x_172 = vec4<f32>(x_166.x, x_166.y, x_166.z, x_157);
        x_189_phi = x_172;
      }
    }
    x_189 = x_189_phi;
    x_190_phi = x_189;
  }
  let x_190 : vec4<f32> = x_190_phi;
  let x_110 : f32 = x_190.w;
  let x_111 : vec3<f32> = (min(vec3<f32>(x_188.x, x_188.y, x_188.z), vec3<f32>(x_190.x, x_190.y, x_190.z)) * x_110);
  x_107 = vec4<f32>(x_111.x, x_111.y, x_111.z, x_110);
  return;
}

struct main_out {
  @location(0)
  x_107_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_64_param : vec2<f32>, @location(1) x_92_param : vec2<f32>) -> main_out {
  x_64 = x_64_param;
  x_92 = x_92_param;
  main_1();
  return main_out(x_107);
}
