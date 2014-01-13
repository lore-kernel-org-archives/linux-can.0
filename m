From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/2] slcand: reimplement daemonize routine
Date: Mon, 13 Jan 2014 19:00:16 +0100
Message-ID: <52D429B0.3080602@hartkopp.net>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com> <1389603245-24023-2-git-send-email-yegorslists@googlemail.com> <20140113095825.GD29475@pengutronix.de> <CAGm1_kuDApxXrm+3+CETQ7+KhA5f9cnGVjAMe_0PVU92UaZ0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:43754 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaAMSAR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 13:00:17 -0500
In-Reply-To: <CAGm1_kuDApxXrm+3+CETQ7+KhA5f9cnGVjAMe_0PVU92UaZ0sQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, =?UTF-8?B?VXdlIEtsZWluZS0=?= =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>



On 13.01.2014 11:02, Yegor Yefremov wrote:
> On Mon, Jan 13, 2014 at 10:58 AM, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> Hello Yegor,
>>
>> On Mon, Jan 13, 2014 at 09:54:05AM +0100, yegorslists@googlemail.com=
 wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> Replace daemonize() routine with daemone() system call, because of
>>> conflicting licenses. daemonize() routine was derived from under
>>> GNU Free Documentation License licensed code. This license is
>>> incompatible with GPL-2+.
>>>
>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> Thanks.
>>
>> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Just a note. I've tested the patches with our VScom USB-CAN device at
> 3Mbit/s. So
> far everything was working as expected: daemon started and I could
> send/receive frames.
>=20

Great!
That was really a cool cleanup: 6 insertions(+), 138 deletions(-)
And when it works it's even better :-)

Thanks!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

