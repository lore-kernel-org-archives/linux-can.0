Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998E3CAE84;
	Mon, 13 Jul 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934323; cv=none; b=SWmNBK2tQSI2nUhbfrWDprRntahkdaiHabnUtSsCIBJyTV6D8QGjK62sjwO2oFSJlC98aHg5CEw6MXDj52aKMF8PHZPY8CeWUlEPuVPIFRIbNLvrIR6oDp5z0e2UU7/xmnQykCRliiasEZA3IEbK9iGvHU9Ohixbu4lfbnzfzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934323; c=relaxed/simple;
	bh=HoGudEA3/UGPUFZeHBs0goYGBX0tK9K3/9aUbf9KZA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jehnsFIXUt8dRsGmwjBdzVxVp8mJsHr5PXjMMO/lLg3N8Aw+KiZyynA2313vcLwJSBwBxOHpjghW8HVKJ7YyOp5cRYWY1qQ0zK3y1mqGb9c9KAG7a3dHmqZTwFegbOHWX53mWc04EjDkKUKhGNXbRHuojyYmkHx9sqL0E2JFTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpQpTRfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpQpTRfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322D11F000E9;
	Mon, 13 Jul 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934321;
	bh=6yqUSN/e8kq6AbWr6U2lgOTKcyCUso6Rbl9W/U1G0ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TpQpTRfjeYU/avUD7cnPNJJB/8l7CdtQfFZzQH3GwW3QOGs28gjAVKYdbb4eE+XCW
	 D78SlD22VMFZSXS16jJIa3OYYxtccp+uC2ndx62ZxF6OQV0euSgDATK1RRRNPjzRP7
	 3tzqmOlvAw45eb/GNBvpeYPR3mfXu9H/TLSOYS+7N0swX3BH+HwfBwQv6sqPZ2Eiy9
	 Bf9NGCRM2Nnl8bpGmUYXkp4atp/hF8pCNENPj1b7bTa6YLWY10ftIFn/THuwkT4pnR
	 DWxYJ8O934L1pdk7ksvOT53RvZuIQhH+355DYF7dbDM6pVK1I5Dm8ymuzKcOWDGCWm
	 mQwDjmXVzl6xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79
 SoC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, imx@lists.linux.dev, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org
In-Reply-To: <20260713085306.2643794-5-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-5-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:18:39 +0000
Message-Id: <20260713091840.322D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The flexcan driver fails to claim the newly added 'nxp,s32n79-fl=
excan' compatible string.
--

--- Patch [4]: [PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79=
 SoC support ---
commit 81a73119cf0179abcfa99d350e69491bfd8303b6
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support

This commit adds the NXP S32N79 SoC compatible string and interrupt propert=
ies
to the FlexCAN device tree binding. On this platform, the IP uses separate
interrupt lines for mailboxes and bus errors.

> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index f81d56f7c12a5..d098a44c2b9c2 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -26,6 +26,7 @@ properties:
>            - fsl,ls1021ar2-flexcan
>            - fsl,lx2160ar1-flexcan
>            - nxp,s32g2-flexcan
> +          - nxp,s32n79-flexcan

[Severity: Medium]
Does the flexcan driver need to be updated to claim this new compatible
string?

Because the binding does not provide a fallback compatible string, devices
using nxp,s32n79-flexcan will fail to probe unless flexcan_of_match in
drivers/net/can/flexcan/flexcan-core.c is also updated to include it. Is th=
ere
a companion patch planned to update the driver's match table?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713085306.2643=
794-1-ciprianmarian.costea@oss.nxp.com?part=3D4
