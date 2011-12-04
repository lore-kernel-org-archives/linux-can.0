From: Jan-Niklas Meier <dschanoeh@googlemail.com>
Subject: Re: [Gitorious] Activity: dschanoeh updated merge request for...
Date: Sun, 4 Dec 2011 10:57:17 +0100
Message-ID: <CAEuXk934A1Vu_3bZ_kyhxO_XJiqoLOY0zuSRxxNxpmLXPjmRCg@mail.gmail.com>
References: <20111129121452.B4F9F7590F@steelheart.shortcut.kunder.linpro.no>
	<4ED4E74D.3090608@pengutronix.de>
	<CAEuXk91Bh+Z0yTqQebmW-EmrU59c-dFz_zKj8ky0ssgFBy23bQ@mail.gmail.com>
	<4EDA705B.1050106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44180 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab1LDJ5T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 Dec 2011 04:57:19 -0500
Received: by ywa9 with SMTP id 9so3708214ywa.19
        for <linux-can@vger.kernel.org>; Sun, 04 Dec 2011 01:57:18 -0800 (PST)
In-Reply-To: <4EDA705B.1050106@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2011/12/3 Marc Kleine-Budde <mkl@pengutronix.de>
>
> Hello Jan-Niklas,
>
> please don't top-post.

I'm sorry.

>
> On 12/03/2011 05:47 PM, Jan-Niklas Meier wrote:
> > 1.
> > I think adding the includes to the repository is a bad idea. If you=
 compile
> > the utils for your machine which has a kernel with SocketCAN-suppor=
t why
> > not use the original kernel headers?
>
> Several reasons:
> - iputils2 package the kernel headers, too.
> - Consider you're using an older kernel without official socketcan
> =A0support and with the external kernel modules available on gitoriou=
s.
> - What about isotp and/or j1939 support? You want to use new features
> =A0which are not part of the mainline kernel yet.
>
> > It makes no sense to compile the can-utils on a machine which does =
not have
> > SocketCAN support. If you do so you should be cross-compiling for a
> > different machine and have the kernel headers of this machine in yo=
ur
> > cross-environment.
> > Also it is very unlikely that someone who installed make, gcc and t=
he
> > autotools does not also have his kernel includes, right?
>
> > To be able to compile a subset of the tools I checked if the isotp.=
h and
> > gw.h are present in the include directory (I don't have them both) =
and only
> > compile the corresponding utils if the headers are present. This wa=
y it
> > should still be possible to compile subsets of the tools on machine=
s with
> > old kernels and not ending up with tools you can not use afterwards=
=2E
>
> What about the external kernel modules use case?

Thank you very much for the clarification. Now I understand why you
did this. Still if your kernel's CAN API is much older than the
headers included in the current can-utils the programs will compile
fine but it is possible that some of them will fail at runtime right?
Method signatures could have changed or some methods are not present
in the old kernel. For example using a program with some specific
parameters could lead to strange=A0behavior=A0for the user. Is that tru=
e
or am I missing something?

>
> > 2.
> > I tried to rewrite the autoconf.ac because there are macros I'm hav=
ing
>
> Please don't rewrite stuff, please send incremental patches, fixing o=
ne
> problem at a time.
>
> > trouble with. When I run autoconf (version 2.68, libtool and automa=
ke
> > installed) I get the following output:
> >
> > configure.ac:22: error: possibly undefined macro: AC_LIBTOOL_WIN32_=
DLL
> > =A0 =A0 =A0 If this token and others are legitimate, please use m4_=
pattern_allow.
> > =A0 =A0 =A0 See the Autoconf documentation.
> > configure.ac:24: error: possibly undefined macro: AC_PROG_LIBTOOL
> > configure.ac:28: error: possibly undefined macro: AM_INIT_AUTOMAKE
> >
> > A configure script is produced but when I try to execute it I get (=
shtool
> > is installed):
> >
> > configure: error: cannot find install-sh, install.sh, or shtool in
> > config/autoconf "."/config/autoconf
> >
> > Trying to make it work (and not knowing what the macros do anyway ;=
) I
> > removed them and successfully ran autoconf with my configure.ac...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
^^^^^^^^
>
> That might be the problem, don't run autoconf, run $(./autogen.sh) in=
stead.

\o/ Yay! That's the hint I needed. I didn't know that there is a
different way to generate a ./configure that autoconf.

>
>
> I just updated to the latest tool available on debian unstable and it=
 works:
>
> > [frogger@hardanger:can-utils (master-squashed)]$ autoconf --version
> > autoconf (GNU Autoconf) 2.68
> [..]
>
> > automake (GNU automake) 1.11.1
> [..]
>
> > [frogger@hardanger:can-utils (master-squashed)]$ libtoolize --versi=
on
> > libtoolize (GNU libtool) 2.4.2
> [..]
>
> > [frogger@hardanger:can-utils (master-squashed)]$ ./autogen.sh && ./=
configure && make distcheck
> [...]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > can-utils-trunk archives ready for distribution:
> > can-utils-trunk.tar.gz
> > can-utils-trunk.tar.bz2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> I used the master-squashed branch of my can-utils repo:
> https://gitorious.org/~bet-frogger/linux-can/mkl-can-utils, head is:
>
> 231ed32f497a4f403a6d0ce2a61f1bb94be76ea4 gitignore: added tarballs

I did the same and it works fine with both HEADs of your master and
master-squashed branches. Still I get some warnings during autoreconf:

configure.ac:22: warning: The macro `AC_LIBTOOL_WIN32_DLL' is obsolete.
configure.ac:22: You should run autoupdate.
[...]
configure.ac:24: warning: The macro `AC_PROG_LIBTOOL' is obsolete.
configure.ac:24: You should run autoupdate.

Thank you again!
Jan-Niklas
