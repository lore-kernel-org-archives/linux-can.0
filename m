Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29F238166;
	Mon, 14 Sep 2026 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350332; cv=none; b=OTHGZhki5n4i11+ri77+gxD3o+kXALLf8A/E3dfyWD0JhoVLGWtVzoCsZ6j2cRCEvDLUgZ5nQpC8aBtTrTTtxwSmBv9MVy8kxHCy8tYzjTJuEruClDJjPUlaIdRtSQ+6dLseLzoxc7ol0J/qDGlYAz6hGZSt493559zdTIZTEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350332; c=relaxed/simple;
	bh=tAYBugW15ze6fzg/yDnnUBPKrXLXELaDscf0DEDZ6Ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPwm61T3MiU8NoI0lS+OZalxrTaMYyFwf1dG0AUbBTwSUs9RfcbTihF9sCMrFeP9anYRHEceRFBmGne+iZqHiFq7P7Ecz4ufigy5ZQArLfRSbYXxq+ZVeV7BxyL6p12u/W5iG0iXxXQ8u9HzKH/ofAhXc2O7Q4Wb8WHnFiFtc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx5WngSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx5WngSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5E91F000FF;
	Mon, 14 Sep 2026 01:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350331;
	bh=OdyWO25tZ63dkA3NClMeTuVtV//yMD3mY6AFfT2ADT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx5WngSDPuORz0IQIKf9UJsZXwdyNqA50iv4MutpnncDnJuWtwEgqyNJkBoTWGyJp
	 JyXiY68ygXbCWDDw9GCoedG5X5MOUs1Fs7YqF4S2OhKq2DEmMKZMX+Qs7PEHDjgk3X
	 a5cw6b95FVFuXNy7NQXEbJW6307dTXL+o1cqwwXgdC8qKNDh53mpc2lKIvyj82ME2t
	 gv+i6+/b3PFCbBosiLu9WndridBs16el08OFsjwb71lCtV+5MFNv1Kyulo/e9j+7b+
	 0ORgJN34IlB1fNd4ak5FqHd1VHAsLRZODPe6iSlG3y8ylIr7IA9H0moBjPrS11muQG
	 tEFeT7w7T9tcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: can: convert ifi_canfd to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: conor+dt@kernel.org, robh@kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260914013745.394514-1-quchaosheng000406@163.com>
References: <20260914013745.394514-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:45:30 +0000
Message-Id: <20260914014530.AA5E91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect use of `additionalProperties: false` when inheriting f=
rom a common schema via `$ref`, which improperly blocks inherited propertie=
s.
--

commit 471062b3f0e20cbfb084fbd8547c9d66999316e1
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: convert ifi_canfd to DT schema

Convert the IFI CAN-FD controller binding from free-form text to DT schema,
and reference the common can-controller.yaml schema.

> diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/D=
ocumentation/devicetree/bindings/net/can/ifi,canfd.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml

[ ... ]

> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +properties:

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

[Severity: Medium]
Does using additionalProperties: false here conflict with the $ref to
can-controller.yaml#?

When referencing another schema via allOf, using additionalProperties: false
strictly forbids any properties not defined in the local file. This will ca=
use
validation to fail if a device tree node includes standard CAN controller
properties like termination-gpios that are inherited from can-controller.ya=
ml.

Should this be unevaluatedProperties: false instead, to allow the properties
defined in the referenced common schema?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013745.3945=
14-1-quchaosheng000406@163.com?part=3D1
