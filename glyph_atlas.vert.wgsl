struct S {
  field0 : mat4x4<f32>,
  field1 : vec2<f32>,
  @size(8)
  padding : u32,
  field2 : vec4<f32>,
}

@group(0) @binding(0) var<uniform> x_14 : S;

var<private> x_21 : vec2<f32>;

var<private> x_88 : vec2<f32>;

var<private> x_91 : vec2<f32>;

var<private> x_105 : vec2<f32>;

var<private> x_107 : vec2<f32>;

var<private> x_108 : vec2<f32>;

var<private> x_110 : vec2<f32>;

var<private> x_111 : vec2<f32>;

var<private> x_113 : vec2<f32>;

var<private> x_117 : vec4<f32>;

var<private> gl_Position : vec4<f32>;

fn main_1() {
  let x_19 : vec4<f32> = x_14.field0[0i];
  let x_26 : f32 = x_21.x;
  let x_30 : vec4<f32> = x_14.field0[1i];
  let x_33 : f32 = x_21.y;
  let x_38 : vec4<f32> = x_14.field0[3i];
  let x_39 : vec4<f32> = (((x_19 * x_26) + (x_30 * x_33)) + x_38);
  let x_48 : vec4<f32> = x_14.field0[2i];
  let x_55 : f32 = x_14.field0[3i].w;
  let x_90 : f32 = x_88.x;
  let x_93 : f32 = x_91.x;
  let x_96 : f32 = x_88.y;
  let x_98 : f32 = x_91.y;
  gl_Position = (mat4x4<f32>(x_19, x_30, x_48, vec4<f32>(x_39.x, x_39.y, x_39.z, x_55)) * vec4<f32>((x_90 * x_93), (x_96 * x_98), 0.0, 1.0));
  let x_106 : vec2<f32> = x_88;
  x_105 = x_106;
  let x_109 : vec2<f32> = x_108;
  x_107 = x_109;
  let x_112 : vec2<f32> = x_111;
  x_110 = x_112;
  let x_116 : vec2<f32> = x_14.field1;
  x_113 = x_116;
  let x_119 : vec4<f32> = x_14.field2;
  x_117 = x_119;
  return;
}

struct main_out {
  @builtin(position)
  gl_Position : vec4<f32>,
  @location(0)
  x_105_1 : vec2<f32>,
  @location(1)
  x_107_1 : vec2<f32>,
  @location(2)
  x_110_1 : vec2<f32>,
  @location(3)
  x_113_1 : vec2<f32>,
  @location(4)
  x_117_1 : vec4<f32>,
}

@stage(vertex)
fn main(@location(1) x_21_param : vec2<f32>, @location(0) x_88_param : vec2<f32>, @location(2) x_91_param : vec2<f32>, @location(3) x_108_param : vec2<f32>, @location(4) x_111_param : vec2<f32>) -> main_out {
  x_21 = x_21_param;
  x_88 = x_88_param;
  x_91 = x_91_param;
  x_108 = x_108_param;
  x_111 = x_111_param;
  main_1();
  return main_out(gl_Position, x_105, x_107, x_110, x_113, x_117);
}
