From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: use be32_to_cpup to handle the value of dt entry
Date: Wed, 27 Jun 2012 19:26:07 +0800
Message-ID: <CAAQ0ZWT3ovG7eKZZuoSZkx4FGd+W9XvnTk8R1yuD02u4wqGNHQ@mail.gmail.com>
References: <1340789236-28266-1-git-send-email-mkl@pengutronix.de>
	<1340789236-28266-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44261 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab2F0L0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 07:26:09 -0400
Received: by lbbgm6 with SMTP id gm6so1493124lbb.19
        for <linux-can@vger.kernel.org>; Wed, 27 Jun 2012 04:26:08 -0700 (PDT)
In-Reply-To: <1340789236-28266-2-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-can@vger.kernel.org, Hui Wang <jason77.wang@gmail.com>

On 27 June 2012 17:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> From: Hui Wang <jason77.wang@gmail.com>
>
> The freescale arm i.MX series platform can support this driver, and
> usually the arm cpu works in the little endian mode by default, while
> device tree entry value is stored in big endian format, we should use
> be32_to_cpup() to handle them, after modification, it can work well
> both on the le cpu and be cpu.
>
I'm wondering if you want to just use of_property_read_u32() to make
it a little bit easier.

Regards,
Shawn

> Cc: stable <stable@vger.kernel.org> # v3.2+
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> =A0drivers/net/can/flexcan.c | =A0 =A04 ++--
> =A01 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 38c0690..81d4741 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -939,12 +939,12 @@ static int __devinit flexcan_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(pinctrl);
>
> =A0 =A0 =A0 =A0if (pdev->dev.of_node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *clock_freq_p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const __be32 *clock_freq_p;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock_freq_p =3D of_get_property(pdev-=
>dev.of_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"clock-frequency", NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clock_freq_p)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_freq =3D *clock_f=
req_p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_freq =3D be32_to_=
cpup(clock_freq_p);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!clock_freq) {
> --
> 1.7.10
>
