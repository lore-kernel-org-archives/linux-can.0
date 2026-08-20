Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1803DD866;
	Thu, 20 Aug 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262539; cv=none; b=nVtdCijQzN+6q36oess/++SdDNBJEIli25jV6YV36rSbW1fq8zVBR0w5zfWwR794q785kxCtC2y8UjRmMfAMeUWEL8RCbkrC2TMOfGw6X7SOGjrsdsxAyCXMgVRw6q2gaDF/6mN/9jwTkyh5FviC3r2gDeRlOjEc7ROajmdjaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262539; c=relaxed/simple;
	bh=CIuEw5Mimqdd/dcmUCtkxidI8uNh8OJK6A+vHfRsy/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JXcSDENIU3q7Xb19DO9tSmP2EyLgxlzSpvoVslD80RCT+2z8nHQPbwwLx50hBlBebpK9isTsY+xnFGYF0cHODeEVc97XdPe8PCzzIn2Qdi7Lniplc3YcKURj5tyL5q/y/YvIMzwIg6mUw5qRDxxxTAVpUDlwcqrTCsRUw0yvFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DStYcoQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DStYcoQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712A01F000E9;
	Thu, 20 Aug 2026 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262537;
	bh=0vijz7xiIl+aXRgIvhoCO1tJ5GgOpNNGhEDIOg6jIkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DStYcoQDcMurBMyMiBopccel15VDRhAYU3JUwoeYuHXc3SDb6cPnGUc+5FNz1ATUv
	 GPCMaMPX5WikQzVdlOXSFzmCNLTm0QzwC2F8c6v0poBnl1o4bjxU+NkelRT/9wh8VO
	 86KDgIX6rM/yIQQEpcnbRUS5CE3wtY7eXo7Vd6fqrf2oDPfxgMuBvKWxhwH5orJaDF
	 c0As4hHwow3+fWJ48furVPdakjgTU1RjKTkJ5u1i596zUZcDNeo71q52jOTN5kIjo9
	 9DCEObjUyfox0Jq1R6WmKtK04lYw9+xFpMn9TmuuqudWKqGB0wzhf5AW/lxCuwJJgL
	 8MK1SwbA5WrWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: can: m_can: add out band wakeup
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, robh@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260820-temp-v2-1-dd3f8cacc15e@ti.com>
References: <20260820-temp-v2-0-dd3f8cacc15e@ti.com>
 <20260820-temp-v2-1-dd3f8cacc15e@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:48:57 +0000
Message-Id: <20260820214857.712A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added custom device-specific property `out-band-wakeup` i=
s missing a vendor prefix.
--

--- Patch [1]: [PATCH v2 1/2] dt-bindings: can: m_can: add out band wakeup =
property ---
commit 66d860c00379089f5518db1a67a453077a6864ea
Author: Kendall Willis <k-willis@ti.com>

dt-bindings: can: m_can: add out band wakeup property

This commit introduces the out-band-wakeup property to the m_can binding.
The property indicates if the CAN device is capable of waking up the system
even when its power domain is off.

> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 2c9d37975bedd..b6cb945c225f1 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -150,6 +150,11 @@ properties:
>      description:
>        List of phandles to system idle states in which mcan can wakeup th=
e system.
> =20
> +  out-band-wakeup:
> +    type: boolean
> +    description:
> +      Indicates CAN device is out-of-band wakeup capable.

[Severity: Low]
Should this device-specific property have a vendor prefix?

Since this property is not defined in a core common schema like dtschema
or can-controller.yaml, the Devicetree specification requires a vendor
prefix (such as ti,out-band-wakeup or bosch,out-band-wakeup) to prevent
property name collisions.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-temp-v2-0-=
dd3f8cacc15e@ti.com?part=3D1
