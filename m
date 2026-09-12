Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43814381B01;
	Sat, 12 Sep 2026 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249036; cv=none; b=FhBak9cTKOSbxqpmgnPmc777yITjv40zCe2bPvvB4rCsfvDE3HasVx/Tt61MFG+sEBe+n57x7PaEGS5ho70mPOv3eCefSxOzaoYmhtB86Di8mrky1FSZ2salXdRo4EFGUh1MuAmlq4tDy7+uTuoM9b64lLN4Gcn4Js/zb5W0VQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249036; c=relaxed/simple;
	bh=qj3E516w5rlfXVw0vah8aJwGckURYUeLqvbEOVq1DDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAL5/Tj3NU1f9ejvWwY5d2C39EQWkgOUuIMbdjoOMsBy7OxmrrdIABwUgFvk/JwLdGmPey96fvRe4tdnMFX4NUQsbi8LFF97Wlo1Wqtd73YTTAUYluT1pWNYK/IEBrplcdgSUl7ifPs6uYrm63y7/NVxHOp3DNI0PzQfyMjbB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvsLYViY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvsLYViY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E611F000FF;
	Sat, 12 Sep 2026 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789249033;
	bh=NcFlwSkraGDdjGJ/ya9kv/fvXPZVg24R//FCHnJw5d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvsLYViYulkdojsqxFpVQdrmfbNmhX8v3b+fM2Fo3tB0z+fdJ0kN7r2V95IORiHcJ
	 hq4elJr432XYz9mWEd3m2DiTRPzXGBURTWw70mU2C1xK7jUr3nRy1OOzCrl4ujn6v9
	 L4sNVdPqvpC1hsaUw75KEQ4UAsvasj1NEowiyBEGTNrEp4Og/bUyYXjyBmbY2CQY6N
	 AvfoNGyQXe0d9fbKMj5QNeph4/XDFvPauN5FmH++Og3a1sDdlMVR8OV00QxPVdADr7
	 HM8jdaEbeoZ/shpInk44FWUHJOjZdrpXcBKHD4yvl9/jZviCfk44OCEqo9gc7iO1HX
	 F1Th14mngDF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260912-temp-v5-1-2e3201c02109@ti.com>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
 <20260912-temp-v5-1-2e3201c02109@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 21:37:12 +0000
Message-Id: <20260912213712.96E611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect YAML indentation for the `items` sequence violates the ke=
rnel's yamllint rules, breaking `make dt_binding_check`.
--

commit ce14f1f5cb441a60c48d5a3b96ea09ddcd2c9e74
Author: Kendall Willis <k-willis@ti.com>

dt-bindings: can: m_can: add ti,am62-mcan compatible

This commit adds the ti,am62-mcan compatible string to the Bosch M_CAN
device tree bindings. It updates the schema to allow the new TI compatible
as a fallback to the generic Bosch compatible.

> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -16,7 +16,11 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: bosch,m_can
> +    oneOf:
> +      - const: bosch,m_can
> +      - items:
> +        - const: ti,am62-mcan
> +        - const: bosch,m_can

[Severity: Low]
Does this indentation in properties.compatible violate the yamllint rules
for device tree bindings?

The configuration in Documentation/devicetree/bindings/.yamllint enforces
an indent-sequences rule with a 2-space indentation requirement. It looks
like the sequence items under the items keyword are placed at 8 spaces,
which matches the column start of the items keyword rather than being
indented to 10 spaces.

Could this formatting violation cause make dt_binding_check to fail during
the build?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-temp-v5-0-=
2e3201c02109@ti.com?part=3D1
