Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37213B27FA
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407391; cv=none; b=dxwmqR1pPQ3kpCwciVUP7IZslRWtqoaAU/OrvJ1nOj9UzkOLcFNceVzhF1QQS1rCOn9EKzS0CPhu5dsBR2oG/sNf+SUvjoRuFV+63WmXNBHzegnrvsgL57jjjMJB/OBmvxXKc75PyA9NDzzDlg2efU9P6O5SGQY06YTGC2H4tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407391; c=relaxed/simple;
	bh=0BeYS7Qe7F20yKEvmrcfSOmRm0vxd6mfRRHqGSkToX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKLPDi0nj0BKYXugi7QbdHpHZYfgmzLkxFpaa0hPoxSo3dUqsMTk0kpwpSMJ3hZQ06gzxj1pNyFaubePw0Q/aLKjtIJFaXuTcu7BvLUf+jaPW1tA8qG+2BYW0qvxNyHLtBHrYnoIRy1F8FXeDhQzDhJ5EtrPuv+IREwktijzbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oam7dsCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oam7dsCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D741F00A3E;
	Thu, 30 Jul 2026 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407389;
	bh=/PuNDxdGLeWcyi0ET2W00Hit3NgJnnXJf17aw/vMrGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oam7dsCCPmSZu2nxKxQk0KsvG90JsW5xz/61TgdbgUWspzfP4xriE7NGvgMuNl0Xw
	 Mt03tiyA60r7gY0qml1d5cGDE9Edr3yLM26FS1BAa/HVlYky3yw6wv+46i1lSnNe0f
	 LP+eVexmiTNrOrQO5zW/3iMCa7LBhvUV8T8nqtuJ1E+aYqxVtpAuiKY0Bo0HM/8gqq
	 GtGZ1ok6MUHDy4wBIaeIPz7PHh2r1oO7EjXq6xUdQYNXhr4jJMFGnMz7TSM81mjG9Y
	 oMrO1o3WYHM5+gc0OmvQq1mOpgbpyxQ0ZJzBthC7O6sGL/H+Ur2yPdl9YBAngTmCAI
	 kdwkIBoMGsjjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 06/20] can: ctucanfd: mark error-active controller
 status valid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260729102802.505168-7-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:48 +0000
Message-Id: <20260730102949.50D741F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `REG_INT_STAT_BEI` (Bus Error) interrupt is enabled when `CAN_=
CTRLMODE_BERR_REPORTING` is requested, but it is never checked or cleared i=
n the main `ctucan_interrupt()` ISR loop, resulting in an unhandled interru=
pt storm and device shutdown.
--

--- Patch [6]: [PATCH net 06/20] can: ctucanfd: mark error-active controlle=
r status valid ---
commit 528d2823639b052dd9d6f154ca1675ba5d2b7470
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: mark error-active controller status valid

This commit modifies the error handling path for CAN_STATE_ERROR_ACTIVE
to correctly set the CAN_ERR_CRTL flag in the CAN ID. This ensures
consumers know the controller-status information in cf->data[1] is valid.

Link: https://patch.msgid.link/20260723155543.318414-1-thnkslprpt@gmail.com

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 0ea1ff28dfce8..8f8b1c097ec6d 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -869,7 +869,7 @@ static void ctucan_err_interrupt(struct net_device *n=
dev, u32 isr)
>  			break;
>  		case CAN_STATE_ERROR_ACTIVE:
>  			if (skb) {
> -				cf->can_id |=3D CAN_ERR_CNT;
> +				cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>  				cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
>  				cf->data[6] =3D bec.txerr;
>  				cf->data[7] =3D bec.rxerr;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this error
handling code I noticed a potential interrupt storm in ctucan_interrupt().

When the interface is configured with CAN_CTRLMODE_BERR_REPORTING, a CAN bus
error will set the REG_INT_STAT_BEI bit. Since any external device on the C=
AN
bus can intentionally or accidentally cause a bus error, this condition is
reachable from the bus.

However, ctucan_interrupt() does not include BEI in the filter condition or
the clear mask:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_interrupt() {
		/* Error interrupts */
		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
			icr =3D isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI);

			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);
			ctucan_err_interrupt(ndev, isr);
		}
}

Since BEI is never cleared from the status register, will this cause the ISR
to loop until it detects a stuck interrupt and permanently disables all dev=
ice
interrupts, leading to a denial of service?

Should REG_INT_STAT_BEI be included in both the condition and the icr mask
to ensure the interrupt is properly cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D6
