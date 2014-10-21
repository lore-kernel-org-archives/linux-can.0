From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change handling.
Date: Tue, 21 Oct 2014 10:42:27 +0000
Message-ID: <54463893.3090906@marel.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0074.outbound.protection.outlook.com ([207.46.100.74]:30160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932300AbaJUKn4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Oct 2014 06:43:56 -0400
In-Reply-To: <5445666A.6090601@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


On m=C3=A1n 20.okt 2014 19:45, Wolfgang Grandegger wrote:
> Hi Andri,
>
> sorry for the long delay...
That's all right. I've been quite busy myself.
>
> On 09/26/2014 08:25 PM, Andri Yngvason wrote:
>> The handling of can error states is different between platforms.
>> This is an attempt to correct that problem.
>>
>> I've moved this handling into a generic function for changing the
>> error state. This ensures that error state changes are handled
>> the same way everywhere (where this function is used).
>>
>> What's changed from the last version of this patch-set is that
>> can_change_state() now relies on the individual states of the rx/tx
>> counters rather than their individual count values.
> To see if the state changes occur as expected could you please record
> error message traces with candump for the following two scenarios:
>
> 1. send messages with cangen
>    disconnect the cable
>    reconnect the cable after a while until the error active state is
>    reached.
I tried this the other day with flexcan. If there is nothing else
happening on the bus, the error state will not go back down, regardless
of whether the patches are applied or not. However, this does work if
another device is also sending on the bus.

Sadly, I did not save the logs.
>
> 2. set restart-ms=3D100
>    send messages with cangen
>    provoke a bus-off short-circuiting CAN low and high
>    remove the short-circuit
That actually worked as expected. It's supposed to restart the bus, rig=
ht?
>
> Start with the SJA100 first.
>
I'll try to find some time for these experiments.

Thanks,
Andri
