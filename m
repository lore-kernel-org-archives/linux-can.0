From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 18:50:37 +0100
Message-ID: <4F452AED.2090608@hartkopp.net>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com> <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net> <4F450777.3010301@peak-system.com> <4F451161.3020803@hartkopp.net> <4F4518CF.6070207@peak-system.com> <4F451A81.4070009@hartkopp.net> <4F451FE9.8050604@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:48494 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab2BVRvA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 12:51:00 -0500
In-Reply-To: <4F451FE9.8050604@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 22.02.2012 18:03, Stephane Grosjean wrote:

> Le 22/02/2012 17:40, Oliver Hartkopp a =E9crit :
>> On 22.02.2012 17:33, Stephane Grosjean wrote:
>>
>>> Le 22/02/2012 17:01, Oliver Hartkopp a =E9crit :
>>>
>>>> Pls try the following:
>>>>
>>>> PC1:
>>>> can0 ->   usb-pro ch1 ----+
>>>> can1 ->   usb-pro ch2 -+  |
>>>> can2 ->   usb ---------+  |
>>>>                        |  | 1Mpbs
>>>> PC2:                 |  |
>>>> can0 ->   pcmcia ch1 --+  |
>>>> can1 ->   pcmcia ch2 -----+
>>>>
>>>> PC1:
>>>> cangen -g0 -i can0
>>>> cangen -g0 -i can1
>>>> candump any
>>>>
>>>> PC2:
>>>> cangen -g0 -i can0
>>>> cangen -g0 -i can1
>>>> candump any
>>>>
>>>> and then pull the usb-pro from PC1 ...
>>>>
>>>> That's really unfriendly 8-)
>>>
>>> Ok, I found another cable and set up your tesbed: now the usb-pro i=
s pulled
>>> and both "candump" always are displaying data sent by "cangen can0"=
 from PC2
>>> and read from pcan-usb on PC1... Both drivers can be removed withou=
t any
>>> problem.
>>
>> cangen can0 only on PC2?
>>
>> pls put the cangen on PC2 _and_ PC1 as shown above.
>>
>=20
> Sorry but your scheme showed cangen only on can0 and can1... which ar=
e mapped
> to usb-pro can interfaces. on PC1, which is pulled from PC1! So, no m=
ore can
> data is sent from PC1! Remains only "cangen can0" from PC2!


It's not relevant if there's any traffic left, when you pulled the usb-=
pro.

The trick is to get maximum load (rx AND tx) to the USB adapter when
disconnecting the USB.

Therefore putting max tx load to _both_ PCs CAN interfaces was my plan =
- and
this is presented in the testbed description IMHO. Or did i miss anythi=
ng?

> I just did another test, adding "cangen can2" on PC1 too... Everythin=
g is
> still ok, on both sides...


=46ine.


>>> And what is (to) "follow your bug report on my setup" ???
>>
>> I just wanted to make sure that you can see the same effect with you=
r setup
>> that i had with version 5.
>=20
> Ok, confusion came from the fact that, once I did modifications into =
v5, this
> automatically became a "v6"  for me ...
> So you want me to reproduce your crash using the "old" v5, right? I a=
lready
> did that, I confirm that the pc hanged with v5, removing the driver a=
nd/or
> pulling (one of) the usb adapters.


Ah, ok. That's important. Because if i would had any problems that you =
do not
see in your setup, my testbed might have been broken or my kernel might=
 be
misconfigured for that testing purpose.

> Should I now wait for any linux-usb ml review before posting this v6?


IMO it makes no sense to review an outdated patch.

Please post your v6 as you did for the v5 - adding some changelog.

Regards,
Oliver
