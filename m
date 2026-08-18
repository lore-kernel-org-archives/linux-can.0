Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F836A350;
	Tue, 18 Aug 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045045; cv=none; b=mL7tbrzHM0Jj3kKhrof9uOuNSz2C9L1gSJWFZ7G9L8wV9xpqJn5apdyEAk/mTv5qLo/sfauie5JncHlD2+/Pu8QE3u3sh8uVoVbTqG7voUt1CFoeGMevwU1DWWhyUgV6TJetE/ViSMl5YQqCY+FZTcQRh2liWFMgVqm7QPT0eCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045045; c=relaxed/simple;
	bh=iSTMz5JaelVZw61CADSGAyftHMDXVbZDGl08buTUlrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G/H5hz3jirelR38OnZ6Fi1jeKhHWwVrJS6mDMJ2sBgQJyo9vZKO1gnK4jcrFXR2yBKneIWtqY9H7IES7x9L4A29Skx+hpj7fy0piOSXCNHkN4Eq6C5GzWMQi14NH/1aC6Eckg2j/v8Kucs54lw2ksuKsVk+uNyIbBnL4kA7bEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryw7xRws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryw7xRws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D591F000E9;
	Tue, 18 Aug 2026 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045044;
	bh=DB4gc021DxXbso9INjf52whfyuI1KE4radMT569Kt3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ryw7xRwsMSyymz8yAHbZP1MZIQLpezjiTiR+wkVf+C53rN8t+vm75N22jXE8cDPYu
	 m42BaTlinIEEOgbdaNGd2xLBDJDMKoSeXQWjCGTXouztVmBW56GIrr08Tso/aEzBHI
	 182bYalEBRBVvL267vmTL+/salqdWwfyeZVPjYZ0gegavSSPf7uKEmLA71maiLqWGv
	 WipSHkFMVxiWc7n8DozQWzQzCoUG9yq4fjT6jE+IX4EIor5Tk6sY5P/grlmZGSzoQn
	 ko1rTwAPZSxTDvSfxU90N1QLfSmLQ0zB1QGCSF4giG1OyZolhciIwzyl1zd9DszQrj
	 fFo4UCr5d+6ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2542
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, Frank.Li@kernel.org, robh@kernel.org, vkoul@kernel.org, olteanv@gmail.com, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, neil.armstrong@linaro.org, imx@lists.linux.dev, linux-phy@lists.infradead.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, conor+dt@kernel.org
In-Reply-To: <20260818091701.6441-3-wahrenst@gmx.net>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:24:02 +0000
Message-Id: <20260818092403.66D591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new compatible string 'microchip,mcp2542' is added as a standa=
lone enum item in the binding but lacks corresponding support in the CAN tr=
ansceiver PHY driver.
--

--- Patch [2]: [PATCH RFC 2/4] dt-bindings: phy: ti,tcan104x-can: Document =
Microchip MCP2542 ---
commit 43adb87775584a977c1d440864b9e805fba31d0e
Author: Stefan Wahren <wahrenst@gmx.net>

dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -24,6 +24,7 @@ properties:
>            - const: ti,tcan1046
>            - const: nxp,tja1048
>        - enum:
> +          - microchip,mcp2542

[Severity: High]
Since the compatible string is added as a standalone enum item, a device tr=
ee
node will not have a fallback string. Looking at the CAN transceiver PHY dr=
iver
in drivers/phy/phy-can-transceiver.c, the match table lacks this new string:

static const struct of_device_id can_transceiver_phy_ids[] =3D {
	{
		.compatible =3D "ti,tcan1042",
		.data =3D &tcan1042_drvdata
	},

Does this cause the PHY driver to fail to probe for the new device? If this=
 is
a pin-compatible alternative for ti,tcan1042, should the binding require a
fallback compatible string so the existing driver can match it, or does the
driver need to be updated to support the standalone string?

>            - ti,tcan1042
>            - ti,tcan1043

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818091701.6441=
-1-wahrenst@gmx.net?part=3D2
