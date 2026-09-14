Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3B381EBD;
	Mon, 14 Sep 2026 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365830; cv=none; b=K/HiC7uVzlM1YklMAlH1cDtPOjHnmGT/zlY8hlGNLaXrri5zmWcuTTqFEz5F43wJhVWAjF15epdng+Fem0rch2amei9wwRIZslSl+R1Tg34NJV7BOjS085VII87f3UAMXLig14d30AI5KDSgl8yqyT25OD9566JqZRXq+ib+BCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365830; c=relaxed/simple;
	bh=pkHOAQSafDO83LlzVedbiDpjC2kXE2iX8L7p1l0nx94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5eysLA/BzN4lmjsnRcX2L3yban1IZClEOnjYLItjtph+2uQobpfCujlRuVHFUnXuOv/Uryuk7VXBrnQ4LCwO6Y27A7xHPl9fY9I71Wspea1x6YBU7uEKLjjqQWESlOXFCQaZO6b/tQypiUS0VemgVtp190eEsY4MvizjhQ7eEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoUGp4ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoUGp4ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1041F00893;
	Mon, 14 Sep 2026 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789365825;
	bh=KqjB/WNCFPT0inzGwjS002JIK2q9H4LurIf7DjloH/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoUGp4axpMH4Akjpfy6gWU41WsCbCMAjIxcU6HEIGfGjfvMnbCXqg6r5oy+hHTBEq
	 7ucy159/ZZusDBVN/2xqM+z0riELiEjDPJ5DpC5HxeGotqmwgeitOFleoKCE6h7Cmo
	 7ZJs3cjVyx0L7w1+Hr4tXzgw0Gi5qguaSELvRMNjdgt+iH39QWD0j87bvyEz1pVEzw
	 9l9gCMx2mHNY4oV48krP3WjjOKqnuhQ79QWdNc6J7kHLlApwFlru/jEjmc5kEVR4hh
	 VVirBYtlnT5Tv41ekmeGAu6qYkN7fd0T7yO8IZEg9KIwxsuYcgpnfCgQ5+74uofwl7
	 Krc0cTj/yJETQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to
 DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260914055608.495084-2-quchaosheng000406@163.com>
References: <20260914055608.495084-1-quchaosheng000406@163.com>
 <20260914055608.495084-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:03:44 +0000
Message-Id: <20260914060345.5F1041F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The YAML binding fails to enforce variant-specific property cons=
traints using conditional blocks, allowing invalid device trees to pass val=
idation.
--

commit 92a1abcb0821a0c5c2127da5be10ac0403eb2966
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema

This commit converts the Freescale MPC5xxx MSCAN controller binding from te=
xt
to DT schema. It also documents clock and clock-name properties that the
MPC5121 driver uses.

> diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.=
yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
[ ... ]
> +  fsl,mscan-clock-source:
> +    description:
> +      Clock source used for the controller. Valid values are "ip" for th=
e IP
> +      bus clock, "ref" for the reference clock (XTAL) and "sys" for the
> +      system clock. "sys" is only available on MPC5121. When the propert=
y is
> +      absent, an optimal clock source based on the system clock is selec=
ted,
> +      falling back to the reference clock.
> +    enum: [ip, ref, sys]

[Severity: Medium]
Since "sys" is documented as only being available on MPC5121, does this glo=
bal
enum allow older hardware variants like MPC5200 to pass validation if they
specify "sys"?

Could this be caught during schema validation by using an allOf / if-then
conditional block that restricts the "sys" value to just the MPC5121
compatible strings?

[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

[Severity: Medium]
Because the description for clocks mentions that the MPC5121 driver looks up
"ipg", "ips", "sys", "ref" and "mclk" by name, should clocks and clock-names
be added to the required list specifically for MPC5121?

Without an allOf conditional block enforcing these variant-specific
properties, would an incomplete device tree node missing these clocks
silently pass validation but fail later during the driver's probe routine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914055608.4950=
84-2-quchaosheng000406@163.com?part=3D1
