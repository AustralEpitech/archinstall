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
        pac xf86-video-nouveau
        ;;
    *nvidia*)
        pac nvidia{,-utils}
        ;;
esac
