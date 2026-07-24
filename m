Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415D3A9632
	for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879060; cv=none; b=lyXFXE/tRLw17mG+Xc8+/7vnn5HxcGSe7/Y4PMGkLe2jm9lRbQ8wbo90nGwO+7ctOcBcf1IjfmdPvmKvzCRfzqDU5MCYeH2jDuA1NwOBi7yuBDmevYKQMwGHvtkSGsP+q5Xp/cRgzhO8XM6pz1zM1F/sbatR3tjh8UtJt07BYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879060; c=relaxed/simple;
	bh=/SH5ShVJJ5e4LBQRjCLvcUa+/eCsrjUp859xEGXfkws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3u1anjzT3QDd8VNwbe9Eui3WcnqKKU1sxb9Lf3uUDEZHdRwG15mZVasR7Jt5AC75Amp81gOdDTt35V6axUecgj2Xm8gA4jLFjittQNnhR78xSL7CBPlnr2+VPwz9Oiu1ftyK8fVd7WBvhAizxuVLfSrxDrnL6DVy6X1DK/DU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo8vKZ0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo8vKZ0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B731F000E9;
	Fri, 24 Jul 2026 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879058;
	bh=xq5E8TWflb0Wu2ZovYrSplyAltN5y1B+zLyqV4HcDrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oo8vKZ0XuEDL7u97HP9FUq4ZkRIL0NxivoEvfALMoylSkhZFYg+RC6MSIaymI9ugh
	 WDIxY50nBUslaiV8O6xgBsmSEklmG/Pz1wvbNjWiRWO9nV1HpnE1SjfYeazsKI3AXP
	 LCUBZ+i9borTZmn0kGYjDV15orAm3rUCqRDLBBRGe4T/c2TZli3l5NJPfGKX6dHwGW
	 7+EcvWhUQoEhtRN/uaJdUVX//izjabUKzA4m05vwz/Qfg49gmiACY+Jss92MnTAJxG
	 hu84DSNSsRn7EKSANsEiRyv4O3OvtO64QnQ2JvtZ/PNvUI4J+viSfOL3msvd8jGvAD
	 GWnGq9xL+kqlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: ctucanfd: handle bus error interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260723074403.131575-1-thnkslprpt@gmail.com>
References: <20260723074403.131575-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 07:44:17 +0000
Message-Id: <20260724074418.48B731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Un-ratelimited `netdev_info()` on bus errors causes a printk flood.
--

--- Patch [1]: [PATCH net] can: ctucanfd: handle bus error interrupts ---
commit dcd94808a20ebfaa5db627f0ee1ba372c3c77c87
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: handle bus error interrupts

Include REG_INT_STAT_BEI in the top-level error interrupt condition.

BEI is enabled when CAN_CTRLMODE_BERR_REPORTING is requested and
ctucan_err_interrupt() already handles it. Without checking and
clearing BEI in the top-level handler, bus error interrupts are not
handled or acknowledged.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 0ea1ff28dfce8..0cd2d428c1f15 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -1136,8 +1136,12 @@ static irqreturn_t ctucan_interrupt(int irq, void =
*dev_id)
>  		/* Error interrupts */
>  		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
>  		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
> -		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
> -			icr =3D isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_A=
LI);
> +		    FIELD_GET(REG_INT_STAT_ALI, isr) ||
> +		    FIELD_GET(REG_INT_STAT_BEI, isr)) {
> +			icr =3D isr & (REG_INT_STAT_EWLI |
> +				     REG_INT_STAT_FCSI |
> +				     REG_INT_STAT_ALI |
> +				     REG_INT_STAT_BEI);
> =20
>  			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
>  			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);

[Severity: High]
This isn't a bug introduced by this patch, but since we are now passing
REG_INT_STAT_BEI into ctucan_err_interrupt() which is called directly after
this write, could this cause a printk flood?

Looking at ctucan_err_interrupt():

	/* Check for Bus Error interrupt */
	if (FIELD_GET(REG_INT_STAT_BEI, isr)) {
		netdev_info(ndev, "bus error\n");

This unconditional netdev_info() is called for every bus error interrupt,
whereas other errors like ALI correctly use a dologerr ratelimit check.

Would a flurry of bus errors overwhelm the system log?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723074403.1315=
75-1-thnkslprpt@gmail.com?part=3D1
