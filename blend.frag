// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

uniform texture2D texture_sampler_src;
uniform sampler texture_sampler_src_smplr;

in vec2 v_texture_coords;

out vec4 frag_color;

void main() {
  frag_color = texture(sampler2D(texture_sampler_src, texture_sampler_src_smplr), v_texture_coords);
}
