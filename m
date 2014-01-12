From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add explicit copyrights to can userspace header
Date: Sun, 12 Jan 2014 20:27:01 +0100
Message-ID: <52D2EC85.8030508@hartkopp.net>
References: <52D269D1.9030009@hartkopp.net> <1389553340-5758-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:64718 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaALT1G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 14:27:06 -0500
In-Reply-To: <1389553340-5758-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Urs Thuermann <urs.thuermann@volkswagen.de>, Marc Kleine-Budde <mkl@pengutronix.de>



On 12.01.2014 20:02, Uwe Kleine-K=C3=B6nig wrote:
> This is in the spirit of commit 2485602f1af2 (can: add explicit
> copyrights to can headers). It seems I have missed can.h back then.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> On Sun, Jan 12, 2014 at 11:09:21AM +0100, Oliver Hartkopp wrote:
>> Btw.
>>
>> - include/socketcan/can.h
>> - include/socketcan/can/isotp.h
>>
>> are both missing in this process.
>>
>> Unfortunately we missed linux/include/uapi/linux/can.h in commit 248=
5602f1af2
>> (can: add explicit copyrights to can headers).
>>
>> Would you like to pick this update of your original commit too?
> yeah, here it comes.
>=20
> isotp.h isn't a kernel header, so it needs only an update in can-util=
s
> alone.

Correct.

Tnx Uwe!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

>=20
> Best regards
> Uwe
>=20
>  include/uapi/linux/can.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index e52958d7c2d1..5d9d1d140718 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -8,6 +8,38 @@
>   * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + *    notice, this list of conditions and the following disclaimer i=
n the
> + *    documentation and/or other materials provided with the distrib=
ution.
> + * 3. Neither the name of Volkswagen nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this s=
oftware
> + *    without specific prior written permission.
> + *
> + * Alternatively, provided that this notice is retained in full, thi=
s
> + * software may be distributed under the terms of the GNU General
> + * Public License ("GPL") version 2, in which case the provisions of=
 the
> + * GPL apply INSTEAD OF those given above.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by modules with a GPL compatible li=
cense.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
>   */
> =20
>  #ifndef CAN_H
>=20
