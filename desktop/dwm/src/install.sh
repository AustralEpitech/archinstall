#!/bin/bash -ex

pac "${pkg[@]}"

case "$(lsmod)" in
    *amdgpu*)
        pac xf86-video-amdgpu
        ;;
    *i915*)
        # https://wiki.archlinux.org/title/Intel_graphics#Installation
        #pac xf86-video-intel
        ;;
    *nouveau*)
        # https://bugs.freedesktop.org/show_bug.cgi?id=94844#c3
        #pac xf86-video-nouveau
        ;;
    *)
        ;;
esac
