From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change  handling.
Date: Tue, 21 Oct 2014 12:52:37 +0200
Message-ID: <14598c49d530f22df994073aff17d729@grandegger.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:48966 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbaJUKwj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Oct 2014 06:52:39 -0400
In-Reply-To: <54463893.3090906@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

On Tue, 21 Oct 2014 10:42:27 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On m=C3=A1n 20.okt 2014 19:45, Wolfgang Grandegger wrote:
>> Hi Andri,
>>
>> sorry for the long delay...
> That's all right. I've been quite busy myself.
>>
>> On 09/26/2014 08:25 PM, Andri Yngvason wrote:
>>> The handling of can error states is different between platforms.
>>> This is an attempt to correct that problem.
>>>
>>> I've moved this handling into a generic function for changing the
>>> error state. This ensures that error state changes are handled
>>> the same way everywhere (where this function is used).
>>>
>>> What's changed from the last version of this patch-set is that
>>> can_change_state() now relies on the individual states of the rx/tx
>>> counters rather than their individual count values.
>> To see if the state changes occur as expected could you please recor=
d
>> error message traces with candump for the following two scenarios:
>>
>> 1. send messages with cangen
>>    disconnect the cable
>>    reconnect the cable after a while until the error active state is
>>    reached.
> I tried this the other day with flexcan. If there is nothing else
> happening on the bus, the error state will not go back down, regardle=
ss
> of whether the patches are applied or not. However, this does work if
> another device is also sending on the bus.

If the device continues to send (because cangen is still running), the
error counter should decrease. Don't know if the Flexcan does it right
but it works like that on the SJA1000.

>=20
> Sadly, I did not save the logs.
>>
>> 2. set restart-ms=3D100
>>    send messages with cangen
>>    provoke a bus-off short-circuiting CAN low and high
>>    remove the short-circuit
> That actually worked as expected. It's supposed to restart the bus,
right?

The bus will automatically be restarted after 100 ms. The interesting p=
art
is
the flow of the state changes (error messages).

>> Start with the SJA100 first.
>>
> I'll try to find some time for these experiments.

Thanks,

Wolfgang.
