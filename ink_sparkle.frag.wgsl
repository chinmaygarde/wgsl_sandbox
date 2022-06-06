struct S {
  field0 : vec4<f32>,
  field1 : f32,
  @size(12)
  padding : u32,
  field2 : vec4<f32>,
  field3 : f32,
  field4 : f32,
  field5 : vec2<f32>,
  field6 : f32,
  field7 : f32,
  field8 : vec2<f32>,
  field9 : vec2<f32>,
  field10 : f32,
  @size(4)
  padding_1 : u32,
  field11 : vec2<f32>,
  field12 : vec2<f32>,
  field13 : vec2<f32>,
  field14 : vec2<f32>,
  field15 : vec2<f32>,
  field16 : vec2<f32>,
}

@group(0) @binding(0) var<uniform> x_290 : S;

var<private> x_2 : vec4<f32>;

var<private> x_469 : vec4<f32>;

fn main_1() {
  let x_356 : vec4<f32> = x_2;
  let x_357 : vec2<f32> = vec2<f32>(x_356.x, x_356.y);
  let x_362 : vec2<f32> = x_290.field8;
  let x_363 : vec2<f32> = (x_357 * x_362);
  let x_369 : vec2<f32> = x_290.field9;
  let x_376 : f32 = x_290.field7;
  let x_379 : f32 = x_290.field6;
  let x_380 : f32 = (x_376 * x_379);
  let x_502 : vec2<f32> = (x_363 * vec2<f32>(0.800000012, 0.800000012));
  let x_505 : vec2<f32> = x_290.field11;
  let x_507 : vec2<f32> = x_290.field14;
  let x_574 : f32 = x_507.x;
  let x_576 : f32 = x_507.y;
  let x_602 : f32 = (1.0 - smoothstep(-0.7265625, 2.7265625, (distance(((((mat2x2<f32>(vec2<f32>(x_574, -(x_576)), vec2<f32>(x_576, x_574)) * (x_505 - x_502)) + x_505) - (vec2<f32>(0.170000002, 0.170000002) * floor((((mat2x2<f32>(vec2<f32>(x_574, -(x_576)), vec2<f32>(x_576, x_574)) * (x_505 - x_502)) + x_505) / vec2<f32>(0.170000002, 0.170000002))))) * vec2<f32>(1.25, 1.25)), vec2<f32>(0.106250003, 0.106250003)) * 14.4796381)));
  let x_511 : vec2<f32> = x_290.field12;
  let x_513 : vec2<f32> = x_290.field15;
  let x_643 : f32 = x_513.x;
  let x_645 : f32 = x_513.y;
  let x_517 : vec2<f32> = x_290.field13;
  let x_519 : vec2<f32> = x_290.field16;
  let x_712 : f32 = x_519.x;
  let x_714 : f32 = x_519.y;
  let x_389 : f32 = (0.050000001 * x_376);
  let x_395 : vec2<f32> = x_290.field5;
  let x_401 : f32 = x_290.field4;
  let x_782 : f32 = (x_401 * 0.5);
  let x_785 : f32 = distance(x_357, x_395);
  let x_787 : f32 = (1.0 - x_782);
  let x_789 : f32 = (1.0 + x_782);
  let x_409 : f32 = x_290.field10;
  let x_874 : vec2<f32> = fract(((x_363 - (x_357 - (x_369 * floor((x_357 / x_369))))) * vec2<f32>(5.398700237, 5.442100048)));
  let x_879 : f32 = dot(vec2<f32>(x_874.y, x_874.x), (x_874 + vec2<f32>(21.535100937, 14.313699722)));
  let x_882 : vec2<f32> = (x_874 + vec2<f32>(x_879, x_879));
  let x_887 : f32 = (x_882.x * x_882.y);
  let x_895 : f32 = ((fract((x_887 * 95.430702209)) + fract((x_887 * 75.049606323))) - 1.0);
  let x_844 : f32 = (x_895 + sin((3.141592741 * (x_409 + 0.349999994))));
  let x_853 : f32 = (x_895 + sin((3.141592741 * (x_409 + 0.699999988))));
  let x_862 : f32 = (x_895 + sin((3.141592741 * (x_409 + 1.049999952))));
  let x_417 : f32 = x_290.field3;
  let x_418 : f32 = ((((clamp(((((step(0.0, x_895) * (1.0 - step(0.050000001, x_895))) + (step(0.100000001, x_844) * (1.0 - step(0.150000006, x_844)))) + (step(0.200000003, x_853) * (1.0 - step(0.25, x_853)))) + (step(0.300000012, x_862) * (1.0 - step(0.349999994, x_862)))), 0.0, 1.0) * 0.550000012) * clamp(((1.0 - smoothstep(x_787, x_789, (x_785 / (x_380 + x_389)))) - (1.0 - smoothstep(x_787, x_789, (x_785 / max((x_380 - x_389), 0.0))))), 0.0, 1.0)) * clamp((0.449999988 + ((((x_602 * x_602) + (1.0 - smoothstep(-1.03125, 3.03125, (distance(((((mat2x2<f32>(vec2<f32>(x_643, -(x_645)), vec2<f32>(x_645, x_643)) * (x_511 - x_502)) + x_511) - (vec2<f32>(0.200000003, 0.200000003) * floor((((mat2x2<f32>(vec2<f32>(x_643, -(x_645)), vec2<f32>(x_645, x_643)) * (x_511 - x_502)) + x_511) / vec2<f32>(0.200000003, 0.200000003))))) * vec2<f32>(1.25, 1.25)), vec2<f32>(0.125, 0.125)) * 12.307692528)))) - (1.0 - smoothstep(-1.792968512, 3.792968512, (distance(((((mat2x2<f32>(vec2<f32>(x_712, -(x_714)), vec2<f32>(x_714, x_712)) * (x_517 - x_502)) + x_517) - (vec2<f32>(0.275000006, 0.275000006) * floor((((mat2x2<f32>(vec2<f32>(x_712, -(x_714)), vec2<f32>(x_714, x_712)) * (x_517 - x_502)) + x_517) / vec2<f32>(0.275000006, 0.275000006))))) * vec2<f32>(1.25, 1.25)), vec2<f32>(0.171875, 0.171875)) * 8.951049805)))) * 0.400000006)), 0.0, 1.0)) * x_417);
  let x_433 : f32 = x_290.field1;
  let x_438 : f32 = x_290.field0.w;
  let x_439 : f32 = (((1.0 - smoothstep(x_787, x_789, (x_785 / x_380))) * x_433) * x_438);
  let x_445 : vec4<f32> = x_290.field0;
  let x_448 : vec3<f32> = (vec3<f32>(x_445.x, x_445.y, x_445.z) * x_439);
  let x_457 : vec4<f32> = x_290.field2;
  let x_460 : f32 = x_290.field2.w;
  let x_461 : vec3<f32> = (vec3<f32>(x_457.x, x_457.y, x_457.z) * x_460);
  x_469 = mix(vec4<f32>(x_448.x, x_448.y, x_448.z, x_439), vec4<f32>(x_461.x, x_461.y, x_461.z, x_460), vec4<f32>(x_418, x_418, x_418, x_418));
  return;
}

struct main_out {
  @location(0)
  x_469_1 : vec4<f32>,
}

@stage(fragment)
fn main(@builtin(position) x_2_param : vec4<f32>) -> main_out {
  x_2 = x_2_param;
  main_1();
  return main_out(x_469);
}
