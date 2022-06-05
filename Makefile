WGSL_FRAG_FILES:= advanced_blend_exclusion.wgsl   \
					        glyph_atlas.wgsl                \
					        advanced_blend_colordodge.wgsl  \
					        ink_sparkle.wgsl                \
					        simple.wgsl                     \
					        blend.wgsl                      \
					        solid_stroke.wgsl               \
					        advanced_blend_multiply.wgsl    \
					        advanced_blend_softlight.wgsl   \
					        vertices.wgsl                   \
					        border_mask_blur.wgsl           \
					        advanced_blend_lighten.wgsl     \
					        solid_fill.wgsl                 \
					        impeller.wgsl                   \
					        advanced_blend_overlay.wgsl     \
					        advanced_blend_difference.wgsl  \
					        advanced_blend_hardlight.wgsl   \
					        gaussian_blur.wgsl              \
					        texture_fill.wgsl               \
					        advanced_blend_colorburn.wgsl   \
					        gradient_fill.wgsl              \
					        advanced_blend_screen.wgsl      \
					        advanced_blend_darken.wgsl 			\

WGSL_VERT_FILES:= solid_fill.wgsl				\
									vertices.wgsl					\
									border_mask_blur.wgsl	\
									gradient_fill.wgsl		\
									texture_fill.wgsl			\
									gaussian_blur.wgsl		\
									advanced_blend.wgsl		\
									solid_stroke.wgsl			\
									blend.wgsl						\
									glyph_atlas.wgsl			\


main: vertex_shaders fragment_shaders

vertex_shaders: $(WGSL_VERT_FILES)
fragment_shaders: $(WGSL_FRAG_FILES)

%.wgsl: %.spv
	naga $< $@

%.spv: %.vert
	glslc --target-env=vulkan1.0	\
	 			-std=460core						\
				-fauto-bind-uniforms		\
				-fauto-map-locations		\
				-O0											\
				-o $@ $<

%.spv: %.frag
	glslc --target-env=vulkan1.0	\
	 			-std=460core						\
				-fauto-bind-uniforms		\
				-fauto-map-locations		\
				-O0											\
				-o $@ $<


clean:
	rm -f *.spv *.wgsl
