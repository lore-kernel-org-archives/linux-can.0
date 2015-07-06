From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [BULK]Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong
 assumption in raw_rcv
Date: Mon, 06 Jul 2015 09:58:14 +0200
Message-ID: <559A3516.7080404@peak-system.com>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net>
 <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net>
 <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net>
 <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net>
 <558BBC92.6040906@peak-system.com>
 <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store>
 <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:37538 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbbGFH63 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jul 2015 03:58:29 -0400
In-Reply-To: <55980FCE.4030304@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, tom_usenet@optusnet.com.au, Manfred Schlaegl <manfred.schlaegl@gmx.at>

Hi Oliver,

${CUSTOMER}'s problem was rather a "loss of frame" issue than an=20
"out-of-order" issue... In fact, it seems it was a simple "rookie" erro=
r=20
of non-testing errno =3D=3D ENOBUF after having written on the CAN sock=
et.

Regards,

St=C3=A9phane

Le 04/07/2015 18:54, Oliver Hartkopp a =C3=A9crit :
> Hi Stephane,
>
> On 29.06.2015 18:13, Oliver Hartkopp wrote:
>> Hi Stephane,
>>
>> On 25.06.2015 11:36, Oliver Hartkopp wrote:
>>>> Stephane Grosjean <s.grosjean@peak-system.com>
>>>> (..)
>>>> tells that he's facing some loss of frames with the PEAK-System=20
>>>> PCAN-USB
>>>> adapter, in case of "relatively"  high bus load... He's running tw=
o
>>>> Kernels (3.19 and the last 4.1 patched with this recent "fix"). At=
 the
>>>> moment, he says he always notes some frame leakage, especially whe=
n he
>>>> (for example) "resizes windows on his desktop"...
>
> Is $COSTUMERs problem fixed now?
>
> While testing the patches
>
> can: fix loss of CAN frames in raw_rcv
> http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/commit/=
?h=3Dtesting&id=3D36c01245eb8046c16eee6431e7dbfbb302635fa8=20
>
>
> and
>
> can: replace timestamp as unique skb attribute
> http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/commit/=
?h=3Dtesting&id=3Da6ffebda241e513f6e839662d769b60b084d0957=20
>
>
> I discovered an increase of out-of-order CAN frame receptions.
> My setup is a core i7 with a PCAN USB and a PCAN USB pro connected to=
=20
> my full busload CAN source (1MBit/s, ~8008 frames/s).
>
> With 3.16 the out-of-order CAN frame reception is 'relatively' seldom=
=2E
> It's more with the PCAN USB and very few with PCAN USB pro.
>
> With the latest 4.2-merge the effect is reproducible after some time=20
> (~10min).
>
> Examples:
>
>  drop detected: expected 204 received 212
>  drop detected: expected 237 received 204
>  drop detected: expected 212 received 237
>  drop detected: expected 68 received 69
>  drop detected: expected 70 received 68
>  drop detected: expected 69 received 70
>
> Obviously the frames do not get lost BUT are reordered.
>
> newcounter =3D frame.data[0];
> if (((counter + 1) & 0xFF) !=3D newcounter) {
>  printf(" drop detected: expected %u received %u\n", counter + 1,=20
> newcounter);
> }
> counter =3D newcounter;
>
> I'm a bit confused as this effect seems to increase with Linux kernel=
=20
> version numbers. I removed all the changes for 4.1 in the 4.2-merge=20
> kernel to have a 4.0 CAN subsystem (which was stable for a long time)=
=20
> - but even this patch removal did not fix the out of order reception.
>
> Good thing: The latest changes in 4.1 (which patches) do not drop CAN=
=20
> frames by accident.
>
> Bad thing: Why is the out-of-order reception increasing in Linux?
>
> I /assume/ some changes with RPS (receive packet steering) in the=20
> network layer ...
>
>
> Regards,
> Oliver
> --=20
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
