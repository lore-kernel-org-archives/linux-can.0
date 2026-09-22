Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F8423E94;
	Tue, 22 Sep 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067155; cv=none; b=fEYIGCMLfF5gBQXAl4Vt52K0VUdBkNF6cRy9dMUjHt0ivDfumfkyFYdq8Uyouw6g5cHR6eWghjB8XsDx7SPru514XTiackgiTmV1X7Ai6GUWo86XhEH0dsVtrOPmQtTy/i0ZuNbd4KUi3xcqIjojn6fn+ZLEClk0ajchqrb3kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067155; c=relaxed/simple;
	bh=FTkAw0lLThB6+Yhnh3RryyZUz+LXgw2CinerPGjZN1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVqvUPpvRWjU5rLF/jWPupv0zLSXF4RqZn9iPzd5RxAtGkEtyJSXDx+mpM1Uknr/Q55TU3BBAQ6oUkyueYX/6TO/RelLWuLatu4RFjh+6UAVLKlrDAAMNGQRqxI9wR6TKigh2mvgFOr9M52sIDRKIcncCuFh6FHRXVoXA/rfd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr/GpGQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr/GpGQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DEB1F000FF;
	Tue, 22 Sep 2026 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067153;
	bh=6rI9Jl90INm2zy0DQhUYWCP8kKgYTm22ryajZ5iQcUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gr/GpGQw10l4JuYCf7Pjpxtzu36TjrsWSzV1Y6A8Enrhp/KCreOYEN+SRs7aaAA/p
	 zZcpyLEVB4jDdN5AxTmwIyBe1tSk1V+Kfim0rUgLpX4kIyO0OQdNNuOaTEtRYVoCdy
	 AAgn3SScF/hXjaJILiPyxGa3EVN+/UwM3A/N5osWpm7ulcghnl7ZZGdWMXTNUg012l
	 xTvSR2WgimMyrmVruEO57JVPB5RXFHfDM++3hcNwxMYv827nSgPlGkjmDC1F+rMyBp
	 e7Sx4JZY/3ZS/RmIh72ccfcRhmQkB7xvMPuPu5fOHiQlX/E4GNixsk/utuEcfGQP3I
	 uM3LDPmnDyMdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: net: can: holt,hi311x: Convert to
 DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260922084542.104788-3-quchaosheng000406@163.com>
References: <20260922084542.104788-1-quchaosheng000406@163.com>
 <20260922084542.104788-3-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:52:32 +0000
Message-Id: <20260922085233.23DEB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing spi-peripheral-props.yaml reference rejects=
 valid SPI properties
--

commit daeb2992a77029d59549250b99f2dd7fac156a7f
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: holt,hi311x: Convert to DT schema

This commit converts the Holt HI-311X stand-alone CAN controller bindings
from free-form text to DT schema format. It establishes the base properties
using can-controller.yaml and strictly enforces them.

> diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b=
/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
> new file mode 100644
> index 0000000000000..d9e3584590c65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
[ ... ]
> +allOf:
> +  - $ref: can-controller.yaml#

[Severity: Medium]
Since this device sits on an SPI bus, doesn't it need a reference to
/schemas/spi/spi-peripheral-props.yaml# here to support standard SPI
properties?

The v7 changelog mentions dropping this reference because the example doesn=
't
use SPI properties. However, real-world device trees that instantiate this
SPI device will routinely provide standard SPI properties, such as
spi-max-frequency.

[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false

[Severity: Medium]
Because unevaluatedProperties is set to false here, the missing reference to
spi-peripheral-props.yaml means any standard SPI bus configuration properti=
es
will be treated as invalid by the schema tools.

Will this cause dtbs_check to reject valid device tree nodes that include
necessary SPI properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084542.1047=
88-1-quchaosheng000406@163.com?part=3D2
