Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52454FECD5
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536577; cv=none; b=bps1SIUbf6BBHQpBnF0wIfJT4K9mOoRC4sM/WHH98Wew4zE6IvvV2ZWsDZBhPSILjPzsIojGNnGctIfUT5Fw+ml2DadWL6YjM0NerLptnqxQe25+ENS2vtikuENDbgdO5SWWN/a+N/6I+y0uLt+rG+6STEKyYE0QUd9wHfkwLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536577; c=relaxed/simple;
	bh=sRNZEF4e3R5JUpQphGrO/tNSaFFnPUbNIoB9ZukkOkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9QMFsfsCzkCrkl4ywcvgLMCAFjF+4m9hyTU4MDy/2EjJZqUWsPbZAYoM5y8hOQXFpVA/KokzmileD7RHkpLSNlu6L4Yajl2DIAhBBMGg1KpEFYLms91kucsTMlBv+/OflcWsHRM7ut8WKdqUGFDgWrHw/zxYNZk2SAv0QdCux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK2SuEZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK2SuEZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DF71F00A3D;
	Fri,  4 Sep 2026 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536558;
	bh=O5AUq4mGDUOFtlQ4Rte8JLZsCKJT7V7kitVuod1MTao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK2SuEZIRbALCyG9P5Vx+qpQl3xIVL0bsUhZ8WbA1uD+DtcCHoJVlPetS5N0FJU+j
	 Fb3omyZC7qnpraARz2zWLXBRuhSnmGxDzu4BkDmUjvDewfArRsBSH/ToE8gjpSvtVR
	 vebQ87GrCfUc9TY7y/4P8ZRNEmNrwiCufaFzriSEXpdSJx0BsEJrlzE3bOljZWBTgj
	 +qYoCjgCa8fUvZF+ZVKafmFzQiI2ErcklgavAxB42oq6uC6z0oWj+Y52/gRhndo+Ht
	 TwPAjXeE7mrchLuj1NA8moyjD6jiT1V1jVXPiA562m32N+aHhyX0xLqX0ejlR68XXO
	 6M3qA8Z+rc8Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: netlink: fix static FD-NON-ISO mode validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Ling" <zhuling0805@qq.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <tencent_B5154AEA68C02E81646C47664F2DCCB5AD0A@qq.com>
References: <tencent_B5154AEA68C02E81646C47664F2DCCB5AD0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:42:37 +0000
Message-Id: <20260904154238.32DF71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Restoring the old `ctrlstatic_missing` evaluation order re-introdu=
ces a loophole that allows userspace to permanently wipe the static `CAN_CT=
RLMODE_FD_NON_ISO` capability from the device.
--

commit 7102507a8297914d9bb707e83f030bfd7f882782
Author: Zhu Ling <zhuling0805@qq.com>

can: netlink: fix static FD-NON-ISO mode validation

This commit adjusts the calculation of ctrlstatic_missing in
can_ctrlmode_changelink(). It evaluates the variable after removing
CAN_CTRLMODE_FD_NON_ISO from the static control modes when CAN FD is
disabled, which restores the behavior from before the offending commit.

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..26983f1b40779 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -321,7 +321,6 @@ static int can_ctrlmode_changelink(struct net_device =
*dev,
>  	maskedflags =3D cm->flags & cm->mask;
>  	deactivated =3D ~cm->flags & cm->mask;
>  	notsupp =3D maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
> -	ctrlstatic_missing =3D (maskedflags & ctrlstatic) ^ ctrlstatic;
> =20
>  	if (notsupp) {
>  		NL_SET_ERR_MSG_FMT(extack,
> @@ -334,6 +333,7 @@ static int can_ctrlmode_changelink(struct net_device =
*dev,
>  	if (!(maskedflags & CAN_CTRLMODE_FD))
>  		ctrlstatic &=3D ~CAN_CTRLMODE_FD_NON_ISO;
> =20
> +	ctrlstatic_missing =3D (maskedflags & ctrlstatic) ^ ctrlstatic;
>  	if (ctrlstatic_missing) {

[Severity: High]
This isn't a bug introduced by this patch, but restoring the old evaluation
order here re-introduces a loophole that allows userspace to permanently wi=
pe
the static CAN_CTRLMODE_FD_NON_ISO capability from the device.

If a user with CAP_NET_ADMIN in the network namespace sends a Netlink messa=
ge
to modify IFLA_CAN_CTRLMODE with cm->mask =3D CAN_CTRLMODE_FD |
CAN_CTRLMODE_FD_NON_ISO and cm->flags =3D 0:

- !(maskedflags & CAN_CTRLMODE_FD) evaluates to true.
- ctrlstatic is then masked to clear CAN_CTRLMODE_FD_NON_ISO.
- The new ctrlstatic_missing check evaluates to 0 ^ 0 =3D 0, which bypasses
  the protection.
- Later in can_ctrlmode_changelink(), priv->ctrlmode &=3D ~cm->mask permane=
ntly
  clears CAN_CTRLMODE_FD_NON_ISO from the device's internal state.

When CAN_CTRLMODE_FD is subsequently re-enabled, the controller will be
configured in ISO mode despite physically requiring NON-ISO mode statically.
Could this lead to CAN bus misconfiguration and traffic failure?

>  		NL_SET_ERR_MSG_FMT(extack,
>  				   "missing required %s static control mode",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_B5154AEA68C=
02E81646C47664F2DCCB5AD0A@qq.com?part=3D1
