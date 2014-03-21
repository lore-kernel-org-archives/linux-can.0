From: Francesco Giovannini <francesco.giovannini@iit.it>
Subject: Re: esd CAN USB/2 and SocketCAN
Date: Fri, 21 Mar 2014 20:06:43 +0100
Message-ID: <532C8DC3.5070503@iit.it>
References: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BA841ABD00@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.iit.it ([90.147.26.161]:38715 "EHLO es400ra02.iit.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaCUTGk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Mar 2014 15:06:40 -0400
Received: from es400ra02.iit.it (127.0.0.1) id h5i6s00171s7 for <linux-can@vger.kernel.org>; Fri, 21 Mar 2014 20:06:39 +0100 (envelope-from <prvs=11572a55c0=Francesco.Giovannini@iit.it>)
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E02BA841ABD00@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Thomas_K=F6rper?= <Thomas.Koerper@esd.eu>
Cc: Matthias Fuchs <Matthias.Fuchs@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


On 18/03/14 12:04, Thomas K=F6rper wrote:
> Hello,
>
> I tried to reproduce your problems with our USB/2 CAN module, see fol=
lowing output.
> But there seems to be no issue specific to that software combination.
>
> The disconnection while setting the baudrate therefore seems to be ca=
used by USB power issues. (When setting the baudrate the module needs m=
ore power: exactly the moment the disconnect occurs)
>
> So how does that CAN USB/2 behave at another PC, or without/with powe=
red USB-Hub etc.?
>
>
> Kind Regards,
>      Thomas K=F6rper
>
> linux-su5w:/usr/src/linux # uname -a
> Linux linux-su5w 3.4.63-2.44-desktop #1 SMP PREEMPT Wed Oct 2 11:18:3=
2 UTC 2013 (d91a619) i686 i686 i386 GNU/Linux
> linux-su5w:/usr/src/linux # modinfo esd_usb2
> filename:       /lib/modules/3.4.63-2.44-desktop/extra/esd_usb2.ko
> license:        GPL v2
> description:    CAN driver for esd CAN-USB/2 interfaces
> author:         Matthias Fuchs <matthias.fuchs@esd.eu>
> srcversion:     BB525C832956175CE3B9316
> alias:          usb:v0AB4p0010d*dc*dsc*dp*ic*isc*ip*
> depends:
> vermagic:       3.4.63-2.44-desktop SMP preempt mod_unload modversion=
s 686
> linux-su5w:/usr/src/linux # canconfig can0 stop
> can0 state: STOPPED
> linux-su5w:/usr/src/linux # canconfig can0 bittiming prop-seg 2 phase=
-seg1 12 phase-seg2 5 sjw 1 brp 3 tq 50
> can0 bittiming:
>          tq: 50, prop-seq: 2 phase-seq1: 12 phase-seq2: 5 sjw: 1, brp=
: 3
> can0 bitrate: 1000000, sample-point: 0.750
> linux-su5w:/usr/src/linux # ip -d link show can0
> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT=
 qlen 10
>      link/can
>      can state STOPPED (berr-counter tx 0 rx 160) restart-ms 0
>      bitrate 1000000 sample-point 0.750
>      tq 50 prop-seg 2 phase-seg1 12 phase-seg2 5 sjw 1
>      esd_usb2: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>      clock 60000000
> linux-su5w:/usr/src/linux # dmesg -c
> [  886.429642] esd_usb2 1-1:1.0: can0: setting BTR=3D0x804d0002
> linux-su5w:/usr/src/linux # canconfig can0 start
> can0 state: ERROR-ACTIVE
> linux-su5w:/usr/src/linux # cansend can0 000#112233
> interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
> linux-su5w:/usr/src/linux # cat /sys/class/net/can0/device/firmware
> 1.1.0
>

Hello,

I tried the same device on a Debian 7.4, kernel 3.2.0-4-amd64 #1 SMP=20
Debian 3.2.54-2 x86_64 GNU/Linux, can kernel module coming from the=20
kernel source tree. Everything works fine.

I asked my colleagues and it seems that this "peak current" problem is=20
well known. Some of us even resorted to opening the CAN-USB and adding =
a=20
capacitor to fix the problem. :)

I must say that I was plugging it in the USB ports which are at the=20
front of the case. It is therefore plausible that those ports could not=
=20
draw enough power when needed. I have since then resorted to using=20
Windows 7 and the necessary driver on the same machine. Everything work=
s=20
fine there, albeit the device is a CAN mini.


Thanks for investigating this, guys!

=46rancesco

--=20
*Francesco Giovannini*
Research Fellow
iCub Facility
*Istituto Italiano di Tecnologia*
Via Morego, 30 16163 Genova
/email:/ francesco.giovannini@iit.it <mailto://francesco.giovannini@iit=
=2Eit>
www.iit.it <http://www.iit.it>

iit-logo-icub
