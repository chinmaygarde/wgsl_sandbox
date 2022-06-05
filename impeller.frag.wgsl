struct FragInfo {
  texture_size : vec2<f32>,
  time : f32,
}

@group(0) @binding(2) var blue_noise : texture_2d<f32>;

@group(0) @binding(3) var blue_noise_smplr : sampler;

@group(0) @binding(4) var<uniform> frag_info : FragInfo;

@group(0) @binding(0) var cube_map : texture_3d<f32>;

@group(0) @binding(1) var cube_map_smplr : sampler;

var<private> v_screen_position : vec2<f32>;

var<private> frag_color : vec4<f32>;

fn GetFragDirection_vf2_vf3_(uv_1 : ptr<function, vec2<f32>>, cam_forward : ptr<function, vec3<f32>>) -> vec3<f32> {
  var lens_uv : vec2<f32>;
  var cam_right : vec3<f32>;
  var cam_up : vec3<f32>;
  var fov : f32;
  let x_1187 : vec2<f32> = *(uv_1);
  let x_1190 : vec2<f32> = frag_info.texture_size;
  let x_1194 : vec2<f32> = frag_info.texture_size;
  lens_uv = ((x_1187 - (x_1190 * 0.5)) / vec2<f32>(x_1194.x, x_1194.x));
  let x_1198 : vec3<f32> = *(cam_forward);
  cam_right = cross(x_1198, vec3<f32>(0.0, 1.0, 0.0));
  let x_1201 : vec3<f32> = *(cam_forward);
  let x_1202 : vec3<f32> = cam_right;
  cam_up = cross(x_1201, x_1202);
  fov = 1.134464025;
  let x_1206 : vec3<f32> = *(cam_forward);
  let x_1207 : f32 = fov;
  let x_1210 : vec3<f32> = cam_right;
  let x_1212 : f32 = lens_uv.x;
  let x_1214 : f32 = fov;
  let x_1218 : vec3<f32> = cam_up;
  let x_1220 : f32 = lens_uv.y;
  let x_1222 : f32 = fov;
  return normalize((((x_1206 * cos(x_1207)) + ((x_1210 * x_1212) * sin(x_1214))) + ((x_1218 * x_1220) * sin(x_1222))));
}

fn Hash_f1_(seed : ptr<function, f32>) -> vec2<f32> {
  var n : vec2<f32>;
  let x_240 : f32 = *(seed);
  let x_247 : f32 = *(seed);
  n = vec2<f32>(dot(vec2<f32>(x_240, -0.100000001), vec2<f32>(13.876796722, 22.209148407)), dot(vec2<f32>(x_247, -0.200000003), vec2<f32>(12.343221664, 48.057937622)));
  let x_255 : vec2<f32> = n;
  return fract((sin(x_255) * 24791.81640625));
}

fn BlueNoise_vf2_(uv : ptr<function, vec2<f32>>) -> vec4<f32> {
  let x_272 : vec2<f32> = *(uv);
  let x_273 : vec4<f32> = textureSample(blue_noise, blue_noise_smplr, x_272);
  return x_273;
}

fn BlueNoiseWithRandomOffset_vf2_f1_(screen_position : ptr<function, vec2<f32>>, seed_1 : ptr<function, f32>) -> vec4<f32> {
  var param : f32;
  var param_1 : vec2<f32>;
  let x_276 : vec2<f32> = *(screen_position);
  let x_281 : f32 = *(seed_1);
  param = x_281;
  let x_282 : vec2<f32> = Hash_f1_(&(param));
  param_1 = ((x_276 / vec2<f32>(256.0, 256.0)) + x_282);
  let x_285 : vec4<f32> = BlueNoise_vf2_(&(param_1));
  return x_285;
}

fn CuboidDistance_vf3_vf3_(sample_position_1 : ptr<function, vec3<f32>>, cuboid_size : ptr<function, vec3<f32>>) -> f32 {
  var space : vec3<f32>;
  let x_297 : vec3<f32> = *(sample_position_1);
  let x_299 : vec3<f32> = *(cuboid_size);
  space = (abs(x_297) - x_299);
  let x_301 : vec3<f32> = space;
  let x_306 : f32 = space.x;
  let x_308 : f32 = space.y;
  let x_310 : f32 = space.z;
  return (length(max(x_301, vec3<f32>(0.0, 0.0, 0.0))) + min(max(x_306, max(x_308, x_310)), 0.0));
}

fn FlutterLogoField_vf3_(pos_1 : ptr<function, vec3<f32>>) -> vec2<f32> {
  var r_1 : vec3<f32>;
  var logo_basis : mat3x3<f32>;
  var logo_pos : vec3<f32>;
  var logo0 : f32;
  var param_5 : vec3<f32>;
  var param_6 : vec3<f32>;
  var logo0_cutoff_plane : f32;
  var dist_1 : f32;
  var material_2 : f32;
  var logo1 : f32;
  var param_7 : vec3<f32>;
  var param_8 : vec3<f32>;
  var logo1_cutoff_plane : f32;
  var material_cutoff_plane : f32;
  var logo2 : f32;
  var param_9 : vec3<f32>;
  var param_10 : vec3<f32>;
  let x_360 : vec3<f32> = *(pos_1);
  *(pos_1) = (x_360 * 1.299999952);
  let x_364 : f32 = frag_info.time;
  let x_371 : f32 = frag_info.time;
  let x_380 : f32 = frag_info.time;
  r_1 = vec3<f32>((sin((x_364 * 1.136999965)) / 7.0), (sin(((x_371 * 1.398000002) + 0.699999988)) / 8.0), (sin(((x_380 * 0.873000026) + 0.300000012)) / 5.0));
  let x_391 : f32 = r_1.z;
  let x_394 : f32 = r_1.y;
  let x_398 : f32 = r_1.z;
  let x_401 : f32 = r_1.y;
  let x_405 : f32 = r_1.z;
  let x_409 : f32 = r_1.z;
  let x_412 : f32 = r_1.x;
  let x_416 : f32 = r_1.x;
  let x_420 : f32 = r_1.y;
  let x_423 : f32 = r_1.x;
  let x_426 : f32 = r_1.x;
  let x_429 : f32 = r_1.y;
  logo_basis = mat3x3<f32>(vec3<f32>((cos(x_391) * cos(x_394)), sin(x_398), -(sin(x_401))), vec3<f32>(-(sin(x_405)), (cos(x_409) * cos(x_412)), -(sin(x_416))), vec3<f32>(sin(x_420), sin(x_423), (cos(x_426) * cos(x_429))));
  let x_437 : mat3x3<f32> = logo_basis;
  let x_438 : vec3<f32> = *(pos_1);
  let x_443 : f32 = frag_info.time;
  logo_pos = ((x_437 * x_438) + vec3<f32>(-1.0, (-4.0 + sin(x_443)), 0.0));
  let x_449 : vec3<f32> = logo_pos;
  let x_451 : f32 = logo_pos.y;
  param_5 = (x_449 + vec3<f32>(-(x_451), 0.0, 0.0));
  param_6 = vec3<f32>(1.0, 2.0, 0.600000024);
  let x_460 : f32 = CuboidDistance_vf3_vf3_(&(param_5), &(param_6));
  logo0 = (x_460 * 0.543928266);
  let x_464 : vec3<f32> = logo_pos;
  logo0_cutoff_plane = dot((x_464 + vec3<f32>(0.5, 0.5, 0.0)), vec3<f32>(0.707106769, 0.707106769, 0.0));
  let x_471 : f32 = logo0;
  let x_472 : f32 = logo0_cutoff_plane;
  logo0 = max(x_471, x_472);
  let x_475 : f32 = logo0;
  dist_1 = x_475;
  material_2 = 1.0;
  let x_478 : vec3<f32> = logo_pos;
  let x_480 : f32 = logo_pos.y;
  param_7 = (x_478 + vec3<f32>(x_480, 0.0, 0.0));
  param_8 = vec3<f32>(1.0, 2.0, 0.699999988);
  let x_486 : f32 = CuboidDistance_vf3_vf3_(&(param_7), &(param_8));
  logo1 = (x_486 * 0.543928266);
  let x_489 : vec3<f32> = logo_pos;
  logo1_cutoff_plane = dot((x_489 + vec3<f32>(-0.5, 0.5, 0.0)), vec3<f32>(0.707106769, -0.707106769, 0.0));
  let x_496 : f32 = logo1;
  let x_497 : f32 = logo1_cutoff_plane;
  logo1 = max(x_496, x_497);
  let x_499 : f32 = logo1;
  let x_500 : f32 = dist_1;
  if ((x_499 < x_500)) {
    let x_504 : f32 = logo1;
    dist_1 = x_504;
    let x_506 : vec3<f32> = logo_pos;
    material_cutoff_plane = dot((x_506 + vec3<f32>(0.5, -0.5, 0.0)), vec3<f32>(0.707106769, -0.707106769, 0.0));
    let x_510 : f32 = material_cutoff_plane;
    material_2 = select(3.0, 2.0, (x_510 > 0.0));
  }
  let x_514 : vec3<f32> = logo_pos;
  let x_516 : f32 = logo_pos.y;
  param_9 = (x_514 + vec3<f32>((x_516 - 3.0), -2.0, 0.0));
  param_10 = vec3<f32>(1.0, 3.5, 0.699999988);
  let x_525 : f32 = CuboidDistance_vf3_vf3_(&(param_9), &(param_10));
  logo2 = (x_525 * 0.543928266);
  let x_527 : f32 = logo2;
  let x_528 : f32 = logo1_cutoff_plane;
  logo2 = max(x_527, x_528);
  let x_530 : f32 = logo2;
  let x_531 : f32 = dist_1;
  if ((x_530 < x_531)) {
    let x_535 : f32 = logo2;
    dist_1 = x_535;
    material_2 = 3.0;
  }
  let x_536 : f32 = dist_1;
  let x_537 : f32 = material_2;
  return vec2<f32>(x_536, x_537);
}

fn SphereDistance_vf3_vf3_f1_(sample_position : ptr<function, vec3<f32>>, sphere_position : ptr<function, vec3<f32>>, sphere_size : ptr<function, f32>) -> f32 {
  let x_288 : vec3<f32> = *(sample_position);
  let x_289 : vec3<f32> = *(sphere_position);
  let x_292 : f32 = *(sphere_size);
  return (length((x_288 - x_289)) - x_292);
}

fn ImpellerField_vf3_(pos_3 : ptr<function, vec3<f32>>) -> vec2<f32> {
  var xz_dist : f32;
  var impeller : f32;
  var impeller_side : f32;
  var stage_height : f32;
  var stage_plane : f32;
  var stage_sphere : f32;
  var param_13 : vec3<f32>;
  var param_14 : vec3<f32>;
  var param_15 : f32;
  var stage : f32;
  var material_4 : f32;
  var x_641 : bool;
  var x_642_phi : bool;
  let x_569 : vec3<f32> = *(pos_3);
  xz_dist = length(vec2<f32>(x_569.x, x_569.z));
  let x_573 : f32 = xz_dist;
  let x_576 : f32 = xz_dist;
  let x_579 : f32 = frag_info.time;
  let x_586 : f32 = (*(pos_3)).z;
  let x_588 : f32 = (*(pos_3)).x;
  impeller = ((min(0.5, (x_573 / 3.0)) * sin((((x_576 * 2.0) - ((x_579 - (3.141592741 * floor((x_579 / 3.141592741)))) * 30.0)) + (atan2(x_586, x_588) * 6.0)))) * 1.5);
  let x_598 : f32 = xz_dist;
  impeller_side = ((x_598 / 2.0) - 4.0);
  let x_603 : f32 = impeller;
  let x_604 : f32 = impeller_side;
  let x_605 : f32 = xz_dist;
  stage_height = mix(x_603, x_604, clamp((x_605 - 4.599999905), 0.0, 1.0));
  let x_611 : vec3<f32> = *(pos_3);
  let x_612 : f32 = stage_height;
  stage_plane = (dot((x_611 + vec3<f32>(0.0, (3.0 + x_612), 0.0)), vec3<f32>(0.0, 1.0, 0.0)) * 0.5);
  let x_620 : vec3<f32> = *(pos_3);
  param_13 = (x_620 + vec3<f32>(0.0, 2.0, 0.0));
  param_14 = vec3<f32>(0.0, 0.0, 0.0);
  param_15 = 6.0;
  let x_627 : f32 = SphereDistance_vf3_vf3_f1_(&(param_13), &(param_14), &(param_15));
  stage_sphere = x_627;
  let x_629 : f32 = stage_plane;
  let x_630 : f32 = stage_sphere;
  stage = max(x_629, x_630);
  material_4 = 4.0;
  let x_633 : f32 = xz_dist;
  let x_635 : bool = (x_633 < 5.599999905);
  x_642_phi = x_635;
  if (x_635) {
    let x_639 : f32 = (*(pos_3)).y;
    x_641 = (x_639 > -7.0);
    x_642_phi = x_641;
  }
  var x_654 : bool;
  var x_655_phi : bool;
  let x_642 : bool = x_642_phi;
  if (x_642) {
    let x_646 : f32 = (*(pos_3)).y;
    let x_648 : bool = (x_646 > -2.359999895);
    x_655_phi = x_648;
    if (x_648) {
      let x_652 : f32 = (*(pos_3)).y;
      x_654 = (x_652 < -2.099999905);
      x_655_phi = x_654;
    }
    let x_655 : bool = x_655_phi;
    material_4 = select(6.0, 5.0, x_655);
  } else {
    material_4 = 4.0;
  }
  let x_658 : f32 = stage;
  let x_659 : f32 = material_4;
  return vec2<f32>(x_658, x_659);
}

fn ShadowField_vf3_(pos_5 : ptr<function, vec3<f32>>) -> vec2<f32> {
  var flutter_logo_1 : vec2<f32>;
  var param_18 : vec3<f32>;
  var dist_4 : f32;
  var material_6 : f32;
  var impeller_2 : vec2<f32>;
  var param_19 : vec3<f32>;
  let x_693 : vec3<f32> = *(pos_5);
  param_18 = x_693;
  let x_694 : vec2<f32> = FlutterLogoField_vf3_(&(param_18));
  flutter_logo_1 = x_694;
  let x_697 : f32 = flutter_logo_1.x;
  dist_4 = x_697;
  let x_700 : f32 = flutter_logo_1.y;
  material_6 = x_700;
  let x_703 : vec3<f32> = *(pos_5);
  param_19 = x_703;
  let x_704 : vec2<f32> = ImpellerField_vf3_(&(param_19));
  impeller_2 = x_704;
  let x_706 : f32 = impeller_2.x;
  let x_707 : f32 = dist_4;
  if ((x_706 < x_707)) {
    let x_712 : f32 = impeller_2.x;
    dist_4 = x_712;
    let x_714 : f32 = impeller_2.y;
    material_6 = x_714;
  }
  let x_715 : f32 = dist_4;
  let x_716 : f32 = material_6;
  return vec2<f32>(x_715, x_716);
}

fn RotateEuler_vf3_(r : ptr<function, vec3<f32>>) -> mat3x3<f32> {
  let x_122 : f32 = (*(r)).x;
  let x_126 : f32 = (*(r)).y;
  let x_130 : f32 = (*(r)).x;
  let x_133 : f32 = (*(r)).y;
  let x_138 : f32 = (*(r)).z;
  let x_142 : f32 = (*(r)).x;
  let x_145 : f32 = (*(r)).z;
  let x_150 : f32 = (*(r)).x;
  let x_153 : f32 = (*(r)).y;
  let x_157 : f32 = (*(r)).z;
  let x_161 : f32 = (*(r)).x;
  let x_164 : f32 = (*(r)).z;
  let x_169 : f32 = (*(r)).x;
  let x_172 : f32 = (*(r)).y;
  let x_176 : f32 = (*(r)).x;
  let x_179 : f32 = (*(r)).y;
  let x_183 : f32 = (*(r)).z;
  let x_187 : f32 = (*(r)).x;
  let x_190 : f32 = (*(r)).z;
  let x_195 : f32 = (*(r)).x;
  let x_198 : f32 = (*(r)).y;
  let x_202 : f32 = (*(r)).z;
  let x_206 : f32 = (*(r)).x;
  let x_209 : f32 = (*(r)).z;
  let x_214 : f32 = (*(r)).y;
  let x_218 : f32 = (*(r)).y;
  let x_221 : f32 = (*(r)).z;
  let x_225 : f32 = (*(r)).y;
  let x_228 : f32 = (*(r)).z;
  return mat3x3<f32>(vec3<f32>((cos(x_122) * cos(x_126)), (((cos(x_130) * sin(x_133)) * sin(x_138)) - (sin(x_142) * cos(x_145))), (((cos(x_150) * sin(x_153)) * cos(x_157)) + (sin(x_161) * sin(x_164)))), vec3<f32>((sin(x_169) * cos(x_172)), (((sin(x_176) * sin(x_179)) * sin(x_183)) + (cos(x_187) * cos(x_190))), (((sin(x_195) * sin(x_198)) * cos(x_202)) - (cos(x_206) * sin(x_209)))), vec3<f32>(-(sin(x_214)), (cos(x_218) * sin(x_221)), (cos(x_225) * cos(x_228))));
}

fn GlassBox_vf3_(pos : ptr<function, vec3<f32>>) -> f32 {
  var basis : mat3x3<f32>;
  var param_2 : vec3<f32>;
  var glass_box_pos : vec3<f32>;
  var param_3 : vec3<f32>;
  var param_4 : vec3<f32>;
  let x_325 : f32 = frag_info.time;
  let x_329 : f32 = frag_info.time;
  let x_333 : f32 = frag_info.time;
  param_2 = vec3<f32>((x_325 * 0.209999993), (x_329 * 0.239999995), (x_333 * 0.170000002));
  let x_338 : mat3x3<f32> = RotateEuler_vf3_(&(param_2));
  basis = x_338;
  let x_340 : vec3<f32> = *(pos);
  let x_343 : f32 = frag_info.time;
  glass_box_pos = (x_340 + vec3<f32>(0.0, (-4.5 + sin(x_343)), 0.0));
  let x_348 : mat3x3<f32> = basis;
  let x_349 : vec3<f32> = glass_box_pos;
  param_3 = (x_348 * x_349);
  param_4 = vec3<f32>(1.0, 1.0, 1.0);
  let x_354 : f32 = CuboidDistance_vf3_vf3_(&(param_3), &(param_4));
  return (x_354 - 3.0);
}

fn InnerGlassBoxField_vf3_(pos_2 : ptr<function, vec3<f32>>) -> vec2<f32> {
  var flutter_logo : vec2<f32>;
  var param_11 : vec3<f32>;
  var dist_2 : f32;
  var material_3 : f32;
  var glass_box : f32;
  var param_12 : vec3<f32>;
  let x_543 : vec3<f32> = *(pos_2);
  param_11 = x_543;
  let x_544 : vec2<f32> = FlutterLogoField_vf3_(&(param_11));
  flutter_logo = x_544;
  let x_547 : f32 = flutter_logo.x;
  dist_2 = x_547;
  let x_550 : f32 = flutter_logo.y;
  material_3 = x_550;
  let x_553 : vec3<f32> = *(pos_2);
  param_12 = x_553;
  let x_554 : f32 = GlassBox_vf3_(&(param_12));
  glass_box = -(x_554);
  let x_556 : f32 = glass_box;
  let x_557 : f32 = dist_2;
  if ((x_556 < x_557)) {
    let x_561 : f32 = glass_box;
    dist_2 = x_561;
    material_3 = -3.0;
  }
  let x_563 : f32 = dist_2;
  let x_564 : f32 = material_3;
  return vec2<f32>(x_563, x_564);
}

fn SceneField_vf3_(pos_4 : ptr<function, vec3<f32>>) -> vec2<f32> {
  var glass_box_1 : f32;
  var param_16 : vec3<f32>;
  var dist_3 : f32;
  var material_5 : f32;
  var impeller_1 : vec2<f32>;
  var param_17 : vec3<f32>;
  let x_665 : vec3<f32> = *(pos_4);
  param_16 = x_665;
  let x_666 : f32 = GlassBox_vf3_(&(param_16));
  glass_box_1 = x_666;
  let x_668 : f32 = glass_box_1;
  dist_3 = x_668;
  material_5 = -2.0;
  let x_672 : vec3<f32> = *(pos_4);
  param_17 = x_672;
  let x_673 : vec2<f32> = ImpellerField_vf3_(&(param_17));
  impeller_1 = x_673;
  let x_675 : f32 = impeller_1.x;
  let x_676 : f32 = dist_3;
  if ((x_675 < x_676)) {
    let x_681 : f32 = impeller_1.x;
    dist_3 = x_681;
    let x_683 : f32 = impeller_1.y;
    material_5 = x_683;
  }
  let x_684 : f32 = dist_3;
  let x_687 : f32 = material_5;
  return vec2<f32>((x_684 - 0.01), x_687);
}

fn March_vf3_vf3_i1_b1_b1_(sample_position_2 : ptr<function, vec3<f32>>, dir : ptr<function, vec3<f32>>, steps_taken : ptr<function, i32>, inside_glass_box : ptr<function, bool>, shadow : ptr<function, bool>) -> vec2<f32> {
  var depth : f32;
  var i : i32;
  var pos_6 : vec3<f32>;
  var result : vec2<f32>;
  var param_20 : vec3<f32>;
  var x_754 : vec2<f32>;
  var param_21 : vec3<f32>;
  var param_22 : vec3<f32>;
  depth = 0.0;
  i = 0i;
  loop {
    let x_728 : i32 = i;
    if ((x_728 < 70i)) {
    } else {
      break;
    }
    let x_731 : f32 = depth;
    if ((x_731 > 300.0)) {
      let x_736 : i32 = i;
      *(steps_taken) = x_736;
      return vec2<f32>(300.0, -1.0);
    }
    let x_740 : vec3<f32> = *(sample_position_2);
    let x_741 : vec3<f32> = *(dir);
    let x_742 : f32 = depth;
    pos_6 = (x_740 + (x_741 * x_742));
    let x_745 : bool = *(shadow);
    if (x_745) {
      let x_750 : vec3<f32> = pos_6;
      param_20 = x_750;
      let x_751 : vec2<f32> = ShadowField_vf3_(&(param_20));
      result = x_751;
    } else {
      let x_753 : bool = *(inside_glass_box);
      if (x_753) {
        let x_758 : vec3<f32> = pos_6;
        param_21 = x_758;
        let x_759 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_21));
        x_754 = x_759;
      } else {
        let x_762 : vec3<f32> = pos_6;
        param_22 = x_762;
        let x_763 : vec2<f32> = SceneField_vf3_(&(param_22));
        x_754 = x_763;
      }
      let x_764 : vec2<f32> = x_754;
      result = x_764;
    }
    let x_766 : f32 = result.x;
    if ((abs(x_766) < 0.001)) {
      let x_772 : i32 = i;
      *(steps_taken) = x_772;
      let x_773 : f32 = depth;
      let x_775 : f32 = result.y;
      return vec2<f32>(x_773, x_775);
    }
    let x_779 : f32 = result.x;
    let x_780 : f32 = depth;
    depth = (x_780 + x_779);

    continuing {
      let x_782 : i32 = i;
      i = (x_782 + 1i);
    }
  }
  *(steps_taken) = 70i;
  return vec2<f32>(300.0, -1.0);
}

fn SceneGradient_vf3_(sample_position_3 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param_23 : vec3<f32>;
  var param_24 : vec3<f32>;
  var param_25 : vec3<f32>;
  var param_26 : vec3<f32>;
  var param_27 : vec3<f32>;
  var param_28 : vec3<f32>;
  let x_786 : vec3<f32> = *(sample_position_3);
  param_23 = (x_786 + vec3<f32>(0.001, 0.0, 0.0));
  let x_790 : vec2<f32> = SceneField_vf3_(&(param_23));
  let x_792 : vec3<f32> = *(sample_position_3);
  param_24 = (x_792 + vec3<f32>(-0.001, 0.0, 0.0));
  let x_797 : vec2<f32> = SceneField_vf3_(&(param_24));
  let x_800 : vec3<f32> = *(sample_position_3);
  param_25 = (x_800 + vec3<f32>(0.0, 0.001, 0.0));
  let x_804 : vec2<f32> = SceneField_vf3_(&(param_25));
  let x_806 : vec3<f32> = *(sample_position_3);
  param_26 = (x_806 + vec3<f32>(0.0, -0.001, 0.0));
  let x_810 : vec2<f32> = SceneField_vf3_(&(param_26));
  let x_813 : vec3<f32> = *(sample_position_3);
  param_27 = (x_813 + vec3<f32>(0.0, 0.0, 0.001));
  let x_817 : vec2<f32> = SceneField_vf3_(&(param_27));
  let x_819 : vec3<f32> = *(sample_position_3);
  param_28 = (x_819 + vec3<f32>(0.0, 0.0, -0.001));
  let x_823 : vec2<f32> = SceneField_vf3_(&(param_28));
  return normalize(vec3<f32>((x_790.x - x_797.x), (x_804.x - x_810.x), (x_817.x - x_823.x)));
}

fn EnvironmentColor_vf3_(ray_direction : ptr<function, vec3<f32>>) -> vec4<f32> {
  let x_913 : vec3<f32> = *(ray_direction);
  let x_914 : vec4<f32> = textureSample(cube_map, cube_map_smplr, x_913);
  return x_914;
}

fn InnerGlassGradient_vf3_(sample_position_4 : ptr<function, vec3<f32>>) -> vec3<f32> {
  var param_29 : vec3<f32>;
  var param_30 : vec3<f32>;
  var param_31 : vec3<f32>;
  var param_32 : vec3<f32>;
  var param_33 : vec3<f32>;
  var param_34 : vec3<f32>;
  let x_830 : vec3<f32> = *(sample_position_4);
  param_29 = (x_830 + vec3<f32>(0.001, 0.0, 0.0));
  let x_833 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_29));
  let x_835 : vec3<f32> = *(sample_position_4);
  param_30 = (x_835 + vec3<f32>(-0.001, 0.0, 0.0));
  let x_838 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_30));
  let x_841 : vec3<f32> = *(sample_position_4);
  param_31 = (x_841 + vec3<f32>(0.0, 0.001, 0.0));
  let x_844 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_31));
  let x_846 : vec3<f32> = *(sample_position_4);
  param_32 = (x_846 + vec3<f32>(0.0, -0.001, 0.0));
  let x_849 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_32));
  let x_852 : vec3<f32> = *(sample_position_4);
  param_33 = (x_852 + vec3<f32>(0.0, 0.0, 0.001));
  let x_855 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_33));
  let x_857 : vec3<f32> = *(sample_position_4);
  param_34 = (x_857 + vec3<f32>(0.0, 0.0, -0.001));
  let x_860 : vec2<f32> = InnerGlassBoxField_vf3_(&(param_34));
  return normalize(vec3<f32>((x_833.x - x_838.x), (x_844.x - x_849.x), (x_855.x - x_860.x)));
}

fn MarchShadow_vf3_(position : ptr<function, vec3<f32>>) -> f32 {
  var shadow_result : vec2<f32>;
  var shadow_steps : i32;
  var param_35 : vec3<f32>;
  var param_36 : vec3<f32>;
  var param_37 : i32;
  var param_38 : bool;
  var param_39 : bool;
  var shadow_percentage : f32;
  var shadow_multiplier_2 : f32;
  let x_868 : vec3<f32> = *(position);
  param_35 = (x_868 + vec3<f32>(-0.009733285, 0.024333213, -0.014599928));
  param_36 = vec3<f32>(-0.324442834, 0.811107099, -0.486664265);
  param_38 = false;
  param_39 = true;
  let x_886 : vec2<f32> = March_vf3_vf3_i1_b1_b1_(&(param_35), &(param_36), &(param_37), &(param_38), &(param_39));
  let x_887 : i32 = param_37;
  shadow_steps = x_887;
  shadow_result = x_886;
  let x_889 : i32 = shadow_steps;
  shadow_percentage = (f32(x_889) / 70.0);
  let x_895 : f32 = shadow_percentage;
  shadow_multiplier_2 = (1.600000024 - x_895);
  let x_898 : f32 = shadow_result.x;
  if ((x_898 < 300.0)) {
    shadow_multiplier_2 = 0.600000024;
  }
  let x_902 : f32 = shadow_multiplier_2;
  return x_902;
}

fn SurfaceColor_vf3_vf3_vf3_f1_f1_(ray_direction_1 : ptr<function, vec3<f32>>, surface_position : ptr<function, vec3<f32>>, surface_normal : ptr<function, vec3<f32>>, material : ptr<function, f32>, shadow_multiplier : ptr<function, f32>) -> vec4<f32> {
  var reflection_direction : vec3<f32>;
  var reflection_color : vec4<f32>;
  var material_value : vec4<f32>;
  let x_918 : vec3<f32> = *(ray_direction_1);
  let x_919 : vec3<f32> = *(surface_normal);
  reflection_direction = reflect(x_918, x_919);
  let x_925 : vec3<f32> = reflection_direction;
  let x_926 : vec4<f32> = textureSample(cube_map, cube_map_smplr, x_925);
  reflection_color = x_926;
  let x_927 : f32 = *(material);
  if ((x_927 < 1.5)) {
    material_value = vec4<f32>(0.0, 0.340000004, 0.610000014, 0.5);
  } else {
    let x_936 : f32 = *(material);
    if ((x_936 < 2.5)) {
      material_value = vec4<f32>(0.159999996, 0.709999979, 0.959999979, 0.5);
    } else {
      let x_946 : f32 = *(material);
      if ((x_946 < 3.5)) {
        material_value = vec4<f32>(0.330000013, 0.769999981, 0.970000029, 0.5);
      } else {
        let x_955 : f32 = *(material);
        if ((x_955 < 4.5)) {
          material_value = vec4<f32>(0.159999996, 0.709999979, 0.959999979, 0.5);
        } else {
          let x_961 : f32 = *(material);
          if ((x_961 < 5.5)) {
            material_value = vec4<f32>(0.100000001, 0.100000001, 0.100000001, 0.0);
          } else {
            material_value = vec4<f32>(0.100000001, 0.100000001, 0.100000001, 1.299999952);
          }
        }
      }
    }
  }
  let x_970 : vec4<f32> = material_value;
  let x_972 : f32 = *(shadow_multiplier);
  let x_973 : vec3<f32> = (vec3<f32>(x_970.x, x_970.y, x_970.z) * x_972);
  let x_978 : vec4<f32> = reflection_color;
  let x_979 : vec3<f32> = *(ray_direction_1);
  let x_981 : vec3<f32> = *(surface_normal);
  let x_986 : f32 = material_value.w;
  let x_987 : f32 = ((dot(-(x_979), x_981) - 1.0) + x_986);
  return mix(vec4<f32>(x_973.x, x_973.y, x_973.z, 1.0), x_978, vec4<f32>(x_987, x_987, x_987, x_987));
}

fn SceneColor_vf3_vf3_vf3_f1_f1_i1_f1_vf4_(ray_position : ptr<function, vec3<f32>>, ray_direction_2 : ptr<function, vec3<f32>>, surface_normal_1 : ptr<function, vec3<f32>>, dist : ptr<function, f32>, material_1 : ptr<function, f32>, steps_taken_1 : ptr<function, i32>, shadow_multiplier_1 : ptr<function, f32>, ray_noise : ptr<function, vec4<f32>>) -> vec4<f32> {
  var result_color : vec4<f32>;
  var param_40 : vec3<f32>;
  var surface_position_1 : vec3<f32>;
  var param_41 : vec3<f32>;
  var param_42 : vec3<f32>;
  var param_43 : vec3<f32>;
  var param_44 : f32;
  var param_45 : f32;
  var glow_factor : f32;
  var glow_color : vec4<f32>;
  let x_992 : f32 = *(dist);
  if ((x_992 >= 300.0)) {
    let x_998 : vec3<f32> = *(ray_direction_2);
    param_40 = x_998;
    let x_999 : vec4<f32> = EnvironmentColor_vf3_(&(param_40));
    result_color = x_999;
  } else {
    let x_1002 : vec3<f32> = *(ray_position);
    let x_1003 : vec3<f32> = *(ray_direction_2);
    let x_1004 : f32 = *(dist);
    surface_position_1 = (x_1002 + (x_1003 * x_1004));
    let x_1008 : vec3<f32> = *(ray_direction_2);
    param_41 = x_1008;
    let x_1010 : vec3<f32> = surface_position_1;
    param_42 = x_1010;
    let x_1012 : vec3<f32> = *(surface_normal_1);
    param_43 = x_1012;
    let x_1014 : f32 = *(material_1);
    param_44 = x_1014;
    let x_1016 : f32 = *(shadow_multiplier_1);
    param_45 = x_1016;
    let x_1017 : vec4<f32> = SurfaceColor_vf3_vf3_vf3_f1_f1_(&(param_41), &(param_42), &(param_43), &(param_44), &(param_45));
    result_color = x_1017;
  }
  let x_1019 : i32 = *(steps_taken_1);
  glow_factor = (f32(x_1019) / 70.0);
  let x_1029 : f32 = frag_info.time;
  let x_1033 : f32 = ((sin((x_1029 / 3.0)) * 0.5) + 0.5);
  glow_color = mix(vec4<f32>(0.860000014, 0.980000019, 1.0, 1.0), vec4<f32>(1.659999967, 0.980000019, 0.5, 1.0), vec4<f32>(x_1033, x_1033, x_1033, x_1033));
  let x_1036 : vec4<f32> = result_color;
  let x_1037 : vec4<f32> = glow_color;
  let x_1038 : f32 = glow_factor;
  let x_1040 : f32 = (x_1038 * 1.100000024);
  return mix(x_1036, x_1037, vec4<f32>(x_1040, x_1040, x_1040, x_1040));
}

fn CombinedColor_vf3_vf3_vf4_(ray_position_1 : ptr<function, vec3<f32>>, ray_direction_3 : ptr<function, vec3<f32>>, ray_noise_1 : ptr<function, vec4<f32>>) -> vec4<f32> {
  var result_1 : vec2<f32>;
  var steps_taken_2 : i32;
  var param_46 : vec3<f32>;
  var param_47 : vec3<f32>;
  var param_48 : i32;
  var param_49 : bool;
  var param_50 : bool;
  var surface_normal_2 : vec3<f32>;
  var param_51 : vec3<f32>;
  var glass_reflection_factor : f32;
  var glass_reflection_color : vec4<f32>;
  var glass_reflection_direction : vec3<f32>;
  var param_52 : vec3<f32>;
  var steps : i32;
  var param_53 : vec3<f32>;
  var param_54 : vec3<f32>;
  var param_55 : i32;
  var param_56 : bool;
  var param_57 : bool;
  var param_58 : vec3<f32>;
  var steps_1 : i32;
  var param_59 : vec3<f32>;
  var param_60 : vec3<f32>;
  var param_61 : i32;
  var param_62 : bool;
  var param_63 : bool;
  var param_64 : vec3<f32>;
  var shadow_multiplier_3 : f32;
  var param_65 : vec3<f32>;
  var scene_color : vec4<f32>;
  var param_66 : vec3<f32>;
  var param_67 : vec3<f32>;
  var param_68 : vec3<f32>;
  var param_69 : f32;
  var param_70 : f32;
  var param_71 : i32;
  var param_72 : f32;
  var param_73 : vec4<f32>;
  let x_1048 : vec3<f32> = *(ray_position_1);
  param_46 = x_1048;
  let x_1050 : vec3<f32> = *(ray_direction_3);
  param_47 = x_1050;
  param_49 = false;
  param_50 = false;
  let x_1054 : vec2<f32> = March_vf3_vf3_i1_b1_b1_(&(param_46), &(param_47), &(param_48), &(param_49), &(param_50));
  let x_1055 : i32 = param_48;
  steps_taken_2 = x_1055;
  result_1 = x_1054;
  let x_1056 : vec3<f32> = *(ray_position_1);
  let x_1057 : vec3<f32> = *(ray_direction_3);
  let x_1059 : f32 = result_1.x;
  *(ray_position_1) = (x_1056 + (x_1057 * x_1059));
  let x_1064 : vec3<f32> = *(ray_position_1);
  param_51 = x_1064;
  let x_1065 : vec3<f32> = SceneGradient_vf3_(&(param_51));
  surface_normal_2 = x_1065;
  glass_reflection_factor = 0.0;
  glass_reflection_color = vec4<f32>(0.0, 0.0, 0.0, 0.0);
  let x_1070 : f32 = result_1.y;
  if ((x_1070 == -2.0)) {
    let x_1075 : vec3<f32> = *(ray_direction_3);
    let x_1076 : vec3<f32> = surface_normal_2;
    glass_reflection_direction = reflect(x_1075, x_1076);
    let x_1079 : vec3<f32> = glass_reflection_direction;
    param_52 = x_1079;
    let x_1080 : vec4<f32> = EnvironmentColor_vf3_(&(param_52));
    glass_reflection_color = x_1080;
    let x_1081 : vec3<f32> = glass_reflection_direction;
    let x_1082 : vec3<f32> = surface_normal_2;
    glass_reflection_factor = (0.5 - (dot(x_1081, x_1082) * 0.600000024));
    let x_1086 : vec3<f32> = *(ray_direction_3);
    let x_1087 : vec3<f32> = surface_normal_2;
    *(ray_direction_3) = refract(x_1086, x_1087, 1.100000024);
    let x_1089 : vec3<f32> = *(ray_direction_3);
    let x_1091 : vec3<f32> = *(ray_position_1);
    *(ray_position_1) = (x_1091 + (x_1089 * 0.5));
    let x_1095 : vec3<f32> = *(ray_position_1);
    param_53 = x_1095;
    let x_1097 : vec3<f32> = *(ray_direction_3);
    param_54 = x_1097;
    param_56 = true;
    param_57 = false;
    let x_1101 : vec2<f32> = March_vf3_vf3_i1_b1_b1_(&(param_53), &(param_54), &(param_55), &(param_56), &(param_57));
    let x_1102 : i32 = param_55;
    steps = x_1102;
    result_1 = x_1101;
    let x_1103 : i32 = steps;
    let x_1104 : i32 = steps_taken_2;
    steps_taken_2 = (x_1104 + x_1103);
    let x_1106 : vec3<f32> = *(ray_position_1);
    let x_1107 : vec3<f32> = *(ray_direction_3);
    let x_1109 : f32 = result_1.x;
    *(ray_position_1) = (x_1106 + (x_1107 * x_1109));
    let x_1113 : vec3<f32> = *(ray_position_1);
    param_58 = x_1113;
    let x_1114 : vec3<f32> = InnerGlassGradient_vf3_(&(param_58));
    surface_normal_2 = x_1114;
  }
  let x_1116 : f32 = result_1.y;
  if ((x_1116 == -3.0)) {
    let x_1120 : vec3<f32> = *(ray_direction_3);
    let x_1121 : vec3<f32> = surface_normal_2;
    *(ray_direction_3) = refract(x_1120, x_1121, 0.909090936);
    let x_1124 : vec3<f32> = *(ray_direction_3);
    let x_1126 : vec3<f32> = *(ray_position_1);
    *(ray_position_1) = (x_1126 + (x_1124 * 1.0));
    let x_1128 : vec3<f32> = *(ray_position_1);
    let x_1129 : vec3<f32> = *(ray_direction_3);
    let x_1131 : f32 = result_1.x;
    param_59 = (x_1128 + (x_1129 * x_1131));
    let x_1137 : vec3<f32> = *(ray_direction_3);
    param_60 = x_1137;
    param_62 = false;
    param_63 = false;
    let x_1141 : vec2<f32> = March_vf3_vf3_i1_b1_b1_(&(param_59), &(param_60), &(param_61), &(param_62), &(param_63));
    let x_1142 : i32 = param_61;
    steps_1 = x_1142;
    result_1 = x_1141;
    let x_1143 : i32 = steps_1;
    let x_1144 : i32 = steps_taken_2;
    steps_taken_2 = (x_1144 + x_1143);
    let x_1146 : vec3<f32> = *(ray_position_1);
    let x_1147 : vec3<f32> = *(ray_direction_3);
    let x_1149 : f32 = result_1.x;
    *(ray_position_1) = (x_1146 + (x_1147 * x_1149));
    let x_1153 : vec3<f32> = *(ray_position_1);
    param_64 = x_1153;
    let x_1154 : vec3<f32> = SceneGradient_vf3_(&(param_64));
    surface_normal_2 = x_1154;
  }
  let x_1157 : vec3<f32> = *(ray_position_1);
  param_65 = x_1157;
  let x_1158 : f32 = MarchShadow_vf3_(&(param_65));
  shadow_multiplier_3 = x_1158;
  let x_1161 : vec3<f32> = *(ray_position_1);
  param_66 = x_1161;
  let x_1163 : vec3<f32> = *(ray_direction_3);
  param_67 = x_1163;
  let x_1165 : vec3<f32> = surface_normal_2;
  param_68 = x_1165;
  let x_1168 : f32 = result_1.x;
  param_69 = x_1168;
  let x_1171 : f32 = result_1.y;
  param_70 = x_1171;
  let x_1173 : i32 = steps_taken_2;
  param_71 = x_1173;
  let x_1175 : f32 = shadow_multiplier_3;
  param_72 = x_1175;
  let x_1177 : vec4<f32> = *(ray_noise_1);
  param_73 = x_1177;
  let x_1178 : vec4<f32> = SceneColor_vf3_vf3_vf3_f1_f1_i1_f1_vf4_(&(param_66), &(param_67), &(param_68), &(param_69), &(param_70), &(param_71), &(param_72), &(param_73));
  scene_color = x_1178;
  let x_1179 : vec4<f32> = scene_color;
  let x_1180 : vec4<f32> = glass_reflection_color;
  let x_1181 : f32 = glass_reflection_factor;
  return mix(x_1179, x_1180, vec4<f32>(x_1181, x_1181, x_1181, x_1181));
}

fn main_1() {
  var cam_time : f32;
  var cam_position : vec3<f32>;
  var cam_direction : vec3<f32>;
  var ray_direction_4 : vec3<f32>;
  var param_74 : vec2<f32>;
  var param_75 : vec3<f32>;
  var lens_position : vec3<f32>;
  var i_1 : i32;
  var ray_noise_2 : vec4<f32>;
  var param_76 : vec2<f32>;
  var param_77 : f32;
  var ray_start : vec3<f32>;
  var ray_direction_5 : vec3<f32>;
  var result_color_1 : vec4<f32>;
  var param_78 : vec3<f32>;
  var param_79 : vec3<f32>;
  var param_80 : vec4<f32>;
  let x_1231 : f32 = frag_info.time;
  cam_time = (x_1231 / 2.0);
  let x_1234 : f32 = cam_time;
  let x_1241 : f32 = cam_time;
  let x_1248 : f32 = cam_time;
  cam_position = (vec3<f32>((-(sin((x_1234 + 0.200000003))) * 6.25), ((-(cos((x_1241 + 0.300000012))) * 2.900000095) + 1.0), (-(cos((x_1248 - 0.100000001))) * 5.400000095)) * 2.0);
  let x_1257 : vec3<f32> = cam_position;
  cam_direction = normalize(-(x_1257));
  let x_1260 : vec3<f32> = cam_position;
  cam_position = (x_1260 + vec3<f32>(0.0, 2.0, 0.0));
  let x_1266 : vec2<f32> = v_screen_position;
  param_74 = x_1266;
  let x_1268 : vec3<f32> = cam_direction;
  param_75 = x_1268;
  let x_1269 : vec3<f32> = GetFragDirection_vf2_vf3_(&(param_74), &(param_75));
  ray_direction_4 = x_1269;
  let x_1271 : vec3<f32> = cam_position;
  let x_1272 : vec3<f32> = ray_direction_4;
  lens_position = (x_1271 + (x_1272 * 12.0));
  i_1 = 0i;
  loop {
    let x_1282 : i32 = i_1;
    if ((x_1282 < 4i)) {
    } else {
      break;
    }
    let x_1286 : i32 = i_1;
    let x_1289 : f32 = frag_info.time;
    let x_1294 : vec2<f32> = v_screen_position;
    param_76 = x_1294;
    param_77 = (f32(x_1286) + (x_1289 - (10.0 * floor((x_1289 / 10.0)))));
    let x_1296 : vec4<f32> = BlueNoiseWithRandomOffset_vf2_f1_(&(param_76), &(param_77));
    ray_noise_2 = x_1296;
    let x_1298 : vec3<f32> = cam_position;
    let x_1299 : vec4<f32> = ray_noise_2;
    ray_start = (x_1298 + (vec3<f32>(x_1299.x, x_1299.y, x_1299.z) * 0.5));
    let x_1304 : vec3<f32> = lens_position;
    let x_1305 : vec3<f32> = ray_start;
    ray_direction_5 = normalize((x_1304 - x_1305));
    let x_1310 : vec3<f32> = ray_start;
    param_78 = x_1310;
    let x_1312 : vec3<f32> = ray_direction_5;
    param_79 = x_1312;
    let x_1314 : vec4<f32> = ray_noise_2;
    param_80 = x_1314;
    let x_1315 : vec4<f32> = CombinedColor_vf3_vf3_vf4_(&(param_78), &(param_79), &(param_80));
    result_color_1 = x_1315;
    let x_1318 : vec4<f32> = result_color_1;
    let x_1321 : vec4<f32> = frag_color;
    frag_color = (x_1321 + (x_1318 / vec4<f32>(4.0, 4.0, 4.0, 4.0)));

    continuing {
      let x_1323 : i32 = i_1;
      i_1 = (x_1323 + 1i);
    }
  }
  return;
}

struct main_out {
  @location(0)
  frag_color_1 : vec4<f32>,
}

@stage(fragment)
fn main(@location(0) v_screen_position_param : vec2<f32>) -> main_out {
  v_screen_position = v_screen_position_param;
  main_1();
  return main_out(frag_color);
}
