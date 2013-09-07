From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] uapi/linux/can: add explicit copyrights to can's  netlink header
Date: Sat, 07 Sep 2013 21:57:20 +0200
Message-ID: <8bd2765c8cea602fccac395d45e6f3b3@grandegger.com>
References: <1b45fb94c09a6ee453fd1606cc21e111@grandegger.com>
 <1378582478-9484-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:38749 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812Ab3IGT5V (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 7 Sep 2013 15:57:21 -0400
In-Reply-To: <1378582478-9484-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On Sat,  7 Sep 2013 21:34:38 +0200, Uwe Kleine-K=C3=B6nig=0D
<u.kleine-koenig@pengutronix.de> wrote:=0D
> This file is copied to the source code of user space applications (in=
=0D
> this case can-utils) and so it makes sense to mention explicitly thei=
r=0D
> copyright.=0D
> =0D
> Cc: Wolfgang Grandegger <wg@grandegger.com>=0D
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
=0D
> ---=0D
> Hello,=0D
> =0D
> compared to the previous post the headers covered by VM copyright wer=
e=0D
> dropped as Marc already fixed them and the GPL exception was skipped =
as=0D
> this is what Wolfgang seems to prefer.=0D
> =0D
> Best regards=0D
> Uwe=0D
> =0D
>  include/uapi/linux/can/netlink.h | 8 ++++++++=0D
>  1 file changed, 8 insertions(+)=0D
> =0D
> diff --git a/include/uapi/linux/can/netlink.h=0D
> b/include/uapi/linux/can/netlink.h=0D
> index 14966dd..df944ed 100644=0D
> --- a/include/uapi/linux/can/netlink.h=0D
> +++ b/include/uapi/linux/can/netlink.h=0D
> @@ -5,6 +5,14 @@=0D
>   *=0D
>   * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>=0D
>   *=0D
> + * This program is free software; you can redistribute it and/or mod=
ify=0D
> + * it under the terms of the version 2 of the GNU General Public=0D
License=0D
> + * as published by the Free Software Foundation=0D
> + *=0D
> + * This program is distributed in the hope that it will be useful,=0D
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of=0D
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the=0D
> + * GNU General Public License for more details.=0D
>   */=0D
>  =0D
>  #ifndef CAN_NETLINK_H=0D
=0D
Acked-by: Wolfgang Grandegger <wg@grandegger.com>=0D
=0D
Thanks.=0D
=0D
Wolfgang.
