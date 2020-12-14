iir-designer-cmsis-dsp for MATLAB
-

Forked from [matteoscordino/iir-designer-cmsis-dsp](https://github.com/matteoscordino/iir-designer-cmsis-dsp)

You can run `test_iir.m` to make sure everything works.

__Changes__

* Replaced use of 'order' with 'filtOrder' as it is reserved in MATLAB
* Consolidated and refactored plots into single function
* Added `sinetone.m` to mimic Octave function
* Fixed plot filter for elliptical filter (it *was* using butter)