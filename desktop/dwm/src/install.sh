#!/bin/bash -ex

pac "${pkg[@]}"

# drivers
case "$(lspci -k | grep -A3 -E '(VGA|3D)')" in
    *amdgpu*)
        pac xf86-video-amdgpu
        ;;
    *i915*)
        pac xf86-video-intel
        ;;
    *nouveau*)
        # https://bugs.freedesktop.org/show_bug.cgi?id=94844#c3
        #pac xf86-video-nouveau
        ;;
esac
