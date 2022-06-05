// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "utils.sl.h"

uniform sampler2D texture_sampler;
uniform FragInfo {
  float texture_sampler_y_coord_scale;
} frag_info;

in vec2 v_texture_coords;
in float v_alpha;

out vec4 frag_color;

void main() {
  vec4 sampled = ImpellerTexture(texture_sampler, v_texture_coords, frag_info.texture_sampler_y_coord_scale);
  frag_color = sampled * v_alpha;
}
