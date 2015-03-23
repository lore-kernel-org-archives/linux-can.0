From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Mon, 23 Mar 2015 14:15:05 +0100
Message-ID: <CAKSnaaf5b6Bf6GUeH22Yq2D_zTcDFhU61huRXUxpTrXAtQyS_w@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
	<CAKSnaacWdnH7srpFXNnHX7Yhobgxc-LMnEP-rOSEq0YA=pmv9A@mail.gmail.com>
	<5e76bc45fac64ba8a1e1b223d9839297@SGPMBX1011.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34645 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbCWNPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Mar 2015 09:15:07 -0400
Received: by lbbsy1 with SMTP id sy1so117998445lbb.1
        for <linux-can@vger.kernel.org>; Mon, 23 Mar 2015 06:15:06 -0700 (PDT)
In-Reply-To: <5e76bc45fac64ba8a1e1b223d9839297@SGPMBX1011.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Pankaj,

2015-03-23 11:28 GMT+01:00 Pankajkumar Misra (RBEI/EEA2)
<Pankaj.Kumar@in.bosch.com>:
> Hi Max,
>
> I am trying to compile cannelloni, but getting errors.
>
> First:
>         The compiler was fixed to /usr/bin/c++.
>         In case of doing cross compilation this will not work. Please=
 provide option to choose compiler.

This is possible with CMake. Have a look here:

http://www.cmake.org/Wiki/CMake_FAQ#How_do_I_use_a_different_compiler.3=
=46

Since you are cross compiling, this might also help:

http://www.cmake.org/Wiki/CMake_Cross_Compiling

> Second:
>         Once above issue fixed I got error saying :
>                 root@xxxVM:/CANonIP/cannelloni# make

>                 /usr/arm-linux-gnueabihf/include/c++/4.6.3/bits/c++0x=
_warning.h:32:2: error: #error This file requires compiler and library =
support for the upcoming ISO C++ standard, C++0x. This                 =
     support is currently experimental, and must be enabled with the -s=
td=3Dc++0x or -std=3Dgnu++0x compiler options.
>                 To fix this I changed the option in CMakeLists.txt
>                         ADD_DEFINITIONS(
>                         #    -std=3Dc++11
>                             -std=3Dc++0x
>                         )

Your compiler was released in 2012 and c++11/c++0x was very new
back then.
If you can, try to upgrade to something newer, like GCC 4.9.x.
Linaro also has current releases of GCC for gnueabihf target platforms.=
 [1]

> Third:  error: =E2=80=98canfd_frame=E2=80=99 has not been declared

This is most likely due to the fact that your kernel is pretty old.
struct canfd_frame was introduced with kernel commit 7c9416365c
and the first kernel release to support it was v3.6 [2], released in 20=
12.
I am guessing that your kernel version is < v3.6, if so update it to v3=
=2E6+.

Another solution would be to define canfd_frame inside the application =
if
LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0).
I have created an issue for that [3].

>
> Please correct if something wrong in my approach.
>
> Best Regards,
> Pankaj

Regards,

Max

[1] git tag --contains 7c9416365c60f150ef8961a2855fafbc7394ad6b
[2] https://wiki.linaro.org/WorkingGroups/ToolChain
[3] https://github.com/mguentner/cannelloni/issues/2
