From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 18:03:37 +0100
Message-ID: <4F451FE9.8050604@peak-system.com>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
 <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net>
 <4F450777.3010301@peak-system.com> <4F451161.3020803@hartkopp.net>
 <4F4518CF.6070207@peak-system.com> <4F451A81.4070009@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:55657 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab2BVRDq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 12:03:46 -0500
In-Reply-To: <4F451A81.4070009@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 22/02/2012 17:40, Oliver Hartkopp a =E9crit :
> On 22.02.2012 17:33, Stephane Grosjean wrote:
>
>> Le 22/02/2012 17:01, Oliver Hartkopp a =E9crit :
>>
>>> Pls try the following:
>>>
>>> PC1:
>>> can0 ->   usb-pro ch1 ----+
>>> can1 ->   usb-pro ch2 -+  |
>>> can2 ->   usb ---------+  |
>>>                        |  | 1Mpbs
>>> PC2:                 |  |
>>> can0 ->   pcmcia ch1 --+  |
>>> can1 ->   pcmcia ch2 -----+
>>>
>>> PC1:
>>> cangen -g0 -i can0
>>> cangen -g0 -i can1
>>> candump any
>>>
>>> PC2:
>>> cangen -g0 -i can0
>>> cangen -g0 -i can1
>>> candump any
>>>
>>> and then pull the usb-pro from PC1 ...
>>>
>>> That's really unfriendly 8-)
>>
>> Ok, I found another cable and set up your tesbed: now the usb-pro is=
 pulled
>> and both "candump" always are displaying data sent by "cangen can0" =
from PC2
>> and read from pcan-usb on PC1... Both drivers can be removed without=
 any problem.
>
> cangen can0 only on PC2?
>
> pls put the cangen on PC2 _and_ PC1 as shown above.
>

Sorry but your scheme showed cangen only on can0 and can1... which are=20
mapped to usb-pro can interfaces. on PC1, which is pulled from PC1! So,=
=20
no more can data is sent from PC1! Remains only "cangen can0" from PC2!
I just did another test, adding "cangen can2" on PC1 too... Everything=20
is still ok, on both sides...

>
>>> Please check this use-case above. And when it works with your fixed=
 driver you
>>> can probalby check the 'old' v5 version to see if you can follow my=
 bug report
>>> on your setup.
>> ???
>> I'm sorry I don't understand what you mean: why should I check the v=
5 version?
>
> Didn't you write that you made some changes before the test??
>> And what is (to) "follow your bug report on my setup" ???
>
> I just wanted to make sure that you can see the same effect with your=
 setup
> that i had with version 5.

Ok, confusion came from the fact that, once I did modifications into v5=
,=20
this automatically became a "v6"  for me ...
So you want me to reproduce your crash using the "old" v5, right? I=20
already did that, I confirm that the pc hanged with v5, removing the=20
driver and/or pulling (one of) the usb adapters.

Should I now wait for any linux-usb ml review before posting this v6?

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
