From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH V2 5/5] net: can: flexcan: fix for wrong TX error count
 behaviour on i.MX53
Date: Mon, 28 Jul 2014 12:09:17 +0530
Message-ID: <53D5F015.30703@gmail.com>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de> <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:62989 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaG1Gkh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:40:37 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so9218379pdj.8
        for <linux-can@vger.kernel.org>; Sun, 27 Jul 2014 23:40:36 -0700 (PDT)
In-Reply-To: <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

On 07/28/2014 12:04 PM, Matthias Klein wrote:
> Once the CAN-bus is open and a packet is sent, the controller switche=
s
> into the PASSIVE state and the TX error count goes to 0x80. When the
> bus is closed and the packet gets acknowledged the controller switche=
s
> to ERROR-WARNING state and the TX error counter is decremented to 0x7=
f.
> Everything OK so far.
>
> When now the bus is open again and a packet is sent, the controller
> switches into PASSIVE state and sets the TX error count to 0x86.
> When now the bus is closed the TX error is decremented to 0x85, but
> the state does not change to ERROR-WARNING. Now with each successfull=
y
> transfered packet (in PASSIVE state!) the TX error counter is
> decremented, and when the TX error counter reaches 0x7f the controlle=
r
> switched back into ERROR-WARNING state.
>
> This fix sets the TX error count back to zero when entering the
> ERROR-WARNING state (after the first retransfered packet is acknowled=
ged).
>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
> ---
>   drivers/net/can/flexcan.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index b77f1da..f9fefcb 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -479,6 +479,34 @@ static int flexcan_poll_bus_err(struct net_devic=
e *dev, u32 reg_esr)
>   	return 1;
>   }
>  =20
> +static void flexcan_reset_err_reg(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +
> +	/*
> +	 * The reset of the error counter is ugly but I don't see any other=
 way.
> +	 * Open the CAN bus, send packet =3D> HW goes to ERR-pasive, TX-err
> +	 * counter is around 128 (maybe 129). Close the CAN-Bus, the TX-err
> +	 * counter drops down to somewhere between 126 =E2=80=A6 127, HW go=
es to
> +	 * ERR-Warning, everything is fine.
> +	 *
> +	 * Now: Repeat the above procedure. What happens is that on send th=
e
> +	 * TX-err increases to around 134=E2=80=A6136 and on connect it dro=
ps to
> +	 * around 130. Occording to ESR the HW is still in passive mode _bu=
t_ it
> +	 * is possible send packets - that means can send packets but has n=
o
> +	 * clue about it.
> +	 * To get a consistent behavior here, the error counter are reset s=
o we
> +	 * fall back to Err-Active mode and the second "can send on open bu=
s"
> +	 * behaves just like the first one.
> +	 */
> +

networking comment style...?

/* bla bla
  * bla
  */


--=20
Regards,
Varka Bhadram.

