From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH V2 2/5] net: can: flexcan: disable error interrupts in
 non ERR-Active state
Date: Mon, 28 Jul 2014 12:10:49 +0530
Message-ID: <53D5F071.9030407@gmail.com>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de> <1406529268-20126-2-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50115 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbaG1GmJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:42:09 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so9108294pdb.24
        for <linux-can@vger.kernel.org>; Sun, 27 Jul 2014 23:42:09 -0700 (PDT)
In-Reply-To: <1406529268-20126-2-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

On 07/28/2014 12:04 PM, Matthias Klein wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> On imx53 I receive continuously STF_ERR error interrupts after sendin=
g a
> CAN frame on an open BUS.
> This patch disables error interrupts once we leave the ERR-Active sta=
te
> since I doubt further error interrupts are of any interest especially=
 if
> they render the system unresponsible.
> According to the manual in this case the system remains in passive st=
ate
> and RX-err counter is >127 and won't increment any further and so it
> won't enter BUS-Off state. Once the system receives a CAN message, th=
e
> RX-error counter should by set to 119 =E2=80=A6 127 which brings the =
CAN module
> back to ERR-active state which then should activate error reporting
> again.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
> ---
>   drivers/net/can/flexcan.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f677b49..2b98da2 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -628,7 +628,17 @@ static int flexcan_poll(struct napi_struct *napi=
, int quota)
>   		napi_complete(napi);
>   		/* enable IRQs */
>   		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> -		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> +		/*
> +		 * On an open CAN-bus the iMX51 keeps reporting the STF_ERR
> +		 * event after an attempt to send a CAN message. This will
> +		 * disable further error reports (or that one that keeps
> +		 * nagging) once we leave the ERR-Active state.
> +		 */

networking comment style...?


--=20
Regards,
Varka Bhadram.

