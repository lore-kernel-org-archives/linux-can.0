From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next v2 2/4] can: cc770: add legacy ISA bus driver
 for the CC770 and AN82527
Date: Thu, 05 Jan 2012 20:45:37 +0100
Message-ID: <4F05FDE1.1040704@hartkopp.net>
References: <1322214204-1121-1-git-send-email-wg@grandegger.com> <1322214204-1121-3-git-send-email-wg@grandegger.com> <4ED0FEC5.3070108@hartkopp.net> <4ED34CAD.7040000@essax.com> <4ED351A8.8000102@grandegger.com> <4ED37885.8080909@essax.com> <4ED3B198.2040308@hartkopp.net> <4ED4A2EC.40103@grandegger.com> <4EDBC05D.8070109@essax.com> <4EDBC25D.50405@grandegger.com> <4EDE8435.5080100@essax.com> <4EDF6D54.2060503@grandegger.com> <4EE1E26B.6090308@grandegger.com> <4EE4F76E.3000506@essax.com> <4EE5C824.2050704@grandegger.com> <4EE5E321.8050104@essax.com> <4EE5EBBF.6080007@grandegger.com> <4EF22625.5000109@essax.com> <4EF2FA3F.3010308@grandegger.com> <4EF32E84.1080006@essax.com> <4EFED857.3000701@essax.com> <4F044FDC.60303@grandegger.com> <4F051927.8010600@essax.com> <4F058ED5.2000407@grandegger
 .com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:36974 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab2AETpy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2012 14:45:54 -0500
In-Reply-To: <4F058ED5.2000407@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, Henrik W Maier <henrik@focus-sw.com>, Wolfgang Zarre <info@essax.com>

Hello Wolfgang(s),

On 05.01.2012 12:51, Wolfgang Grandegger wrote:

>>>> diff --git a/drivers/net/can/cc770/cc770_isa.c
>>>> b/drivers/net/can/cc770/cc770_isa.c
>>>> index 4be5fe2..48fc128 100644
>>>> --- a/drivers/net/can/cc770/cc770_isa.c
>>>> +++ b/drivers/net/can/cc770/cc770_isa.c
>>>> @@ -148,8 +148,7 @@ static void cc770_isa_port_write_reg_indirect(=
const
>>>> struct cc770_priv *priv,
>>>>   {
>>>>       unsigned long base =3D (unsigned long)priv->reg_base;
>>>>
>>>> -    outb(reg, base);
>>>> -    outb(val, base + 1);
>>>> +    outw( reg + ( val<<  8), base);
>>>

>>> That modification does fix your problem, right? The others above do=
n't
>>> help nor harm but we don't know if it's really realted to the same
>>> problem. I wll dig a bit deeper.
>>
>> Exactly. The others above I removed because facing the opposite, eve=
n
>> missing interrupts but then just to avoid other possible side effect=
s
>> and then assuming that they might be related.
>=20
> OK. My concern: Can we be sure that 16bit accesses are always support=
ed
> by the hardware? Does a spinlock_irqsave/spinlock_irqrestore around t=
he
> 8bit accesses already help?
>=20
> About the "HM:" fixes, I did not find any info in the svn log. Maybe
> Oliver knows why they have been added.



No, in fact i don't know 8-)

As you can see from the initial commit msg here:

http://svn.berlios.de/wsvn/socketcan/branches/ha/candrv/kernel/2.6/driv=
ers/net/can/i82527/?rev=3D197&peg=3D197

"First implementation of i82527 socketcan driver based on parts from
socketcan sja1000 netdev / ocan hal / can4linux register access.
Know issues: Currently only receives SFF CAN frames due different
handling of SFF/EFF and RTR frames in opposite to the SJA1000 controlle=
r."

I took my sja1000 SocketCAN driver and tried to pick the register acces=
s
sniplets for the i82527 from (mostly) can4linux and kicked it until it
compiled ...

This register access part is from can4linux which has a long(!) develop=
ment
history too, where a special message regarding the ISR can be found, se=
e:

http://can4linux.svn.sourceforge.net/viewvc/can4linux/trunk/can4linux/i=
82527funcs.c?revision=3D36&view=3Dmarkup

/*
 * can_i82527funcs.c - i82527 related code
 *
 * Original version Written by Arnaud Westenberg email:arnaud@wanadoo.n=
l
 * This software is released under the GPL-License.
 *
 * Modified and extended to support the esd elctronic system
 * design gmbh PC/104-CAN Card (www.esd-electronics.com)
 * by Jean-Jacques Tchouto (tchouto@fokus.fraunhofer.de), 2003
 *
 * Major Refactoring and Integration into can4linux version 3.1 by
 * Henrik W Maier of FOCUS Software Engineering Pty Ltd <www.focus-sw.c=
om>
 *
 * Modified and extended to support the SBS PC7compact DINrail mounted
 * industry PC by FOCUS Software Engineering Pty Ltd <www.focus-sw.com>
 *
 * Updated for 2.6 kernel by Henrik W Maier of FOCUS Software
 * Engineering Pty Ltd <www.focus-sw.com>.
 * Bugfix in CAN_SendMessage, added wake_up_interruptible for irq_write=
_handler
 * Disabled redundant status change interrupt for RX/TX to decrease int
 * load on CPU.
 * Fixed issue of a second iteration in the ISR when sending because th=
e
 * send interrupt didn't sometimes get acknowledged.
 *
 * $Id: i82527funcs.c,v 1.1 2006/04/21 16:26:51 oe Exp $
 *
 */

My original hardware was the Eurotech COM 1274 board for the US DOT VII=
 OBU:
http://www.eurotech.com/en/download/com-1274

Obviously the ISR quirk code was added by Henrik W Maier from FOCUS Sof=
tware:

http://www.focus-sw.com/can/can4linux.html

Maybe Henrik or Heinz-J=FCrgen remember why this ISR handling has been =
added
more than seven years ago ... i added both of them in CC.

I hope the historical src code research helped a bit.

Indeed i was not aware of that long i82527 history inside the can4linux
driver. If there's any interest of the register access authors, we shou=
ld
add some credits into the cc770 driver.

Best regards,
Oliver

