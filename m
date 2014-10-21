From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change  handling.
Date: Tue, 21 Oct 2014 17:21:35 +0200
Message-ID: <e539ac222118cfa107f96444d2415750@grandegger.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
 <14598c49d530f22df994073aff17d729@grandegger.com>
 <5446742F.1010709@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:51842 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429AbaJUPVh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Oct 2014 11:21:37 -0400
In-Reply-To: <5446742F.1010709@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

On Tue, 21 Oct 2014 14:56:47 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On =C3=BEri 21.okt 2014 10:52, Wolfgang Grandegger wrote:
>> On Tue, 21 Oct 2014 10:42:27 +0000, Andri Yngvason
>> <andri.yngvason@marel.com> wrote:
>>> On m=C3=A1n 20.okt 2014 19:45, Wolfgang Grandegger wrote:
>>>> Hi Andri,
>>>>
>>>> sorry for the long delay...
>>> That's all right. I've been quite busy myself.
>>>> On 09/26/2014 08:25 PM, Andri Yngvason wrote:
>>>>> The handling of can error states is different between platforms.
>>>>> This is an attempt to correct that problem.
>>>>>
>>>>> I've moved this handling into a generic function for changing the
>>>>> error state. This ensures that error state changes are handled
>>>>> the same way everywhere (where this function is used).
>>>>>
>>>>> What's changed from the last version of this patch-set is that
>>>>> can_change_state() now relies on the individual states of the rx/=
tx
>>>>> counters rather than their individual count values.
>>>> To see if the state changes occur as expected could you please rec=
ord
>>>> error message traces with candump for the following two scenarios:
>>>>
>>>> 1. send messages with cangen
>>>>    disconnect the cable
>>>>    reconnect the cable after a while until the error active state =
is
>>>>    reached.
>>> I tried this the other day with flexcan. If there is nothing else
>>> happening on the bus, the error state will not go back down,
regardless
>>> of whether the patches are applied or not. However, this does work =
if
>>> another device is also sending on the bus.
>> If the device continues to send (because cangen is still running), t=
he
>> error counter should decrease. Don't know if the Flexcan does it rig=
ht
>> but it works like that on the SJA1000.
> It turns out that I can't get this to work on sja1000 either without
> sending
> from another device.
>=20
> Also, I must not have tested this properly because:
> root@x86-20140911-072109:~# candump can1,0~0,#FFFFFFFF | grep -v
20000002
>=20
>   can1  20000004  [8] 00 40 00 00 00 00 00 60   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 80   ERRORFRAME
>   can1  20000004  [8] 00 40 00 00 00 00 00 5F   ERRORFRAME
>=20
>=20
> The problem here is :
> +enum can_state can_errcnt_to_state(unsigned int count)
> +{
> +    if (unlikely(count > 127))
> +        return CAN_STATE_ERROR_PASSIVE;
> +
> +    if (unlikely(count > 96))
> +        return CAN_STATE_ERROR_WARNING;
> +
> +    return CAN_STATE_ERROR_ACTIVE;
> +}
>=20
> 96 aught to be 95, or perhaps it would make more sense to make the
checks
> count
>>=3D 128 and count >=3D 96, respectively.
>=20
> Maybe generate some error message if neither rx or tx states are grea=
ter
> than
> new_state?

This is how it should look like (from my old commits):

Here is an example output of "candump -td -e any,0:0,#FFFFFFFF" for
a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a SJA1000 on an on EMS PCI card:

 (000.201913)  can0   1C  [0]
 (000.212241)  can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
 (000.003544)  can0  20000204  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
        error-counter-tx-rx{{128}{0}}
 (004.901842)  can0   1D  [7] 1D F6 33 52 31 4B DE
 (000.000116)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
        state-change{tx-error-warning}
        error-counter-tx-rx{{127}{0}}
 (000.000678)  can0   1E  [6] 42 05 14 82 23 B6
 ...
 (000.201927)  can0   49  [4] 2F 1A 97 25
 (000.000096)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
        state-change{back-to-error-active}
        error-counter-tx-rx{{95}{0}}
 (000.202184)  can0   4A  [8] 7F 87 0E FE 03 BA 78 91

Messages are generated with "cangen", also while the cable is
disconnected.

> I'd written unit tests for this but I guess they don't really protect
you
> against "false predicate" errors.
>>
>>> Sadly, I did not save the logs.
>>>> 2. set restart-ms=3D100
>>>>    send messages with cangen
>>>>    provoke a bus-off short-circuiting CAN low and high
>>>>    remove the short-circuit
>>> That actually worked as expected. It's supposed to restart the bus,
>> right?
>>
>> The bus will automatically be restarted after 100 ms. The interestin=
g
>> part
>> is
>> the flow of the state changes (error messages).
> root@x86-20140911-072109:~# candump can1,0~0,#FFFFFFFF | grep -v
20000002
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
>   can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
>   can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
>   can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
>   can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
> etc...
>=20
> Here we get error-passive twice in a row. The error count is the same=
 in
> both
> cases though....

Why twice? The option "-td" would be useful as well.

Wolfgang.
