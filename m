Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101F3750CF;
	Thu, 30 Jul 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422767; cv=none; b=JUA9q8sAJUmFyhbFBGIIn4ZU7yumdHp+6WCJWfzxjy1ePEx4pEDjnIqY/6CBdZ+n7F8+sWuJ59nyIpANycioBTvQaEtNT04znivfthftRFkBwAULoCIj/5n75WIbyK+mc4FbCDIaS12T29/1Qh1NC5h3NkOBLCtpJSu96Ai2yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422767; c=relaxed/simple;
	bh=cyO4k1UBkIgwI0/RC7RFnxuCHLFkt4asQTwVlKrIiT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMW3boWckqfRiyHVf6PSpO4dTUGg+OQyCiHv2S/O1FBZvNXjatr2k0vhSBeIcgPNA6XAPREG6AIm8FIB5E+orUinwWOhhsDaqgg1FnDmHVMTYu1SYqP8WrmdL7kv3cKy5rVXu55mKAx01Pt5IxH3fmqjIZv3Ltx48saEEcBsrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ5vSK0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ5vSK0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E41F000E9;
	Thu, 30 Jul 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422766;
	bh=lMQfa+l4JWKa1zXCGmv8pzcu5cAGN8/KzhDC1914/7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZ5vSK0cfLp31D9ORtYy5q6kPM1vSHCA5mtLcU1n1p8+hXX3psU70Z+8w7mPjTHHs
	 6H1btTDSV21Bhb6nlLoixzoldg6/rjrFrnpMeaiXP4aHW9EXqm91Q54Bn6EYvV041r
	 P89YtWC3SWdBMLUb03npDtcdzN86SMJnd0WdaF8nNomxd/ioZi3CDoRDzu++j2y+Yh
	 WnnqydWSONVT6c2ZAJVxiByvRxCV03buomEgaO8yNhZ5mSX/xrNIOCqdvblTqWkFJG
	 LJqZn7H9BVTmR43tYm2oYiLPwA1sjxoPn4HavrQoPWwCLhEq+9UzHPE+WYM7q+mdCT
	 8Wm6EVaySvoSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
References: <20260730-master-v6-0-dfb63e234775@qq.com>
 <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:46:05 +0000
Message-Id: <20260730144605.A68E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The rockchip_canfd driver unconditionally enables CAN-FD mode in t=
he hardware, even if the user only requests Classic CAN mode. However, the =
data bit timing registers are only initialized if the user explicitly reque=
sts CAN-FD. This leaves the hardware configured to process CAN-FD frames bu=
t with uninitialized data bit timing, causing it to lose synchronization an=
d transmit error frames, which disrupts valid CAN-FD traffic on the bus.
--

--- Patch [2]: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support ---
commit c9bd120b397e60634c9f6a44ebe7ae2f872b4274
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip: add RK3588 CAN support

Add support for the RK3588 CAN controller by introducing a dedicated
model ID and OF match entry. Enable existing erratum 5 and 6 workarounds
and enable CAN-FD for RK3588.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 29de0c01e4edc..37c1c22c40c9f 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
[ ... ]
> @@ -148,6 +156,12 @@ static int rkcanfd_set_bittiming(struct rkcanfd_priv=
 *priv)
> =20
>  	rkcanfd_write(priv, RKCANFD_REG_FD_DATA_BITTIMING, reg_dbt);
> =20
> +	/* RK3588 CAN-FD BRS works with TDC disabled. */
> +	if (priv->devtype_data.model =3D=3D RKCANFD_MODEL_RK3588) {
> +		rkcanfd_write(priv, RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION, 0);
> +		return 0;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but it appears there is a
pre-existing issue with how CAN-FD is enabled that affects both RK3568 and
the newly added RK3588 controllers.

In drivers/net/can/rockchip/rockchip_canfd-core.c:rkcanfd_chip_start(), the
hardware is unconditionally configured to enable CAN-FD mode by setting
RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE.

However, in rkcanfd_set_bittiming() (just above the changes in this hunk),
if the user configures the interface in Classic CAN mode, the initialization
of data bit timing registers is skipped:

	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
		return 0;

Does this leave the hardware configured to process CAN-FD frames but with
uninitialized data bit timing?

If a valid CAN-FD frame with BRS is sent by another node on the bus, could
this controller attempt to switch to the uninitialized data bit timing, fai=
l,
and actively transmit an error frame, disrupting valid CAN-FD traffic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v6-=
0-dfb63e234775@qq.com?part=3D2
