From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN FD USB interfaces
Date: Mon, 26 Jan 2015 22:20:54 +0100
Message-ID: <54C6AFB6.8040605@hartkopp.net>
References: <2030058.NqX30u0ogQ@heinz> <54C6398A.5030203@pengutronix.de> <2585308.I1hAfmYoxa@heinz> <54C66E6A.8060501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:54304 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbAZVVG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 16:21:06 -0500
In-Reply-To: <54C66E6A.8060501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?SGVpbnotSsO8cmdlbiBP?= =?UTF-8?B?ZXJ0ZWw=?= <oe@emtas.de>
Cc: linux-can@vger.kernel.org

Yes.

Since 3.15 the CAN driver infrastructure is CAN FD capable (e.g. 2nd bi=
trate).
See CAN-CiA Newsletter :-)

The NON-ISO announcement will hopefully go into 3.18 stable, as the M_C=
AN=20
driver emerged there.

Regards,
Oliver

On 26.01.2015 17:42, Marc Kleine-Budde wrote:
> On 01/26/2015 04:57 PM, Heinz-J=C3=BCrgen Oertel wrote:
>> Am Montag, 26. Januar 2015, 13:56:42 schrieb Marc Kleine-Budde:
>>> Peak support has just been added, it will probably hit mainline in =
v3.20.
>>
>>
>> I think it could be possible to compile it for older kernel, like 3.=
16.
>> What do you think?
>
> Probably.
>
> Marc
>
