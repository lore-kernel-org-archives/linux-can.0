From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change  handling.
Date: Wed, 22 Oct 2014 14:56:29 +0200
Message-ID: <2acb44ee148c76e61617e7d9090c7180@grandegger.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
 <14598c49d530f22df994073aff17d729@grandegger.com>
 <5446742F.1010709@marel.com>
 <e539ac222118cfa107f96444d2415750@grandegger.com>
 <5447998A.5080601@marel.com>
 <bf2a11ad672de92b98dfcd31405d2c88@grandegger.com>
 <5447A78B.8090501@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:41768 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933049AbaJVM4c (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Oct 2014 08:56:32 -0400
In-Reply-To: <5447A78B.8090501@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

On Wed, 22 Oct 2014 12:48:11 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On mi=C3=B0 22.okt 2014 12:30, Wolfgang Grandegger wrote:
>> On Wed, 22 Oct 2014 11:48:26 +0000, Andri Yngvason
>> <andri.yngvason@marel.com> wrote:
>>> On =C3=BEri 21.okt 2014 15:21, Wolfgang Grandegger wrote:
>>>>>>>> To see if the state changes occur as expected could you please
>> record
>>>>>>>> error message traces with candump for the following two
scenarios:
>>>>>>>>
>>>>>>>> 1. send messages with cangen
>>>>>>>>    disconnect the cable
>>>>>>>>    reconnect the cable after a while until the error active st=
ate
>> is
>>>>>>>>    reached.
>>> After cleaning up my mess, this is the output for the disconnected
cable
>>> test:
>>>  (000.000000)  can1  20000004   [8]  00 08 00 00 00 00 60 00 =20
>> ERRORFRAME
>>>         controller-problem{tx-error-warning}
>>>         error-counter-tx-rx{{96}{0}}
>>>  (000.003953)  can1  20000004   [8]  00 20 00 00 00 00 80 00 =20
>> ERRORFRAME
>>>         controller-problem{tx-error-passive}
>>>         error-counter-tx-rx{{128}{0}}
>>>  (005.959170)  can1  20000002   [8]  03 00 00 00 00 00 00 00 =20
>> ERRORFRAME
>>>         lost-arbitration{at bit 3}
>> I'm missing an error warning message here... at least on the SJA1000
it's
>> triggered.
> I found this peculiar as well. However, I don't get the warning witho=
ut
the
> patch applied either.

Yes, because reporting decreasing state changes are not (yet) supported=
=2E

> Then I just get:
> root@x86-20140911-072109:~# candump -td -e can1,0~0,#FFFFFFFF | tee
> candump.log                                                         =20
>  (000.000000)  can1  20000004   [8]  00 08 00 00 00 00 60 00 =20
ERRORFRAME
>         controller-problem{tx-error-warning}
>         error-counter-tx-rx{{96}{0}}
>  (000.002425)  can1  20000004   [8]  00 20 00 00 00 00 80 00 =20
ERRORFRAME
>         controller-problem{tx-error-passive}
>         error-counter-tx-rx{{128}{0}}
>=20

Could you please include the messages in the trace as well
(using "any,0:0,#FFFFFFFF").

>>
>>>  (000.428328)  can1  20000004   [8]  00 40 00 00 00 00 5F 00 =20
>> ERRORFRAME
>>>         controller-problem{back-to-error-active}
>>>         error-counter-tx-rx{{95}{0}}
>>>
>>>>>>>>>> 2. set restart-ms=3D100
>>>>>>>>>>    send messages with cangen
>>>>>>>>>>    provoke a bus-off short-circuiting CAN low and high
>>>>>>>>>>    remove the short-circuit
>>>>>>>>>>
>>> Shorting the can bus yields a loop like this:
>>>  (044.014170)  can1  20000004   [8]  00 20 00 00 00 00 88 00 =20
>> ERRORFRAME
>>>         controller-problem{tx-error-passive}
>>>         error-counter-tx-rx{{136}{0}}
>>>  (000.003175)  can1  20000040   [8]  00 00 00 00 00 00 7F 00 =20
>> ERRORFRAME
>>>         bus-off
>>>         error-counter-tx-rx{{127}{0}}
>>>  (000.099664)  can1  20000100   [8]  00 00 00 00 00 00 00 00 =20
>> ERRORFRAME
>>>         restarted-after-bus-off
>>>  (000.097246)  can1  20000004   [8]  00 20 00 00 00 00 88 00 =20
>> ERRORFRAME
>>>         controller-problem{tx-error-passive}
>>>         error-counter-tx-rx{{136}{0}}
>>>  (000.003160)  can1  20000040   [8]  00 00 00 00 00 00 7F 00 =20
>> ERRORFRAME
>>>         bus-off
>>>         error-counter-tx-rx{{127}{0}}
>>>  (000.099602)  can1  20000100   [8]  00 00 00 00 00 00 00 00 =20
>> ERRORFRAME
>>>         restarted-after-bus-off
>> And the restart does come when the short-circuit is gone?
>>
> No, in fact the bus keeps restarting until the short-circuit is gone.
>=20
> Note that I'm using peak_pci. It's sja1000 but maybe there is somethi=
ng
> different?

No, because it's a memory mapped SJA1000 chip. What do you see with
"dmesg"
assuming that CONFIG_CAN_DEV_DEBUG is enabled.

Wolfgang.

