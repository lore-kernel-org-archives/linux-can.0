From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change
 handling.
Date: Wed, 22 Oct 2014 12:48:11 +0000
Message-ID: <5447A78B.8090501@marel.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
 <14598c49d530f22df994073aff17d729@grandegger.com>
 <5446742F.1010709@marel.com>
 <e539ac222118cfa107f96444d2415750@grandegger.com>
 <5447998A.5080601@marel.com>
 <bf2a11ad672de92b98dfcd31405d2c88@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [157.56.110.80] ([157.56.110.80]:6005 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933049AbaJVMuG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Oct 2014 08:50:06 -0400
In-Reply-To: <bf2a11ad672de92b98dfcd31405d2c88@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On mi=C3=B0 22.okt 2014 12:30, Wolfgang Grandegger wrote:
> On Wed, 22 Oct 2014 11:48:26 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
>> On =C3=BEri 21.okt 2014 15:21, Wolfgang Grandegger wrote:
>>>>>>> To see if the state changes occur as expected could you please
> record
>>>>>>> error message traces with candump for the following two scenari=
os:
>>>>>>>
>>>>>>> 1. send messages with cangen
>>>>>>>    disconnect the cable
>>>>>>>    reconnect the cable after a while until the error active sta=
te
> is
>>>>>>>    reached.
>> After cleaning up my mess, this is the output for the disconnected c=
able
>> test:
>>  (000.000000)  can1  20000004   [8]  00 08 00 00 00 00 60 00 =20
> ERRORFRAME
>>         controller-problem{tx-error-warning}
>>         error-counter-tx-rx{{96}{0}}
>>  (000.003953)  can1  20000004   [8]  00 20 00 00 00 00 80 00 =20
> ERRORFRAME
>>         controller-problem{tx-error-passive}
>>         error-counter-tx-rx{{128}{0}}
>>  (005.959170)  can1  20000002   [8]  03 00 00 00 00 00 00 00 =20
> ERRORFRAME
>>         lost-arbitration{at bit 3}
> I'm missing an error warning message here... at least on the SJA1000 =
it's
> triggered.
I found this peculiar as well. However, I don't get the warning without=
 the
patch applied either.
Then I just get:
root@x86-20140911-072109:~# candump -td -e can1,0~0,#FFFFFFFF | tee
candump.log                                                         =20
 (000.000000)  can1  20000004   [8]  00 08 00 00 00 00 60 00   ERRORFRA=
ME
        controller-problem{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
 (000.002425)  can1  20000004   [8]  00 20 00 00 00 00 80 00   ERRORFRA=
ME
        controller-problem{tx-error-passive}
        error-counter-tx-rx{{128}{0}}

>
>>  (000.428328)  can1  20000004   [8]  00 40 00 00 00 00 5F 00 =20
> ERRORFRAME
>>         controller-problem{back-to-error-active}
>>         error-counter-tx-rx{{95}{0}}
>>
>>>>>>>>> 2. set restart-ms=3D100
>>>>>>>>>    send messages with cangen
>>>>>>>>>    provoke a bus-off short-circuiting CAN low and high
>>>>>>>>>    remove the short-circuit
>>>>>>>>>
>> Shorting the can bus yields a loop like this:
>>  (044.014170)  can1  20000004   [8]  00 20 00 00 00 00 88 00 =20
> ERRORFRAME
>>         controller-problem{tx-error-passive}
>>         error-counter-tx-rx{{136}{0}}
>>  (000.003175)  can1  20000040   [8]  00 00 00 00 00 00 7F 00 =20
> ERRORFRAME
>>         bus-off
>>         error-counter-tx-rx{{127}{0}}
>>  (000.099664)  can1  20000100   [8]  00 00 00 00 00 00 00 00 =20
> ERRORFRAME
>>         restarted-after-bus-off
>>  (000.097246)  can1  20000004   [8]  00 20 00 00 00 00 88 00 =20
> ERRORFRAME
>>         controller-problem{tx-error-passive}
>>         error-counter-tx-rx{{136}{0}}
>>  (000.003160)  can1  20000040   [8]  00 00 00 00 00 00 7F 00 =20
> ERRORFRAME
>>         bus-off
>>         error-counter-tx-rx{{127}{0}}
>>  (000.099602)  can1  20000100   [8]  00 00 00 00 00 00 00 00 =20
> ERRORFRAME
>>         restarted-after-bus-off
> And the restart does come when the short-circuit is gone?
>
No, in fact the bus keeps restarting until the short-circuit is gone.

Note that I'm using peak_pci. It's sja1000 but maybe there is something=
 different?

- Andri

