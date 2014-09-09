From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: Inconsistent error state transition error frames
Date: Tue, 9 Sep 2014 14:49:58 +0000
Message-ID: <540F1396.2030702@marel.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
 <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
 <540EEBA0.9080209@marel.com>
 <56f33e0559ffda649925492dca2720fd@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:37287
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751538AbaIIOuR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Sep 2014 10:50:17 -0400
In-Reply-To: <56f33e0559ffda649925492dca2720fd@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On =C3=BEri 9.sep 2014 13:53, Wolfgang Grandegger wrote:
> On Tue, 9 Sep 2014 11:59:28 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
>> On =C3=BEri 9.sep 2014 10:48, Wolfgang Grandegger wrote:
>>> On Mon, 08 Sep 2014 18:36:38 +0200, Marc Kleine-Budde
>>> <mkl@pengutronix.de>
>>> wrote:
>>>> On 09/08/2014 06:26 PM, Andri Yngvason wrote:
>>>>> I've been working on a userspace program to monitor the CAN bus a=
nd I
>>>>> found that it only works as expected on one platform (flexcan). T=
he
>>>>> problem is that on most other platforms, no error frame is emitte=
d
>>>>> when the controller transitions back to error-active state. I see
>>> Also the Flexcan implementation does not correctly change the error
>>> states backwards, IIRC.
>> It does report the state changes backwards, but it uses
>> CAN_ERR_PROT_ACTIVE for error-active state, which does have "ACTIVE"=
 in
>> the name, but it's probably originally intended for something else a=
nd
>> isn't at all consistent with other error state can frames.
> Yes, the "error in CAN protocol" flag was misused somehow. It's
> misleading,
> at least.
>
>>>>> that you've already discussed this on this list here:
>>>>> http://thread.gmane.org/gmane.linux.can/201
>>>>>
>>>>> Why hasn't this been resolved?
>>>> I assume no one needed this feature so far, I assume. And/or cared=
 not
>>>> enough to upstream these patches.
>>> Yep, little time left for free software development, lack of hardwa=
re,
>>> etc. Somebody needs to care and post patches. Anyway, that's a good
>>> occasion to start a migration path, maybe first for the Flexcan and
>>> SJA1000 and MSCAN.
>>>
>>>>> I already patched the mscan and sja1000 drivers myself, and I was
>>>>> considering submitting them, but since you've already done some w=
ork
>>>>> on this (which I believe is superior to mine), my work is unlikel=
y to
>>>> Wolfgang mentioned in this mail, that he had some patches back tha=
n.
> Do
>>>> you still have them, Wolfgang?
>>> The patches to consolidate bus-off and error-state handling are sti=
ll
>>> at:
>>>
>>>
> https://gitorious.org/linux-can/wg-linux-can-next/commits/eec921ac28f=
de243456078a557768808d93d94a3
> https://gitorious.org/linux-can/wg-linux-can-next/commit/825f9bcb961a=
a193bacb9af6fb0d8491ee8fd02e
>>> They introduce the can_id flag CAN_ERR_STATE_CHANGE and the data[1]
> flag
>>> CAN_ERR_CRTL_ACTIVE, which I think would simplify migration. Also
>>> there is now a common function can_change_state() which should make
>>> the driver code more readable.
>> Presumably, we'll need to rebase these changes. Would you like to do
>> that or would you like me to do it and post the patches? Admittedly,=
 I
> Would be really nice if you could find time. At least it would be fas=
ter
> and more efficient (as I do not have hardware at hand). For an RFC pa=
tch
> to consolidate the error-state handling the generic part and one or t=
wo
> drivers using it would just be fine. Proper bus-off handling could be
> addressed separately.
>
>> haven't posted patches to the kernel before, but I've read the
>> documentation and hopefully I'll get it right. ;)
> Don't worry. You will learn it quickly.
Thanks for the reassurance. Which branch should I rebase against,=20
linux-can or linux-can-next?
>>>>> be of any consequence to this community, except to show that this
>>>>> inconsistency does indeed result in wasted effort and frustration=
=2E
>>>> Feel free to post your patches.
>>>>
>>>>> Of course, I'll help out if I can, e.g. by testing on the platfor=
ms
>>>>> that I have available.
>>> That would be very useful. Currently I do not have any CAN hardware=
 at
>>> hand.
>> One last thing: The canutils project assumes that the flexcan way of
>> error-state reporting is correct, but that might break if we apply t=
hese
>> changes, so I guess that we'll have to change that too.
> Yes, can-utils needs to be updated as well and maybe we even need som=
e
> kind of version number or flag in the CAN error messages to act prope=
rly.
>
>
It seems that 'data' is fully occupied, although 'data[5..7]' isn't=20
reserved for anything specific but rather "controller specific=20
additional information". Could we maybe put the version into data 5, 6 =
or 7?

Another option is to place it into the 3 or 4 msb of the id; something=20
like this:
#define CAN_ERR_VERSION_MASK 0x1E000000U  // Note: CAN_ERR_MASK is=20
0x1FFFFFFFU

Are 15 possible versions enough (or even too much)?

Andri.


