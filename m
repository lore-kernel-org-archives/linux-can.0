From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v7 07/10] include: can.h: remove unused include of version.h
Date: Tue, 21 Jan 2014 15:33:18 +0100
Message-ID: <52DE852E.7080702@hartkopp.net>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de> <1390309204-19854-8-git-send-email-mkl@pengutronix.de> <20140121132205.GC26766@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:27339 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbaAUOdU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 09:33:20 -0500
In-Reply-To: <20140121132205.GC26766@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



On 21.01.2014 14:22, Uwe Kleine-K=F6nig wrote:
> On Tue, Jan 21, 2014 at 02:00:01PM +0100, Marc Kleine-Budde wrote:
>> This patch remove the include of version.h, as it's not used.
>>
> Maybe point out that this #include is also missing in the kernel and =
so
> this drops another difference that need to be cared for when syncing =
the
> kernel headers into can-utils.

The version stuff was only needed for some kernel internal code in can-=
modules.

=46or can-utils we always have a proper userspace API where the latest =
and
greatest is the best to get.

So just dropping off that line is fine.

Regards,
Oliver

>=20
> Uwe
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  include/linux/can.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/can.h b/include/linux/can.h
>> index 2f77ab3..5802cb3 100644
>> --- a/include/linux/can.h
>> +++ b/include/linux/can.h
>> @@ -13,7 +13,6 @@
>>  #ifndef CAN_H
>>  #define CAN_H
>> =20
>> -#include <linux/version.h>
>>  #include <linux/types.h>
>>  #include <linux/socket.h>
>> =20
>> --=20
>> 1.8.5.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
