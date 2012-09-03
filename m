From: =?ISO-8859-1?Q?Beno=EEt?= <benoit@pouic.eu>
Subject: Re: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Mon, 03 Sep 2012 19:13:51 +0200
Message-ID: <5044E54F.7020507@pouic.eu>
References: <1346674649-10181-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pouic.eu ([109.190.18.85]:65058 "EHLO smtp.pouic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273Ab2ICROC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Sep 2012 13:14:02 -0400
In-Reply-To: <1346674649-10181-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hello Marc,

=46irst, thank you for your attention on this bug.

On 09/03/2012 02:17 PM, Marc Kleine-Budde wrote:

> From: Benoit <benoit@pouic.eu>
>
> The MCP2515 has a silicon bug causing repeated frame transmission, se=
e section
> 5 of MCP2515 Rev. B Silicon Errata Revision G (March 2007).
>
> Basically, setting TXBnCTRL.TXREQ in either SPI mode (00 or 11) will =
eventually
> cause the bug. The workaround proposed by Microchip is to use mode 00=
 and send
> an RTS command on the SPI bus to initiate the transmission.
>
> TODO: get S-o-b from Benoit <benoit@pouic.eu>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Benoit,
>
> can you please test this patch, if it still fixes your problem. In or=
der to
> integrate this patch into the kernel, I need you Signed-off-by [1] wi=
th you
> real name.

I just carefully ran some before/after tests with your updated patch an=
d I confirm the problem is still fixed with it.

As for my "Signed-off-by", here it goes:

Signed-off-by: Beno=EEt Locher <Benoit.Locher@skf.com>

By the way, about using spi_write()instead of mcp251x_spi_trans(): I in=
nocently thought it would make less function call nesting,
trying to improve response time of the driver particularly on my Raspbe=
rry Pi.

Best Regards,

Beno=EEt.

>
> regards, Marc
>
> [1] http://lxr.free-electrons.com/source/Documentation/SubmittingPatc=
hes#L298
>
>   drivers/net/can/mcp251x.c |   11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index a580db2..26e7129 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c
> @@ -83,6 +83,11 @@
>   #define INSTRUCTION_LOAD_TXB(n)	(0x40 + 2 * (n))
>   #define INSTRUCTION_READ_RXB(n)	(((n) =3D=3D 0) ? 0x90 : 0x94)
>   #define INSTRUCTION_RESET	0xC0
> +#define RTS_TXB0		0x01
> +#define RTS_TXB1		0x02
> +#define RTS_TXB2		0x04
> +#define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
> +
>  =20
>   /* MPC251x registers */
>   #define CANSTAT	      0x0e
> @@ -397,6 +402,7 @@ static void mcp251x_hw_tx_frame(struct spi_device=
 *spi, u8 *buf,
>   static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame =
*frame,
>   			  int tx_buf_idx)
>   {
> +	struct mcp251x_priv *priv =3D dev_get_drvdata(&spi->dev);
>   	u32 sid, eid, exide, rtr;
>   	u8 buf[SPI_TRANSFER_BUF_LEN];
>  =20
> @@ -418,7 +424,10 @@ static void mcp251x_hw_tx(struct spi_device *spi=
, struct can_frame *frame,
>   	buf[TXBDLC_OFF] =3D (rtr << DLC_RTR_SHIFT) | frame->can_dlc;
>   	memcpy(buf + TXBDAT_OFF, frame->data, frame->can_dlc);
>   	mcp251x_hw_tx_frame(spi, buf, frame->can_dlc, tx_buf_idx);
> -	mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
> +
> +	/* use INSTRUCTION_RTS, to avoid "repeated frame problem" */
> +	priv->spi_tx_buf[0] =3D INSTRUCTION_RTS(1 << tx_buf_idx);
> +	mcp251x_spi_trans(priv->spi, 1);
>   }
>  =20
>   static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,


