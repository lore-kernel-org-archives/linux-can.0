Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB964D2ECE;
	Fri, 21 Aug 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329014; cv=none; b=qbNQTjRd1hJwCx1sXHC7f1PjFg0Biq22p747tApznY06xHhs6SoZcCDjn+A67S4+rFEhq6Otbcu41tembLF/OIOjubGP/3shWz3dTKAFBcy/or7IFtGufV+MlIjPtfjv6HMEPm05+Jfuhi70BJJYw5rSQXRAURZ/OLXYa8zL9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329014; c=relaxed/simple;
	bh=7xjIlrhQpWSEvXF8dp8mqthwupupmoEwuW3mX4TgsDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TRjBwm1kU8LjIEMfCJzRDkPldjUQy0OISRFapTYrmW/riXI7dF5FtpL/9HD7k1PgsRXjGDP5o2qjU91Qs6naKycJqHcq8QwdAIpoeoOs09+qbwX8B2OYBob0AooevtrriwvWlXSNcFxEeI/Oy8TzcEnzJokPhkQW1q42EP0/kNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMFF8CeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMFF8CeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07541F000E9;
	Fri, 21 Aug 2026 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787329013;
	bh=aW3XRg5zMxEXOAsVrOdpsrefaGaaUQRbx7cRDp2jceQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMFF8CeBiBCXN6KM66ljoEhpn6j/Xj8L5cuU3Z/3W0UxidQzghx8KTCZnp2N/PLzV
	 vw32lMSmPxhgXBI8YsdieNyUsQhfLZrZUpbJYQCn5XaPOFe3UL91rFbtyyzJsraUQ8
	 fNiPrnxsEjHyfuFoHvCsJFs2c/Bvab4IXawsw4oWVYyeqYSzLnwkHkOjZdkHjKxjvC
	 AtRvuUxP7p4oq5ZdWtlVIUH1wohqNmVNqBIefSrTfK00qTPiBUQk9ilq+fFPX7RISD
	 zobyO0juo9CCVyg2QLq6uZir3sPmXX9rO8q55D/6HbsW9G+WdPIz9XK1hHgQ9TS4aj
	 rHWFhPx0rOutA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: conor+dt@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, robh@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260821-temp-v3-1-9ac1f8806929@ti.com>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 16:16:52 +0000
Message-Id: <20260821161652.B07541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `out-band-wakeup` property lacks a type definiti=
on, description, and the required vendor prefix.
--

--- Patch [1]: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup =
property ---
commit 18cc4cb55e5269767b220486da77c10e4826ca15
Author: Kendall Willis <k-willis@ti.com>

dt-bindings: can: m_can: add out-band-wakeup property

This commit adds the out-band-wakeup property to the bosch,m_can device tree
binding. The property indicates that the device can wake up the system even
when its power domain is off.

> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 2c9d37975bedd..0663beaa532bc 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -150,6 +150,8 @@ properties:
>      description:
>        List of phandles to system idle states in which mcan can wakeup th=
e system.
> =20
> +  out-band-wakeup: true

[Severity: Medium]
Does this property need a type constraint and a vendor prefix?

By defining the property merely as true, schema validation lacks the abilit=
y to
enforce a specific data type, meaning it could silently allow arrays or str=
ings
instead of a boolean flag.

Additionally, if this is a custom hardware property rather than a standard =
one,
should it have a vendor prefix to avoid namespace pollution?

> +
>  required:
>    - compatible
>    - reg

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-temp-v3-0-=
9ac1f8806929@ti.com?part=3D1
