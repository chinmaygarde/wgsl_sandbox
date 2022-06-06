struct S {
  field0 : f32,
  @size(12)
  padding : u32,
  field1 : vec4<f32>,
}

@group(0) @binding(1) var x_60 : texture_2d<f32>;

@group(0) @binding(2) var x_64 : sampler;

var<private> x_70 : vec2<f32>;

@group(0) @binding(0) var<uniform> x_78 : S;

@group(0) @binding(3) var x_93 : texture_2d<f32>;

@group(0) @binding(4) var x_95 : sampler;

var<private> x_98 : vec2<f32>;

var<private> x_113 : vec4<f32>;

fn main_1() {
  var x_72 : vec4<f32>;
  var x_154 : vec4<f32>;
  var x_91 : vec4<f32>;
  var x_200 : vec4<f32>;
  var x_199_phi : vec4<f32>;
  var x_201_phi : vec4<f32>;
  let x_71 : vec2<f32> = x_70;
  x_72 = textureSample(x_60, x_64, x_71);
  switch(0u) {
    default: {
      let x_139 : f32 = x_72.w;
      if ((x_139 == 0.0)) {
        x_199_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
        break;
      }
      let x_148 : vec3<f32> = (vec3<f32>(x_72.x, x_72.y, x_72.z) / vec3<f32>(x_139, x_139, x_139));
      x_154 = vec4<f32>(x_148.x, x_148.y, x_148.z, x_139);
      x_199_phi = x_154;
    }
  }
  var x_178 : vec4<f32>;
  var x_200_phi : vec4<f32>;
  let x_199 : vec4<f32> = x_199_phi;
  let x_83 : f32 = x_78.field0;
  if ((x_83 > 0.0)) {
    x_91 = x_78.field1;
    x_201_phi = x_91;
  } else {
    var x_100 : vec4<f32>;
    let x_99 : vec2<f32> = x_98;
    x_100 = textureSample(x_93, x_95, x_99);
    switch(0u) {
      default: {
        let x_163 : f32 = x_100.w;
        if ((x_163 == 0.0)) {
          x_200_phi = vec4<f32>(0.0, 0.0, 0.0, 0.0);
          break;
        }
        let x_172 : vec3<f32> = (vec3<f32>(x_100.x, x_100.y, x_100.z) / vec3<f32>(x_163, x_163, x_163));
        x_178 = vec4<f32>(x_172.x, x_172.y, x_172.z, x_163);
        x_200_phi = x_178;
      }
    }
    x_200 = x_200_phi;
    x_201_phi = x_200;
  }
  let x_201 : vec4<f32> = x_201_phi;
  let x_107 : vec3<f32> = vec3<f32>(x_199.x, x_199.y, x_199.z);
  let x_110 : vec3<f32> = vec3<f32>(x_201.x, x_201.y, x_201.z);
  let x_116 : f32 = x_201.w;
  let x_117 : vec3<f32> = (((x_107 + x_110) - ((x_107 * 2.0) * x_110)) * x_116);
  x_113 = vec4<f32>(x_117.x, x_117.y, x_117.z, x_116);
  return;
}

struct main_out {
  @location(0)
  x_113_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) x_70_param : vec2<f32>, @location(1) x_98_param : vec2<f32>) -> main_out {
  x_70 = x_70_param;
  x_98 = x_98_param;
  main_1();
  return main_out(x_113);
}
