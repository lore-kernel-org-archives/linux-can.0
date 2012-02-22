From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 17:40:33 +0100
Message-ID: <4F451A81.4070009@hartkopp.net>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com> <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net> <4F450777.3010301@peak-system.com> <4F451161.3020803@hartkopp.net> <4F4518CF.6070207@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:40402 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2BVQkz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 11:40:55 -0500
In-Reply-To: <4F4518CF.6070207@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 22.02.2012 17:33, Stephane Grosjean wrote:

> Le 22/02/2012 17:01, Oliver Hartkopp a =E9crit :
>=20
>> Pls try the following:
>>
>> PC1:
>> can0 ->  usb-pro ch1 ----+
>> can1 ->  usb-pro ch2 -+  |
>> can2 ->  usb ---------+  |
>>                       |  | 1Mpbs
>> PC2:                 |  |
>> can0 ->  pcmcia ch1 --+  |
>> can1 ->  pcmcia ch2 -----+
>>
>> PC1:
>> cangen -g0 -i can0
>> cangen -g0 -i can1
>> candump any
>>
>> PC2:
>> cangen -g0 -i can0
>> cangen -g0 -i can1
>> candump any
>>
>> and then pull the usb-pro from PC1 ...
>>
>> That's really unfriendly 8-)
>=20
>=20
> Ok, I found another cable and set up your tesbed: now the usb-pro is =
pulled
> and both "candump" always are displaying data sent by "cangen can0" f=
rom PC2
> and read from pcan-usb on PC1... Both drivers can be removed without =
any problem.


cangen can0 only on PC2?

pls put the cangen on PC2 _and_ PC1 as shown above.


>>
>> Please check this use-case above. And when it works with your fixed =
driver you
>> can probalby check the 'old' v5 version to see if you can follow my =
bug report
>> on your setup.
>=20
> ???
> I'm sorry I don't understand what you mean: why should I check the v5=
 version?


Didn't you write that you made some changes before the test??

> And what is (to) "follow your bug report on my setup" ???


I just wanted to make sure that you can see the same effect with your s=
etup
that i had with version 5.

Regards,
Oliver
