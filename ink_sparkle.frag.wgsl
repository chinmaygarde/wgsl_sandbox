struct Uniforms {
  color : vec4<f32>,
  alpha : f32,
  @size(12)
  padding : u32,
  sparkle_color : vec4<f32>,
  sparkle_alpha : f32,
  blur : f32,
  center : vec2<f32>,
  radius_scale : f32,
  max_radius : f32,
  resolution_scale : vec2<f32>,
  noise_scale : vec2<f32>,
  noise_phase : f32,
  @size(4)
  padding_1 : u32,
  circle1 : vec2<f32>,
  circle2 : vec2<f32>,
  circle3 : vec2<f32>,
  rotation1 : vec2<f32>,
  rotation2 : vec2<f32>,
  rotation3 : vec2<f32>,
}

@group(0) @binding(0) var<uniform> u : Uniforms;

var<private> gl_FragCoord : vec4<f32>;

var<private> fragColor : vec4<f32>;

fn rotate2d_vf2_(rad : ptr<function, vec2<f32>>) -> mat2x2<f32> {
  let x_115 : f32 = (*(rad)).x;
  let x_117 : f32 = (*(rad)).y;
  let x_120 : f32 = (*(rad)).y;
  let x_122 : f32 = (*(rad)).x;
  return mat2x2<f32>(vec2<f32>(x_115, -(x_117)), vec2<f32>(x_120, x_122));
}

fn soft_circle_vf2_vf2_f1_f1_(uv : ptr<function, vec2<f32>>, xy : ptr<function, vec2<f32>>, radius : ptr<function, f32>, blur : ptr<function, f32>) -> f32 {
  var blur_half : f32;
  var d : f32;
  let x_129 : f32 = *(blur);
  blur_half = (x_129 * 0.5);
  let x_133 : vec2<f32> = *(uv);
  let x_134 : vec2<f32> = *(xy);
  d = distance(x_133, x_134);
  let x_136 : f32 = blur_half;
  let x_138 : f32 = blur_half;
  let x_140 : f32 = d;
  let x_141 : f32 = *(radius);
  return (1.0 - smoothstep((1.0 - x_136), (1.0 + x_138), (x_140 / x_141)));
}

fn circle_grid_vf2_vf2_vf2_vf2_f1_(resolution : ptr<function, vec2<f32>>, p : ptr<function, vec2<f32>>, xy_2 : ptr<function, vec2<f32>>, rotation : ptr<function, vec2<f32>>, cell_diameter : ptr<function, f32>) -> f32 {
  var param_9 : vec2<f32>;
  var cell_uv : f32;
  var r : f32;
  var param_10 : vec2<f32>;
  var param_11 : vec2<f32>;
  var param_12 : f32;
  var param_13 : f32;
  let x_180 : vec2<f32> = *(rotation);
  param_9 = x_180;
  let x_181 : mat2x2<f32> = rotate2d_vf2_(&(param_9));
  let x_182 : vec2<f32> = *(xy_2);
  let x_183 : vec2<f32> = *(p);
  let x_186 : vec2<f32> = *(xy_2);
  *(p) = ((x_181 * (x_182 - x_183)) + x_186);
  let x_188 : vec2<f32> = *(p);
  let x_189 : f32 = *(cell_diameter);
  let x_192 : vec2<f32> = *(resolution);
  *(p) = ((x_188 - (vec2<f32>(x_189, x_189) * floor((x_188 / vec2<f32>(x_189, x_189))))) / x_192);
  let x_195 : f32 = *(cell_diameter);
  let x_197 : f32 = (*(resolution)).y;
  cell_uv = ((x_195 / x_197) * 0.5);
  let x_202 : f32 = cell_uv;
  r = (0.649999976 * x_202);
  let x_204 : f32 = cell_uv;
  let x_206 : f32 = r;
  let x_210 : vec2<f32> = *(p);
  param_10 = x_210;
  param_11 = vec2<f32>(x_204, x_204);
  let x_213 : f32 = r;
  param_12 = x_213;
  param_13 = (x_206 * 50.0);
  let x_215 : f32 = soft_circle_vf2_vf2_f1_f1_(&(param_10), &(param_11), &(param_12), &(param_13));
  return x_215;
}

fn saturate_f1_(x : ptr<function, f32>) -> f32 {
  let x_60 : f32 = *(x);
  return clamp(x_60, 0.0, 1.0);
}

fn turbulence_vf2_(uv_3 : ptr<function, vec2<f32>>) -> f32 {
  var uv_scale : vec2<f32>;
  var g1 : f32;
  var param_28 : vec2<f32>;
  var param_29 : vec2<f32>;
  var param_30 : vec2<f32>;
  var param_31 : vec2<f32>;
  var param_32 : f32;
  var g2 : f32;
  var param_33 : vec2<f32>;
  var param_34 : vec2<f32>;
  var param_35 : vec2<f32>;
  var param_36 : vec2<f32>;
  var param_37 : f32;
  var g3 : f32;
  var param_38 : vec2<f32>;
  var param_39 : vec2<f32>;
  var param_40 : vec2<f32>;
  var param_41 : vec2<f32>;
  var param_42 : f32;
  var v_1 : f32;
  var param_43 : f32;
  let x_282 : vec2<f32> = *(uv_3);
  uv_scale = (x_282 * vec2<f32>(0.800000012, 0.800000012));
  param_28 = vec2<f32>(0.800000012, 0.800000012);
  let x_297 : vec2<f32> = uv_scale;
  param_29 = x_297;
  let x_301 : vec2<f32> = u.circle1;
  param_30 = x_301;
  let x_304 : vec2<f32> = u.rotation1;
  param_31 = x_304;
  param_32 = 0.170000002;
  let x_306 : f32 = circle_grid_vf2_vf2_vf2_vf2_f1_(&(param_28), &(param_29), &(param_30), &(param_31), &(param_32));
  g1 = x_306;
  param_33 = vec2<f32>(0.800000012, 0.800000012);
  let x_312 : vec2<f32> = uv_scale;
  param_34 = x_312;
  let x_315 : vec2<f32> = u.circle2;
  param_35 = x_315;
  let x_318 : vec2<f32> = u.rotation2;
  param_36 = x_318;
  param_37 = 0.200000003;
  let x_320 : f32 = circle_grid_vf2_vf2_vf2_vf2_f1_(&(param_33), &(param_34), &(param_35), &(param_36), &(param_37));
  g2 = x_320;
  param_38 = vec2<f32>(0.800000012, 0.800000012);
  let x_327 : vec2<f32> = uv_scale;
  param_39 = x_327;
  let x_330 : vec2<f32> = u.circle3;
  param_40 = x_330;
  let x_333 : vec2<f32> = u.rotation3;
  param_41 = x_333;
  param_42 = 0.275000006;
  let x_335 : f32 = circle_grid_vf2_vf2_vf2_vf2_f1_(&(param_38), &(param_39), &(param_40), &(param_41), &(param_42));
  g3 = x_335;
  let x_337 : f32 = g1;
  let x_338 : f32 = g1;
  let x_340 : f32 = g2;
  let x_342 : f32 = g3;
  v_1 = ((((x_337 * x_338) + x_340) - x_342) * 0.5);
  let x_346 : f32 = v_1;
  param_43 = (0.449999988 + (0.800000012 * x_346));
  let x_350 : f32 = saturate_f1_(&(param_43));
  return x_350;
}

fn soft_ring_vf2_vf2_f1_f1_f1_(uv_1 : ptr<function, vec2<f32>>, xy_1 : ptr<function, vec2<f32>>, radius_1 : ptr<function, f32>, thickness : ptr<function, f32>, blur_1 : ptr<function, f32>) -> f32 {
  var circle_outer : f32;
  var param : vec2<f32>;
  var param_1 : vec2<f32>;
  var param_2 : f32;
  var param_3 : f32;
  var circle_inner : f32;
  var param_4 : vec2<f32>;
  var param_5 : vec2<f32>;
  var param_6 : f32;
  var param_7 : f32;
  var param_8 : f32;
  let x_148 : f32 = *(radius_1);
  let x_149 : f32 = *(thickness);
  let x_152 : vec2<f32> = *(uv_1);
  param = x_152;
  let x_154 : vec2<f32> = *(xy_1);
  param_1 = x_154;
  param_2 = (x_148 + x_149);
  let x_157 : f32 = *(blur_1);
  param_3 = x_157;
  let x_158 : f32 = soft_circle_vf2_vf2_f1_f1_(&(param), &(param_1), &(param_2), &(param_3));
  circle_outer = x_158;
  let x_160 : f32 = *(radius_1);
  let x_161 : f32 = *(thickness);
  let x_165 : vec2<f32> = *(uv_1);
  param_4 = x_165;
  let x_167 : vec2<f32> = *(xy_1);
  param_5 = x_167;
  param_6 = max((x_160 - x_161), 0.0);
  let x_170 : f32 = *(blur_1);
  param_7 = x_170;
  let x_171 : f32 = soft_circle_vf2_vf2_f1_f1_(&(param_4), &(param_5), &(param_6), &(param_7));
  circle_inner = x_171;
  let x_172 : f32 = circle_outer;
  let x_173 : f32 = circle_inner;
  param_8 = (x_172 - x_173);
  let x_176 : f32 = saturate_f1_(&(param_8));
  return x_176;
}

fn triangle_noise_vf2_(n : ptr<function, vec2<f32>>) -> f32 {
  var xy_3 : f32;
  let x_66 : vec2<f32> = *(n);
  *(n) = fract((x_66 * vec2<f32>(5.398700237, 5.442100048)));
  let x_72 : vec2<f32> = *(n);
  let x_74 : vec2<f32> = *(n);
  let x_79 : f32 = dot(vec2<f32>(x_72.y, x_72.x), (x_74 + vec2<f32>(21.535100937, 14.313699722)));
  let x_80 : vec2<f32> = *(n);
  *(n) = (x_80 + vec2<f32>(x_79, x_79));
  let x_87 : f32 = (*(n)).x;
  let x_90 : f32 = (*(n)).y;
  xy_3 = (x_87 * x_90);
  let x_92 : f32 = xy_3;
  let x_96 : f32 = xy_3;
  return ((fract((x_92 * 95.430702209)) + fract((x_96 * 75.049606323))) - 1.0);
}

fn threshold_f1_f1_f1_(v : ptr<function, f32>, l : ptr<function, f32>, h : ptr<function, f32>) -> f32 {
  let x_104 : f32 = *(l);
  let x_105 : f32 = *(v);
  let x_107 : f32 = *(h);
  let x_108 : f32 = *(v);
  return (step(x_104, x_105) * (1.0 - step(x_107, x_108)));
}

fn sparkle_vf2_f1_(uv_2 : ptr<function, vec2<f32>>, t : ptr<function, f32>) -> f32 {
  var n_1 : f32;
  var param_14 : vec2<f32>;
  var s : f32;
  var param_15 : f32;
  var param_16 : f32;
  var param_17 : f32;
  var param_18 : f32;
  var param_19 : f32;
  var param_20 : f32;
  var param_21 : f32;
  var param_22 : f32;
  var param_23 : f32;
  var param_24 : f32;
  var param_25 : f32;
  var param_26 : f32;
  var param_27 : f32;
  let x_220 : vec2<f32> = *(uv_2);
  param_14 = x_220;
  let x_221 : f32 = triangle_noise_vf2_(&(param_14));
  n_1 = x_221;
  let x_225 : f32 = n_1;
  param_15 = x_225;
  param_16 = 0.0;
  param_17 = 0.050000001;
  let x_228 : f32 = threshold_f1_f1_f1_(&(param_15), &(param_16), &(param_17));
  s = x_228;
  let x_229 : f32 = n_1;
  let x_231 : f32 = *(t);
  param_18 = (x_229 + sin((3.141592741 * (x_231 + 0.349999994))));
  param_19 = 0.100000001;
  param_20 = 0.150000006;
  let x_242 : f32 = threshold_f1_f1_f1_(&(param_18), &(param_19), &(param_20));
  let x_243 : f32 = s;
  s = (x_243 + x_242);
  let x_245 : f32 = n_1;
  let x_246 : f32 = *(t);
  param_21 = (x_245 + sin((3.141592741 * (x_246 + 0.699999988))));
  param_22 = 0.200000003;
  param_23 = 0.25;
  let x_257 : f32 = threshold_f1_f1_f1_(&(param_21), &(param_22), &(param_23));
  let x_258 : f32 = s;
  s = (x_258 + x_257);
  let x_260 : f32 = n_1;
  let x_261 : f32 = *(t);
  param_24 = (x_260 + sin((3.141592741 * (x_261 + 1.049999952))));
  param_25 = 0.300000012;
  param_26 = 0.349999994;
  let x_271 : f32 = threshold_f1_f1_f1_(&(param_24), &(param_25), &(param_26));
  let x_272 : f32 = s;
  s = (x_272 + x_271);
  let x_275 : f32 = s;
  param_27 = x_275;
  let x_276 : f32 = saturate_f1_(&(param_27));
  return (x_276 * 0.550000012);
}

fn main_1() {
  var p_1 : vec2<f32>;
  var uv_4 : vec2<f32>;
  var density_uv : vec2<f32>;
  var radius_2 : f32;
  var turbulence : f32;
  var param_44 : vec2<f32>;
  var ring : f32;
  var param_45 : vec2<f32>;
  var param_46 : vec2<f32>;
  var param_47 : f32;
  var param_48 : f32;
  var param_49 : f32;
  var sparkle : f32;
  var param_50 : vec2<f32>;
  var param_51 : f32;
  var wave_alpha : f32;
  var param_52 : vec2<f32>;
  var param_53 : vec2<f32>;
  var param_54 : f32;
  var param_55 : f32;
  var wave_color : vec4<f32>;
  var sparkle_color : vec4<f32>;
  let x_356 : vec4<f32> = gl_FragCoord;
  p_1 = vec2<f32>(x_356.x, x_356.y);
  let x_359 : vec2<f32> = p_1;
  let x_362 : vec2<f32> = u.resolution_scale;
  uv_4 = (x_359 * x_362);
  let x_365 : vec2<f32> = uv_4;
  let x_366 : vec2<f32> = p_1;
  let x_369 : vec2<f32> = u.noise_scale;
  density_uv = (x_365 - (x_366 - (x_369 * floor((x_366 / x_369)))));
  let x_376 : f32 = u.max_radius;
  let x_379 : f32 = u.radius_scale;
  radius_2 = (x_376 * x_379);
  let x_383 : vec2<f32> = uv_4;
  param_44 = x_383;
  let x_384 : f32 = turbulence_vf2_(&(param_44));
  turbulence = x_384;
  let x_388 : f32 = u.max_radius;
  let x_392 : vec2<f32> = p_1;
  param_45 = x_392;
  let x_395 : vec2<f32> = u.center;
  param_46 = x_395;
  let x_397 : f32 = radius_2;
  param_47 = x_397;
  param_48 = (0.050000001 * x_388);
  let x_401 : f32 = u.blur;
  param_49 = x_401;
  let x_402 : f32 = soft_ring_vf2_vf2_f1_f1_f1_(&(param_45), &(param_46), &(param_47), &(param_48), &(param_49));
  ring = x_402;
  let x_406 : vec2<f32> = density_uv;
  param_50 = x_406;
  let x_409 : f32 = u.noise_phase;
  param_51 = x_409;
  let x_410 : f32 = sparkle_vf2_f1_(&(param_50), &(param_51));
  let x_411 : f32 = ring;
  let x_413 : f32 = turbulence;
  let x_417 : f32 = u.sparkle_alpha;
  sparkle = (((x_410 * x_411) * x_413) * x_417);
  let x_421 : vec2<f32> = p_1;
  param_52 = x_421;
  let x_424 : vec2<f32> = u.center;
  param_53 = x_424;
  let x_426 : f32 = radius_2;
  param_54 = x_426;
  let x_429 : f32 = u.blur;
  param_55 = x_429;
  let x_430 : f32 = soft_circle_vf2_vf2_f1_f1_(&(param_52), &(param_53), &(param_54), &(param_55));
  let x_433 : f32 = u.alpha;
  let x_438 : f32 = u.color.w;
  wave_alpha = ((x_430 * x_433) * x_438);
  let x_445 : vec4<f32> = u.color;
  let x_447 : f32 = wave_alpha;
  let x_448 : vec3<f32> = (vec3<f32>(x_445.x, x_445.y, x_445.z) * x_447);
  let x_449 : f32 = wave_alpha;
  wave_color = vec4<f32>(x_448.x, x_448.y, x_448.z, x_449);
  let x_457 : vec4<f32> = u.sparkle_color;
  let x_460 : f32 = u.sparkle_color.w;
  let x_461 : vec3<f32> = (vec3<f32>(x_457.x, x_457.y, x_457.z) * x_460);
  let x_463 : f32 = u.sparkle_color.w;
  sparkle_color = vec4<f32>(x_461.x, x_461.y, x_461.z, x_463);
  let x_470 : vec4<f32> = wave_color;
  let x_471 : vec4<f32> = sparkle_color;
  let x_472 : f32 = sparkle;
  fragColor = mix(x_470, x_471, vec4<f32>(x_472, x_472, x_472, x_472));
  return;
}

struct main_out {
  @location(0)
  fragColor_1 : vec4<f32>,
}

@stage(fragment)
fn main(@builtin(position) gl_FragCoord_param : vec4<f32>) -> main_out {
  gl_FragCoord = gl_FragCoord_param;
  main_1();
  return main_out(fragColor);
}
