From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: Fwd: Re: randconfig build error with next-20141001, in
 drivers/i2c/algos/i2c-algo-bit.c
Date: Mon, 06 Oct 2014 10:42:52 +0200
Message-ID: <5432560C.8070103@peak-system.com>
References: <542C8D93.8090008@infradead.org> <542D6CB5.40206@hartkopp.net>
 <54324A53.50409@peak-system.com> <54324E56.2030109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:54160 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaJFIvS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 04:51:18 -0400
In-Reply-To: <54324E56.2030109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Le 06/10/2014 10:09, Oliver Hartkopp a =E9crit :
> Hi Stephane,
>
> I'm back home.
>
> But I wondered if this problem really is a problem with our current K=
config.

Well, you're right when you say that the PEAK_PCIEC option won't be=20
visible if CONFIG_I2C is not selected.
AFAIR, my first  version of Kconfig used the "depends on" keyword rathe=
r=20
then the "select" one.
Anyway, if we had to change this Kconfig, we could take the opportunity=
=20
to upgrade the help text, by adding the info of the support of the new=20
PCAN-ExpressCard 34.

Regards,

St=E9phane

>
> Let's first wait for the answer from the complaining guys.
>
> Best regards,
> Oliver
>
> On 10/06/2014 09:52 AM, Stephane Grosjean wrote:
>> Hi Oliver,
>>
>> Sorry I was not at the office last week too ... :-/
>>
>> So, I send the patch to Marc asap ...
>>
>> Regards,
>>
>> St=E9phane
>>
>>
>>
>> Le 02/10/2014 17:18, Oliver Hartkopp a =E9crit :
>>> Hello Stephane,
>>>
>>> can you please send a short patch for that to Marc/linux-can ?
>>> I'm currently out of office.
>>>
>>> Tnx,
>>> Oliver
>>>
>>>
>>> -------- Forwarded Message --------
>>> Subject: Re: randconfig build error with next-20141001, in
>>> drivers/i2c/algos/i2c-algo-bit.c
>>> Date: Wed, 01 Oct 2014 16:26:11 -0700
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>> To: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auu=
g.org.au>,
>>> linux-next <linux-next@vger.kernel.org>, linux-kernel
>>> <linux-kernel@vger.kernel.org>, wsa@the-dreams.de, khali@linux-fr.o=
rg, Paul
>>> Gortmaker <paul.gortmaker@windriver.com>, linux-i2c@vger.kernel.org=
,
>>> netdev@vger.kernel.org <netdev@vger.kernel.org>, linux-can@vger.ker=
nel.org,
>>> linux-media <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@x=
s4all.nl>
>>>
>>> On 10/01/14 14:37, Jim Davis wrote:
>>>> Building with the attached random configuration file,
>>> Also:
>>> warning: (CAN_PEAK_PCIEC && SFC && IGB && VIDEO_TW68 && DRM && FB_D=
DC &&
>>> FB_VIA) selects I2C_ALGOBIT which has unmet direct dependencies (I2=
C)
>>>
>>>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92=
:
>>>> drivers/i2c/algos/i2c-algo-bit.c:658:33: error: =91i2c_add_adapter=
=92
>>>> undeclared (first use in this function)
>>>>     return __i2c_bit_add_bus(adap, i2c_add_adapter);
>>>>                                    ^
>>>> drivers/i2c/algos/i2c-algo-bit.c:658:33: note: each undeclared
>>>> identifier is reported only once for each function it appears in
>>>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbe=
red_bus=92:
>>>> drivers/i2c/algos/i2c-algo-bit.c:664:33: error:
>>>> =91i2c_add_numbered_adapter=92 undeclared (first use in this funct=
ion)
>>>>     return __i2c_bit_add_bus(adap, i2c_add_numbered_adapter);
>>>>                                    ^
>>>>     CC      net/openvswitch/actions.o
>>>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_bus=92=
:
>>>> drivers/i2c/algos/i2c-algo-bit.c:659:1: warning: control reaches e=
nd of
>>>> non-void
>>>>    function [-Wreturn-type]
>>>>    }
>>>>    ^
>>>> drivers/i2c/algos/i2c-algo-bit.c: In function =91i2c_bit_add_numbe=
red_bus=92:
>>>> drivers/i2c/algos/i2c-algo-bit.c:665:1: warning: control reaches e=
nd of
>>>> non-void
>>>>    function [-Wreturn-type]
>>>>    }
>>>>    ^
>>>> make[3]: *** [drivers/i2c/algos/i2c-algo-bit.o] Error 1
>>> In drivers/media/pci/tw68/Kconfig, VIDEO_TW68 should depend on I2C =
in order
>>> to make it safe to select I2C_ALGOBIT.
>>>
>>> In drivers/net/can/sja1000/Kconfig, CAN_PEAK_PCIEC should depend on=
 I2C
>>> instead of selecting I2C (and change the help text).
>>>
>>>
>> --=20
>> PEAK-System Technik GmbH
>> Sitz der Gesellschaft Darmstadt
>> Handelsregister Darmstadt HRB 9183 Geschaeftsfuehrung: Alexander Gac=
h, Uwe
>> Wilhelm
>> --=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
