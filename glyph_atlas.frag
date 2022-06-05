// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

uniform texture2D glyph_atlas_sampler;
uniform sampler glyph_atlas_sampler_smplr;

in vec2 v_unit_vertex;
in vec2 v_atlas_position;
in vec2 v_atlas_glyph_size;
in vec2 v_atlas_size;
in vec4 v_text_color;

out vec4 frag_color;

void main() {
  vec2 scale_perspective = v_atlas_glyph_size / v_atlas_size;
  vec2 offset = v_atlas_position / v_atlas_size;

  frag_color = texture(
    sampler2D(glyph_atlas_sampler, glyph_atlas_sampler_smplr),
    v_unit_vertex * scale_perspective + offset
  ).aaaa * v_text_color;
}
