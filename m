From: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: Framework for hardware filter support?
Date: Wed, 14 Feb 2018 16:40:19 -0600
Message-ID: <55e3a0ef-82ea-b62d-34f7-ca7518b9d534@pobox.com>
References: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
 <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
 <6c112388-5dcb-2dca-06c6-eac56d470fbb@pobox.com>
 <20180213194203.GA15640@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54095 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWkL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 17:40:11 -0500
In-Reply-To: <20180213194203.GA15640@airbook.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

Thanks for your response, Kurt.


On 02/13/2018 01:42 PM, Kurt Van Dijck wrote:
> On zo, 11 feb 2018 16:33:43 -0600, Daniel Santos wrote:
>>> where the CAN_RAW filter design would easily fit.
>> This is what I mean by a framework.=C2=A0 So the driver should inform =
the
>> core CAN driver what it's filtering capabilities are -- again, I would
>> have to study a number of devices to design this sanely.=C2=A0 It woul=
d seem
>> that iproute2 would be the best userland mechanism to specify them, an=
d
>> it could pass an array of struct can_filter objects.=C2=A0 Then based =
upon
>> the hardware, it can apply or reject them.=C2=A0 It would also be nice=
 for
>> iproute2 to query the driver and be able to report those capabilities.
> I remember this discussion has passed a few times already.
> The end result has always been to:
> 1. give the kernel/driver a list of id/masks.
> 2. The driver does no aggregation, the root operator should know
>    what to do.

I don't understand what driver aggregation means.=C2=A0 But yes, this mak=
es
good sense.

> Maybe some day this will become limited for hardware that can do specia=
l
> tricks, like having a random list of identifiers.
> This can most probable be addressed in some clever way that is specific
> for the driver (like adding a list of id/masks where mask is always
> 0x7ff for a random canid list).
> Due to the driver doing smart things, the driver may not be capable of
> informing filtering capabilities in a static way. I would start without
> it.
>
> The support of hardware filters is hardware specific anyway, and
> intersects the multi-user principle. The only justification is ....
> that the root operator knows the hardware and the application.

Yes, perfect!

> What matters for a generic implementation is that the API is simple,
> clear and usable. That is where the id/mask list pops in.
> Operators that don't understand the id/mask list will probably fail
> anyway to use hardware filters on CAN. No framework can prevent that.
>
> Kurt
>

Yes, this makes great sense. And the driver (I presume) can always
reject the filter configuration if it can't do what is asked.=C2=A0 In th=
e
case of the MCP2210, however, there is one small hole; it has a bit that
decides rather or not to rollover messages from it's first rx buffer to
it's second (and it only has two).=C2=A0 I'm wondering about some free-fo=
rm,
driver specific configuration string to handle any loose ends of the
device?=C2=A0 Too ugly?

Then again, it supports 6 filters.=C2=A0 Perhaps a 7th filter could be pa=
ssed
to specify the rollover configuration.=C2=A0 Uglier still? :)

And actually, the device has bits to en/disable filtering for each rx
buffer that can be changed (along with the rollover) while the link is
up.=C2=A0 I'm probably *really* reaching here.=C2=A0 I can't think of man=
y reasons
to have to change this while the link is up and rather or not they are
enabled can be implied by the filter/mask array.

Thanks,
Daniel

