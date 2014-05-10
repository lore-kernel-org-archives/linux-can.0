From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: building  j1939 stack
Date: Sun, 11 May 2014 00:06:39 +0200
Message-ID: <20140510220639.GA18571@vandijck-laurijssen.be>
References: <loom.20140510T062609-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:47611 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161AbaEJWGv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 10 May 2014 18:06:51 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140510T062609-546@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

I found already that my can-j1939 does not compile on a 3.12 kernel
that I'm using.
I'm working to bring can-j1939 to 3.12 for my own use.

What kernel version do you use before & now?

Kurt

On Sat, May 10, 2014 at 04:33:16AM +0000, swapnil wrote:
> Hi,
>    Hi Kurt I am able to build the kerneal some time befor by adding t=
he
> j1939 stack.=20
>    but i am not able to build it now.
> can you help me in this. =20
>=20
>    I am getting following errors   =20
> =E2=80=98.config=E2=80=99 -> =E2=80=98/home/bbb/beaglebone/GVE/linux-=
dev/patches/defconfig=E2=80=99
> -----------------------------
> make -j2 ARCH=3Darm LOCALVERSION=3D-armv7-devel-r44
> CROSS_COMPILE=3D/home/bbb/beaglebone/GVE/linux-dev
> /dl/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_
> linux/bin/arm-linux-gnueabihf-
>  zImage modules
> -----------------------------
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CHK     kernel/config_data.h
>   LD      net/can/j1939/built-in.o
>   CC [M]  net/can/j1939/main.o
> In file included from net/can/j1939/main.c:27:0:
> net/can/j1939/j1939-priv.h:182:3: error: unknown=20
> type name =E2=80=98write_proc_t=E2=80=99
>    write_proc_t write);
>    ^
> make[3]: *** [net/can/j1939/main.o] Error 1
> make[2]: *** [net/can/j1939] Error 2
> make[1]: *** [net/can] Error 2
> make: *** [net] Error 2
>=20
> I followed the instruction on http://elinux.org/J1939
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
