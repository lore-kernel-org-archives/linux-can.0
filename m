From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: Fwd: Re: randconfig build error with next-20141001, in
 drivers/i2c/algos/i2c-algo-bit.c
Date: Mon, 06 Oct 2014 09:52:51 +0200
Message-ID: <54324A53.50409@peak-system.com>
References: <542C8D93.8090008@infradead.org> <542D6CB5.40206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:53421 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaJFHwz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 03:52:55 -0400
In-Reply-To: <542D6CB5.40206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Sorry I was not at the office last week too ... :-/

So, I send the patch to Marc asap ...

Regards,

St=E9phane



Le 02/10/2014 17:18, Oliver Hartkopp a =E9crit :
> Hello Stephane,
>
> can you please send a short patch for that to Marc/linux-can ?
> I'm currently out of office.
>
> Tnx,
> Oliver
>
>
> -------- Forwarded Message --------
> Subject: Re: randconfig build error with next-20141001, in
> drivers/i2c/algos/i2c-algo-bit.c
> Date: Wed, 01 Oct 2014 16:26:11 -0700
> From: Randy Dunlap <rdunlap@infradead.org>
> To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.=
org.au>,
> linux-next <linux-next@vger.kernel.org>, linux-kernel
> <linux-kernel@vger.kernel.org>, wsa@the-dreams.de, khali@linux-fr.org=
, Paul
> Gortmaker <paul.gortmaker@windriver.com>, linux-i2c@vger.kernel.org,
> netdev@vger.kernel.org <netdev@vger.kernel.org>, linux-can@vger.kerne=
l.org,
> linux-media <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4=
all.nl>
>
> On 10/01/14 14:37, Jim Davis wrote:
>> Building with the attached random configuration file,
> Also:
> warning: (CAN_PEAK_PCIEC && SFC && IGB && VIDEO_TW68 && DRM && FB_DDC=
 &&
> FB_VIA) selects I2C_ALGOBIT which has unmet direct dependencies (I2C)
>
>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92:
>> drivers/i2c/algos/i2c-algo-bit.c:658:33: error: =91i2c_add_adapter=92
>> undeclared (first use in this function)
>>    return __i2c_bit_add_bus(adap, i2c_add_adapter);
>>                                   ^
>> drivers/i2c/algos/i2c-algo-bit.c:658:33: note: each undeclared
>> identifier is reported only once for each function it appears in
>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbere=
d_bus=92:
>> drivers/i2c/algos/i2c-algo-bit.c:664:33: error:
>> =91i2c_add_numbered_adapter=92 undeclared (first use in this functio=
n)
>>    return __i2c_bit_add_bus(adap, i2c_add_numbered_adapter);
>>                                   ^
>>    CC      net/openvswitch/actions.o
>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92:
>> drivers/i2c/algos/i2c-algo-bit.c:659:1: warning: control reaches end=
 of non-void
>>   function [-Wreturn-type]
>>   }
>>   ^
>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbere=
d_bus=92:
>> drivers/i2c/algos/i2c-algo-bit.c:665:1: warning: control reaches end=
 of non-void
>>   function [-Wreturn-type]
>>   }
>>   ^
>> make[3]: *** [drivers/i2c/algos/i2c-algo-bit.o] Error 1
> In drivers/media/pci/tw68/Kconfig, VIDEO_TW68 should depend on I2C in=
 order
> to make it safe to select I2C_ALGOBIT.
>
> In drivers/net/can/sja1000/Kconfig, CAN_PEAK_PCIEC should depend on I=
2C
> instead of selecting I2C (and change the help text).
>
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
