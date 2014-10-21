From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change
 handling.
Date: Tue, 21 Oct 2014 14:56:47 +0000
Message-ID: <5446742F.1010709@marel.com>
References: <5425AF94.5000206@marel.com> <5445666A.6090601@grandegger.com>
 <54463893.3090906@marel.com>
 <14598c49d530f22df994073aff17d729@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0081.outbound.protection.outlook.com ([157.56.111.81]:41280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750750AbaJUO6E (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Oct 2014 10:58:04 -0400
In-Reply-To: <14598c49d530f22df994073aff17d729@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On =C3=BEri 21.okt 2014 10:52, Wolfgang Grandegger wrote:
> On Tue, 21 Oct 2014 10:42:27 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
>> On m=C3=A1n 20.okt 2014 19:45, Wolfgang Grandegger wrote:
>>> Hi Andri,
>>>
>>> sorry for the long delay...
>> That's all right. I've been quite busy myself.
>>> On 09/26/2014 08:25 PM, Andri Yngvason wrote:
>>>> The handling of can error states is different between platforms.
>>>> This is an attempt to correct that problem.
>>>>
>>>> I've moved this handling into a generic function for changing the
>>>> error state. This ensures that error state changes are handled
>>>> the same way everywhere (where this function is used).
>>>>
>>>> What's changed from the last version of this patch-set is that
>>>> can_change_state() now relies on the individual states of the rx/t=
x
>>>> counters rather than their individual count values.
>>> To see if the state changes occur as expected could you please reco=
rd
>>> error message traces with candump for the following two scenarios:
>>>
>>> 1. send messages with cangen
>>>    disconnect the cable
>>>    reconnect the cable after a while until the error active state i=
s
>>>    reached.
>> I tried this the other day with flexcan. If there is nothing else
>> happening on the bus, the error state will not go back down, regardl=
ess
>> of whether the patches are applied or not. However, this does work i=
f
>> another device is also sending on the bus.
> If the device continues to send (because cangen is still running), th=
e
> error counter should decrease. Don't know if the Flexcan does it righ=
t
> but it works like that on the SJA1000.
It turns out that I can't get this to work on sja1000 either without se=
nding
from another device.

Also, I must not have tested this properly because:
root@x86-20140911-072109:~# candump can1,0~0,#FFFFFFFF | grep -v 200000=
02

  can1  20000004  [8] 00 40 00 00 00 00 00 60   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 80   ERRORFRAME
  can1  20000004  [8] 00 40 00 00 00 00 00 5F   ERRORFRAME


The problem here is :
+enum can_state can_errcnt_to_state(unsigned int count)
+{
+    if (unlikely(count > 127))
+        return CAN_STATE_ERROR_PASSIVE;
+
+    if (unlikely(count > 96))
+        return CAN_STATE_ERROR_WARNING;
+
+    return CAN_STATE_ERROR_ACTIVE;
+}

96 aught to be 95, or perhaps it would make more sense to make the chec=
ks count
>=3D 128 and count >=3D 96, respectively.

Maybe generate some error message if neither rx or tx states are greate=
r than
new_state?

I'd written unit tests for this but I guess they don't really protect y=
ou
against "false predicate" errors.
>
>> Sadly, I did not save the logs.
>>> 2. set restart-ms=3D100
>>>    send messages with cangen
>>>    provoke a bus-off short-circuiting CAN low and high
>>>    remove the short-circuit
>> That actually worked as expected. It's supposed to restart the bus,
> right?
>
> The bus will automatically be restarted after 100 ms. The interesting=
 part
> is
> the flow of the state changes (error messages).
root@x86-20140911-072109:~# candump can1,0~0,#FFFFFFFF | grep -v 200000=
02
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
  can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
  can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000004  [8] 00 20 00 00 00 00 00 88   ERRORFRAME
  can1  20000040  [8] 00 00 00 00 00 00 00 7F   ERRORFRAME
  can1  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
etc...

Here we get error-passive twice in a row. The error count is the same i=
n both
cases though....

I just noticed that I swapped tx and rx in data[6..7]. I'll have to fix=
 that too.
>
>>> Start with the SJA100 first.
>>>
>> I'll try to find some time for these experiments.
>>
Best regards,
Andri
