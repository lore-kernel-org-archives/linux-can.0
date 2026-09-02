Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70800476CF0;
	Wed,  2 Sep 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356129; cv=none; b=SW/yD6ntg9vY+2ZKsv1mkEnPs/y9lzAziICmB44jMIOTwWHhvvmGtUcc74hjnEn+Dy5mXDVCMV12dIUfQ8r37IPJOzfIP6NWoW0lq1gI+CzNwYHijtfDpJi8m2EUJ7C3rwTDfvazf9RUBr7llYoj3OrVXTxMY+Y+qibnv8veeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356129; c=relaxed/simple;
	bh=LasyqCyaY4KjfMpvNPz82L67wfUPTzmc4z+mDW0nqzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txV6N6Kp3Kz8h3T6YWLuAvJcXV0q195eHJyt6BVxfZBeOqbkFXFtj+13OrAwZOpbjR+0k8vNcz7hO8zJpXVfs/ECbx7MqPjqyXnrFb+W616jY/9ogC4zykwJY1RGx5EWs65cfXAYBc7B1Yxs8PpkCiELiWI2iYNgyariiPELqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1BZ39oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1BZ39oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22DE1F000E9;
	Wed,  2 Sep 2026 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356126;
	bh=BGuIznCv9PUDEBDkw/pQ/InrE0j7ZosksJqwh4KPsMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1BZ39oaogdM2I1AE3RSZkU3cFwXZgVOlugezO1Bzyybx1qYZd7RQzSZ4yOqKCS6I
	 p6XjGIlrJ6Gv18frbwe3Zxf9L9NV0zyAmUVuTxpI/zNfWslLzpZLYRHefMHSQ9PcRQ
	 JzHngr/BtMslX+DllSH+uJ02N6oDNzybG3NCnUPnVexYo/2OjZ2x3UbZdxD0wtRJ5T
	 NnZZQL1F+nMIG7899AbjTGCC+RvLcCvIYUCr4zJGW17E4EXRbi7wqhQObY52KBWlE+
	 DGSMnDkpWeBfe+tTRwxQi/H3FCx4fdm2XBlFfLkn7JhLgVOHppHXHJRWQ/fBA91Wdy
	 cuQJApxU3j3Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2542
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Wahren" <wahrenst@gmx.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, linux-can@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, vkoul@kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, robh@kernel.org
In-Reply-To: <20260902132801.22056-3-wahrenst@gmx.net>
References: <20260902132801.22056-1-wahrenst@gmx.net>
 <20260902132801.22056-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:35:24 +0000
Message-Id: <20260902133525.E22DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `microchip,mcp2542` compatible string bypasses s=
chema validation hardware constraints because its fallback conditional bloc=
k uses a strict `enum` match rather than `contains`.
--

commit c5426cb50d1b23a21e92a69a5197ccb523f72e8b
Author: Stefan Wahren <wahrenst@gmx.net>

dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
   =20
The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 9f5c37ca6496a..3ed4ce2191201 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,ata6561
> +              - microchip,mcp2542

[Severity: Medium]
Will this newly added compatible string bypass the hardware constraints enf=
orced
later in the schema?

When a device tree defines compatible =3D "microchip,mcp2542", "ti,tcan1042=
", the
schema parses it as a string array. However, the allOf conditional block fu=
rther
down in the file checks for ti,tcan1042 using a strict scalar enum match:

allOf:
  - if:
      properties:
        compatible:
          enum:
            - nxp,tjr1443
            - ti,tcan1042
            - ti,tcan1043
    then:

Since the array fails the strict enum match, the then constraints are skipp=
ed,
which allows a microchip,mcp2542 device node with an invalid configuration =
to
silently pass dt_binding_check.

Should the allOf block be updated to use contains instead of enum, or should
microchip,mcp2542 be explicitly added to the enum list, to ensure these dev=
ices
are properly validated?

>                - ti,tcan1051
>            - const: ti,tcan1042
>        - items:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902132801.2205=
6-1-wahrenst@gmx.net?part=3D2
