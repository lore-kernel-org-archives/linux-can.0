Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9641D638;
	Mon, 14 Sep 2026 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377356; cv=none; b=Nmv2KHwJjGX5BUjNjc21VIbgInpfyS5hn9rGskXr2VvWOvVd/h5XuHgVYLdaOCmfk7q3p8PZJ7Fqj43NdRMl24CzsdmiWxTqRDSp9pd5T5u1TUx2WHqCb914HohW74M8kYM3nZ4PS+DSRzpCdXf9KfLGwpmDXctFW6Dem1ihZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377356; c=relaxed/simple;
	bh=3/7GKMq7Ffdymv55nF8gv1UWfbh97fBRIE6jQOLW8wo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX1UkY/IwC76rvF5ehTkzYRHUrCaHL8kSpksKYNu4tu17Cu2exVLtPhsOtOVeXTqQMCWv+aWfdFza2tDhgpPPtXmJYKrJxAbUXQKPqQihHUWiLGxPJt1e5g1O6gWsy3PA+oayghb+2oud30KCJxsUhoLoz2r+sJD02W0tYxnnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsosOKkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsosOKkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED91F000FF;
	Mon, 14 Sep 2026 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377354;
	bh=NwcMwKRRkkYemv2BkawzfM9Z8f4KUTQ+iOJ5B5DQHDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YsosOKkkACWgHmLGooGZU2Iu/XKmv8IqHtvqiVWKja1e+CrXncdgG95nxAuaqamYr
	 WRIj3eY5bMyQrs/SSDdkDLsptDcrqQ9qTTjj+vcIHJkv1gCPPdN5VQLaKl0AgCTDnr
	 dYCQtKl3gKZTUenV/9b5srtYpB6kKuLlMn6o4jbuK6ruLX1voZs5RxEZn4F1HtEO6S
	 cYgMzzZSBkPBv+QPC1cNbewwWudGhqn6dALRImvvEZ+w2Ltz0AkiI0YxGV9OQmXXI+
	 tq/tHJVl7uDvdKVtCev9iQA5PNPjjklQ22XtV8Xl8eefM4GCB5I6S3cWARyqJz+SGP
	 Yc4JKWsUgmV1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: can: fsl,mpc5xxx-mscan:
 Convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org
In-Reply-To: <20260914090440.552884-2-quchaosheng000406@163.com>
References: <20260914090440.552884-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:15:53 +0000
Message-Id: <20260914091553.D8ED91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `$ref` type definition for vendor property `fsl,mscan-clock=
-source`.
--

commit 0f4e0331aedb88733ad8480e58d0cb6aed274e62
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema

This commit converts the Freescale MPC5xxx MSCAN binding from free-form
text to DT schema format. It describes multiple controller variants, sets
up clock definitions, and introduces conditional properties for different
compatible strings.

> diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.=
yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> new file mode 100644
> index 0000000000000..277e78ca21f11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml

[ ... ]

> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ips
> +      - const: sys
> +      - const: ref
> +      - const: mclk
> +
> +  fsl,mscan-clock-source:
> +    description:
> +      Clock source used for the controller.
> +    enum: [ip, ref, sys]

[Severity: Low]
Does this custom property need an explicit type definition?

Vendor-specific custom properties without a standard type suffix typically
require an explicit type reference to pass dt-schema validation when running
make dt_binding_check.

Even though the allowed values are defined via an enum, a base type referen=
ce
such as `$ref: /schemas/types.yaml#/definitions/string` is usually required
to prevent build-time tooling failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914090440.5528=
84-1-quchaosheng000406@163.com?part=3D2
