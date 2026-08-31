Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5033257845;
	Mon, 31 Aug 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202883; cv=none; b=Sx5nqUqXGujQGqn2uJXi6WiCfHKRJtbeJaoqeopJ6e3iDndcOhRmm32rTygBWUZYIS3b/textI7wUbKaBAcQn0rXw64Ij8mAB0aZqqd5VQ/NpUjMlkCKgtFvFeEX3uRGIR7T0QuN7Wq1o0mFDBQp+WTTJp9hP4EG10jRZfHcFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202883; c=relaxed/simple;
	bh=CmPmXkP0Ip2iHtYWuvtItjd9SF8ZpDuowY4wdSFUSQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7cuQPuD/LFp4or9eO5HGkBYaDxm+KQtrlsRiuDrpBZP3QfRzy91cTzPCdrh5kCGuGKL0VWK0Os6QL/LBjyhJW7fYsnHT++hmYJJVx9FhRVX7JZ/4WeMgkWtX0it5fGI7U4xlx5F5VcE0KgBjt3DxuPzc/UGnwgvKMO4VD6xbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze7I92pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze7I92pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D441F000E9;
	Mon, 31 Aug 2026 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202881;
	bh=o96m+FIcfRlGtxKDxqqqbjKUXxNmqXppM3fFUwG5Eyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ze7I92pMUmJ8y7VhgM3Vyowc2/B2MxKvHC4pxCDrLvQkV4Aiivzuq7I8zAAEjVNdu
	 1cir/VLQ5lMWWT244msTQOPmIspD8wFju1Wq/54juk9Ukfo/f1JXSNAa2WjC6LKKZu
	 hovaR4WHu+Vb1SjYqxzABVTzQ+XAb7Q7boKRPBwWXGK6YUEGfKRKb9IgAviaBmeima
	 VMIjCVXtmBfbqUrIHWpaelTYXyHLhBk1NbsxMMMWUl2W8KvZwchkIN/ar1V1NSfbR5
	 79d+L8RDEt/m3Efad1I9kScW+BgFW1ZIWSShtnDhlrpwS/giLkjbzpMpni5FUcHYQq
	 aUl0JTsGj0svA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] can: flexcan: add NXP S32N79 SoC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, Frank.Li@kernel.org, conor+dt@kernel.org, robh@kernel.org, imx@lists.linux.dev, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260831143449.12828-7-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-7-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:01:20 +0000
Message-Id: <20260831190120.B8D441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect interrupt line enabled for system wakeup in flexcan_susp=
end() on multi-IRQ platforms.
--

commit cee5e83ffcddcb89ac8051e51286d9d24014fc17
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: add NXP S32N79 SoC support

This commit adds device data and compatible strings for the NXP S32N79 SoC
to the flexcan driver.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 601d88bfcfeb2..0533cdf969b2c 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -403,6 +403,15 @@ static const struct flexcan_devtype_data nxp_s32g2_d=
evtype_data =3D {
>  		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>  };
> =20
> +static const struct flexcan_devtype_data nxp_s32n_devtype_data =3D {
> +	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS=
 |
> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
> +		FLEXCAN_QUIRK_IRQ_BERR,

[Severity: High]
This is a pre-existing issue, but adding FLEXCAN_QUIRK_IRQ_BERR for the new
S32N79 SoC exposes an existing problem with system wakeup.

On multi-IRQ platforms that use FLEXCAN_QUIRK_IRQ_BERR or
FLEXCAN_QUIRK_NR_IRQ_3, dev->irq is dedicated exclusively to mailbox events.
The FlexCAN Wake-Up Interrupt (FLEXCAN_ESR_WAK_INT) triggers a state change
event, which is routed to the dedicated state change interrupt line
(priv->irq_err or priv->irq_boff).

However, when the system goes to sleep with Wake-on-CAN enabled, does
flexcan_suspend() enable the wrong interrupt line for wakeup?

drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend() {
    ...
    if (device_may_wakeup(device)) {
        ...
        enable_irq_wake(dev->irq);
        ...
    }
    ...
}

Since enable_irq_wake() configures the irqchip to listen to the mailbox
interrupt instead of the state change interrupt, will the system fail to wa=
ke
up from suspend on CAN network activity?

The same incorrectly assigned wakeup interrupt is subsequently disabled in
flexcan_resume() by calling disable_irq_wake(dev->irq).

> +};
> +
>  static const struct can_bittiming_const flexcan_bittiming_const =3D {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D6
