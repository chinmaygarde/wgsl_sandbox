// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "utils.sl.h"

uniform texture2D texture_sampler;
uniform sampler texture_sampler_smplr;

uniform FragInfo {
  float texture_sampler_y_coord_scale;
} frag_info;

in vec2 v_texture_coords;
in float v_alpha;

out vec4 frag_color;

void main() {
  vec2 coords = v_texture_coords;
  if (frag_info.texture_sampler_y_coord_scale < 0.0) {
    coords.y = 1.0 - coords.y;
  }
  vec4 sampled = texture(sampler2D(texture_sampler, texture_sampler_smplr), coords);
  frag_color = sampled * v_alpha;
}
