From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Fwd: Re: randconfig build error with next-20141001, in drivers/i2c/algos/i2c-algo-bit.c
Date: Thu, 02 Oct 2014 17:18:13 +0200
Message-ID: <542D6CB5.40206@hartkopp.net>
References: <542C8D93.8090008@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:48304 "EHLO
	mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbaJBPSU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Oct 2014 11:18:20 -0400
In-Reply-To: <542C8D93.8090008@infradead.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Stephane,

can you please send a short patch for that to Marc/linux-can ?
I'm currently out of office.

Tnx,
Oliver


-------- Forwarded Message --------
Subject: Re: randconfig build error with next-20141001, in
drivers/i2c/algos/i2c-algo-bit.c
Date: Wed, 01 Oct 2014 16:26:11 -0700
=46rom: Randy Dunlap <rdunlap@infradead.org>
To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.or=
g.au>,
linux-next <linux-next@vger.kernel.org>, linux-kernel
<linux-kernel@vger.kernel.org>, wsa@the-dreams.de, khali@linux-fr.org, =
Paul
Gortmaker <paul.gortmaker@windriver.com>, linux-i2c@vger.kernel.org,
netdev@vger.kernel.org <netdev@vger.kernel.org>, linux-can@vger.kernel.=
org,
linux-media <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4al=
l.nl>

On 10/01/14 14:37, Jim Davis wrote:
> Building with the attached random configuration file,

Also:
warning: (CAN_PEAK_PCIEC && SFC && IGB && VIDEO_TW68 && DRM && FB_DDC &=
&
=46B_VIA) selects I2C_ALGOBIT which has unmet direct dependencies (I2C)

> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92:
> drivers/i2c/algos/i2c-algo-bit.c:658:33: error: =91i2c_add_adapter=92
> undeclared (first use in this function)
>   return __i2c_bit_add_bus(adap, i2c_add_adapter);
>                                  ^
> drivers/i2c/algos/i2c-algo-bit.c:658:33: note: each undeclared
> identifier is reported only once for each function it appears in
> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbered=
_bus=92:
> drivers/i2c/algos/i2c-algo-bit.c:664:33: error:
> =91i2c_add_numbered_adapter=92 undeclared (first use in this function=
)
>   return __i2c_bit_add_bus(adap, i2c_add_numbered_adapter);
>                                  ^
>   CC      net/openvswitch/actions.o
> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92:
> drivers/i2c/algos/i2c-algo-bit.c:659:1: warning: control reaches end =
of non-void
>  function [-Wreturn-type]
>  }
>  ^
> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbered=
_bus=92:
> drivers/i2c/algos/i2c-algo-bit.c:665:1: warning: control reaches end =
of non-void
>  function [-Wreturn-type]
>  }
>  ^
> make[3]: *** [drivers/i2c/algos/i2c-algo-bit.o] Error 1

In drivers/media/pci/tw68/Kconfig, VIDEO_TW68 should depend on I2C in o=
rder
to make it safe to select I2C_ALGOBIT.

In drivers/net/can/sja1000/Kconfig, CAN_PEAK_PCIEC should depend on I2C
instead of selecting I2C (and change the help text).


--=20
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


