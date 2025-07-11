
     ==============================================================
    |                                                              |
    |       readme.txt  -  by Don Cross <dcross@intersrv.com>      |
    |                                                              |
     ==============================================================

The file FFT.ZIP contains C source code for performing Discrete Fast Fourier
Transforms (DFFTs) and inverse DFFTs.  This source code is public domain.
Use at your own risk.  For more information, point your web browser at:

http://www.intersrv.com/~dcross/fft.html

Also, feel free to send questions/comments about this source code to me
by e-mail at the address above.

------------------------------------------------------------------------------

                         *** IMPORTANT NOTE ***

There are two different ways to define the FFT (and inverse FFT) that
result in having the same outputs, only the imaginary parts are
negated.  In other words, the two different algorithms produce results
that are complex conjugates of each other.

The popular mathematical software tool MATLAB and my FFT source routines
use opposite definitions.  However, it is easy to make my FFT source
code compatible with MATLAB.  To do this, use your favorite text editor
to change the following files:

    fourierd.c
    fourierf.c

Look for the line of text that says:

    double angle_numerator = 2.0 * DDC_PI;

And change it to:

    double angle_numerator = -2.0 * DDC_PI;

That is, just make the angle numerator negative instead of positive.

Be sure to do this in both fourierd.c AND fourierf.c so you have
consistent routines for both single- and double-precision math.

I am considering changing my code to be compatible with MATLAB, but
first I would like to find out if there is some definitely "correct"
or "preferred" definition within the mathematical community.  If you
have any comments on this issue, please let me know at the following 
email address, because I'm stumped and need help!

   dcross@intersrv.com

Thanks!

------------------------------------------------------------------------------

                         *** SMALL REQUESTS ****

If you want to give away copies of this source code, that's fine, so long
as you do the following:

- Do not charge any money for this source code, except for possibly a
  reasonable fee to cover postage, disk duplication, etc.  I wrote this
  code and I want it to be FREE to EVERYONE!

- Do not remove my name, e-mail address, or URL from any of the files in
  this collection.

- Please keep this readme.txt file with the source and headers so that others
  can get in touch with me to ask questions and/or find my web page to read
  the online tutorial.

- If you make any modifications to the source code, please add comments to
  it which include your name, e-mail address, web page URL (if any), and
  explain what you did to the code.

- If you use this source code in an interesting program, please let me know.
  I promise will never try to get money from you, even if you use this code
  in a commercial program.  I just want to know what kind of clever and
  creative things people do with Fourier Transforms.
