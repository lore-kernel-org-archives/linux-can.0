From: swapnil <patilswa@gmail.com>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on BeagleBone Black)
Date: Thu, 28 Nov 2013 04:49:38 +0000 (UTC)
Message-ID: <loom.20131128T053030-487@post.gmane.org>
References: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de> <loom.20131112T015933-695@post.gmane.org> <20131112100222.GA3748@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44582 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab3K1EuB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 Nov 2013 23:50:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VltY6-0007sg-B9
	for linux-can@vger.kernel.org; Thu, 28 Nov 2013 05:49:58 +0100
Received: from c-98-212-86-243.hsd1.in.comcast.net ([98.212.86.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 28 Nov 2013 05:49:58 +0100
Received: from patilswa by c-98-212-86-243.hsd1.in.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 28 Nov 2013 05:49:58 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

>=20
> Hey all,
>=20
> Maybe Michael was a bit too fast.
> I suspect you tried to merge the j1939 linux kernel into can-utils ?
>=20
> On Tue, Nov 12, 2013 at 01:10:04AM +0000, swapnil wrote:
> > Michael Luxen <mluxen <at> gmx.net> writes:
> >=20
> > >=20
> > > Hello Swapnil,
> > >=20
> > > I've success with building the J1939 stack on my BBB based on Deb=
ian=20
using=20
> > these steps:
> > >=20
> > > git clone git://gitorious.org/linux-can/can-utils.git
> > > cd can-utils
> > > --- get J1939 stuff ---
>=20
> So you're in the can-utils directory now. Merge can-utils-j1939
>=20
> $ git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/can-j19=
39-
utils.git
> $ git remote update j1939
> $ git merge j1939/master
>=20
> build can-utils now.
> And then:
>=20
> $ cd ..
> $ git clone <your kernel>
> $ cd linux (or your linux kernel directory)
>=20
> and then these steps apply.
>=20
> > > git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/linux=
-can-
j1939.git
> > > git remote update j1939
> > > --- depending on kernel ---
> > > git merge j1939/v3.6
> > > ...or=E2=80=A6
> > > git merge j1939/v3.8
>=20
> Maybe this will work better.
>=20
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
Hi Kurt ,
 Thanks for adding the information on elinux.org/J1939
I am able to build the kernal for begabone black using j1939=20
but when i tried to build iproute2-j1939

root@arm:/home/ubuntu/OBDscan/iproute2-j1939# make
make[1]: Entering directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include -
DRESOLVE_HOSTNAMES -DLIBDIR=3D\"/usr/lib/\" -I/usr//usr/include  -o arp=
d=20
arpd.c ../lib/libnetlink.a ../lib/libutil.a -ldb -lpthread
arpd.c:19:20: fatal error: db_185.h: No such file or directory
 #include <db_185.h>
                    ^
compilation terminated.
make[1]: *** [arpd] Error 1
make[1]: Leaving directory `/home/ubuntu/OBDscan/iproute2-j1939/misc'
make: *** [all] Error 2

i am getting above error.
i tried to install  sudo apt-get install db4.7-util
but did not worked=20

if y
>ip link set can0 j1939 on
Error: either "dev" is duplicate, or "j1939" is a garbage.

can you please help me.
I am really trying hard to build it on begalbone black=20
Thank You
Swapnil


