From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: Inconsistent error state transition error frames
Date: Tue, 9 Sep 2014 11:59:28 +0000
Message-ID: <540EEBA0.9080209@marel.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
 <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:2954
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752908AbaIIL7e (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Sep 2014 07:59:34 -0400
In-Reply-To: <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org


On =C3=BEri 9.sep 2014 10:48, Wolfgang Grandegger wrote:
> On Mon, 08 Sep 2014 18:36:38 +0200, Marc Kleine-Budde <mkl@pengutroni=
x.de>
> wrote:
>> On 09/08/2014 06:26 PM, Andri Yngvason wrote:
>>> I've been working on a userspace program to monitor the CAN bus and=
 I
>>> found that it only works as expected on one platform (flexcan). The
>>> problem is that on most other platforms, no error frame is emitted
>>> when the controller transitions back to error-active state. I see
> Also the Flexcan implementation does not correctly change the error
> states backwards, IIRC.
It does report the state changes backwards, but it uses=20
CAN_ERR_PROT_ACTIVE for error-active state, which does have "ACTIVE" in=
=20
the name, but it's probably originally intended for something else and=20
isn't at all consistent with other error state can frames.
>>> that you've already discussed this on this list here:
>>> http://thread.gmane.org/gmane.linux.can/201
>>>
>>> Why hasn't this been resolved?
>> I assume no one needed this feature so far, I assume. And/or cared n=
ot
>> enough to upstream these patches.
> Yep, little time left for free software development, lack of hardware=
,
> etc. Somebody needs to care and post patches. Anyway, that's a good
> occasion to start a migration path, maybe first for the Flexcan and
> SJA1000 and MSCAN.
>
>>> I already patched the mscan and sja1000 drivers myself, and I was
>>> considering submitting them, but since you've already done some wor=
k
>>> on this (which I believe is superior to mine), my work is unlikely =
to
>> Wolfgang mentioned in this mail, that he had some patches back than.=
 Do
>> you still have them, Wolfgang?
> The patches to consolidate bus-off and error-state handling are still
> at:
>
> https://gitorious.org/linux-can/wg-linux-can-next/commits/eec921ac28f=
de243456078a557768808d93d94a3
> https://gitorious.org/linux-can/wg-linux-can-next/commit/825f9bcb961a=
a193bacb9af6fb0d8491ee8fd02e
>
> They introduce the can_id flag CAN_ERR_STATE_CHANGE and the data[1] f=
lag
> CAN_ERR_CRTL_ACTIVE, which I think would simplify migration. Also
> there is now a common function can_change_state() which should make
> the driver code more readable.
Presumably, we'll need to rebase these changes. Would you like to do=20
that or would you like me to do it and post the patches? Admittedly, I=20
haven't posted patches to the kernel before, but I've read the=20
documentation and hopefully I'll get it right. ;)
>>> be of any consequence to this community, except to show that this
>>> inconsistency does indeed result in wasted effort and frustration.
>> Feel free to post your patches.
>>
>>> Of course, I'll help out if I can, e.g. by testing on the platforms
>>> that I have available.
> That would be very useful. Currently I do not have any CAN hardware a=
t
> hand.
One last thing: The canutils project assumes that the flexcan way of=20
error-state reporting is correct, but that might break if we apply thes=
e=20
changes, so I guess that we'll have to change that too.

Andri.
