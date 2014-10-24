From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 17:40:19 +0000
Message-ID: <544A8F03.8040906@marel.com>
References: <544A2943.1080808@marel.com> <544A64A1.3050104@marel.com>
 <544A78A8.40909@marel.com> <4764001.1dH8LXDQX4@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0064.outbound.protection.outlook.com ([157.56.111.64]:46144
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756794AbaJXRkZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Oct 2014 13:40:25 -0400
In-Reply-To: <4764001.1dH8LXDQX4@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>, linux-can@vger.kernel.org


On f=C3=B6s 24.okt 2014 16:36, Steffen Rose wrote:
> Hello,
>
> Am Freitag, 24. Oktober 2014, 16:04:56 schrieben Sie:
>>> We can do little if the CAN controller does not notify the Software
>>>> via interrupt.
>>> Yes, that's why I wanted to figure out if it's a controller problem=
 or
>>> not.
>>> Turns out it's a controller problem, but perhaps we can work around=
 it?
>>> E.g. if we check esr for state changes every time someone transmits=
 a
>>> frame, both of these problems would go away. Would it be unacceptab=
le
>>> overhead to do so?
>> I've just confirmed that this "fix" works, but only if berr-reportin=
g is
>> enabled.
> Is this workaround working in case of an open CAN Bus?
> (Ack error situation)
Yes
> The flexcan can generate an error interrupt after every CAN bus error=
=2E But in=20
> case of an error situation the interrupt load would be very high (e.g=
=2E short=20
> circuit of the CAN).
>
That's what berr-reporting does, right? Considering that when the bus i=
s
flooded with errors, things are in a pretty bad shape anyway, I think i=
t's
not really going to contribute much to the over-all mess to just leave =
the
error interrupts on all the time. It's far worse if the user doesn't ge=
t
the correct error state.

Anyway, defensive measures can be taken. When the bus has reached
error-passive, the driver is not going to need those interrupts any mor=
e
so it could turn off the interrupts until the bus goes to bus-off or ba=
ck
down to warning or active; except when berr-reporting is enabled.

--
Andri
