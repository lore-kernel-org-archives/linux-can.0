Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4924A21;
	Mon, 14 Sep 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350326; cv=none; b=g9c6iEOohONx+V5u+eSTw9ksXl9a7dsGkPD9TrUtjs55C+vUX5iidTeaASWWu5obZS4LxnzR7KckmTqNeverOdC/0zynftFjbDZU9dL9cdcBA0Nkhxc7XEkVM7UyyrvaRp6OfRo+C7L3A0J5C6CtOpSn7dvIso/kYfbZXnQPxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350326; c=relaxed/simple;
	bh=rIJOeO+ERmF7EPb7YNijBvw7MrYMvrh84NT+WpsTMgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfS5HVyQMIfLkXfbUMHBxtmQ0B3js3hoNhDw6vb1w2a4UfNLuyKENOQVRYyiuD7TKdEYIb4kw0k2F/Uc8qlPUVx5fAAZF/2dm80sAslTH+Hmz2MUqS+Ske214Pt+IVgraNr91zFSEaBwWh4H/41Zi8Mek9MIWvHZIF+8Eunnn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esdu44Yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esdu44Yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E51F000FF;
	Mon, 14 Sep 2026 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350325;
	bh=jfYXuzRl0vvsA4y2U6/Xy16jIhfkeJQmKszv/TAby8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Esdu44Yo+gSZT4PDDLD9/q9nBns7bU9kLLyvN906b1svoh0YKtvJAkMOhyjJWRxJQ
	 0Un0lJSM5lCPLVxtBqYcGRmbNqYC1/3zfXwuSzwuuF+3tGyuMK8nb8JsrCyjlbCW82
	 dod6G9CCwOUt5uEv7zXQ+I1i4drkIeGi3hvMfTszJaIHxJS954Tqu1a5dW6dDhiNvP
	 /ysRNAlmvrgJ5qi6gQTq4J3skOVuKfypesgOuGNv8J7seeGyPblYM5y/ZNEGv7xpKe
	 9hbUvXVhu4dakDizY8C96rN4RUW2ONlHqoldBPAVke9uB8dNUkXzCINhSMTZuuI5YX
	 0udxjTy8bX0Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: can: convert ifi_canfd to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260914013636.394263-1-quchaosheng000406@163.com>
References: <20260914013636.394263-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:45:24 +0000
Message-Id: <20260914014524.C31E51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] DT Schema Error: `additionalProperties: false` incorrectly restr=
icts inherited properties
--

commit 762b0b1dc7188a87b810716f4344f47313aba8cb
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: net: can: convert ifi_canfd to DT schema

This patch converts the IFI CAN-FD controller binding from a free-form
text document to a YAML DT schema. It also references the common
can-controller.yaml schema to inherit standard CAN properties.

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
> +  compatible:
> +    const: ifi,canfd-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

[Severity: Medium]
Will this strict restriction prevent inherited properties from being used?

Because this schema inherits from can-controller.yaml# using an allOf
block, using additionalProperties: false here only evaluates the local
properties block. If a standard CAN property like bitrate or
termination-gpios is added to a device tree node, dtbs_check will reject
it as an unallowed additional property.

Should this use unevaluatedProperties: false instead to properly allow the
properties defined in the referenced schema?

> +
> +examples:
> +  - |
> +    canfd0: can@ff220000 {
> +        compatible =3D "ifi,canfd-1.0";
> +        reg =3D <0xff220000 0x1000>;
> +        interrupts =3D <0 43 0>;
> +    };
> +...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013636.3942=
63-1-quchaosheng000406@163.com?part=3D1
