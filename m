From: Andri Yngvason <andri.yngvason@marel.com>
Subject: RE: AW: AW: flexcan missing error state transitions
Date: Fri, 25 Aug 2017 17:16:49 +0000
Message-ID: <150368140986.1980.16506501029365689153@maxwell>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <6a410757a698403c91dcf254a1be3cd9@SI-MBX1030.de.bosch.com>
 <102e6fbef130471992b7e1a8feaa9465@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:28813
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755291AbdHYRQ6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Aug 2017 13:16:58 -0400
In-Reply-To: <102e6fbef130471992b7e1a8feaa9465@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hi Yi

I've only had time to review patch 3.

Quoting ZHU Yi (ST-FIR/ENG1-Zhu) (2017-08-24 09:40:38)
> Patch 3 (0001-can-flexcan-compensate-state-interrupt-on-demand.patch)
> This patch adds a timer to poll the state to compensate the incomplete
> state interrupt. The purpose is to avoid polling the state as much as
> possible and still notify upon any state transition via the SocketCAN
> error frame. It depends on auto-retransmission being enabled. But to
> our understanding that is always the case - there is no code to disable
> it. The user can configure the polling interval via DT based on the
> bitrate used (reasonable lower boundary) or acceptable notification
> latency in the application (upper boundary). The polling can be
> disabled, too. Please note that the polling interval *must not* be
> faster than <maximum transmission time for a frame> * 16, or else the
> error counter will not reach 128 and thus the error state might not
> change within the polling interval. So too fast is not good here.

That sounds rather shaky. Wouldn't it be more robust to have the timer be
periodic? Besides, over-sampling is preferable in order to avoid missed
transitions, right? See diff below.

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
...
> +static void flexcan_update_state_timeout(unsigned long data)
> +{
> +	struct net_device *dev =3D (struct net_device*)data;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_esr;
> +
> +	/* update state atomically */
> +	disable_irq(dev->irq);
> +	reg_esr =3D flexcan_read(&regs->esr);
> +	flexcan_irq_state(dev, reg_esr);
You could restart the timer here if the error state is not error-active. Th=
en
you would not have the problem of having to choose an interval so carefully.
> +	enable_irq(dev->irq);
> +}
...

Best regards,
Andri
