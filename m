Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555486;
	b=mJpJuCT/fuM6kKUDG5iy1DnIYEKY6UuBjuzIZ8n3RVnEB3DNtr3Tp/yAEODPH5ZeQPrd
	 7h55tiuMHgFdjKlv5u/Uecd1hBVZVS/ULyGb6vWD7LIqMhRBDZeu2IKQu9dDoYPTowUqb
	 MDkwi6Rl5Angj5HRHmarM6Zmp5pnvB6AWbhL2O/NWfKOzasq4i62MPeiX+ojpjXv9jUvF
	 r/FVz15d72JAJmQCw1pnWUHayJlz8DsSVBsaTfTo5QB0Kxiq+SanLUSbpr9hGZ0iDkApd
	 s+62UU/4j1eYvgjpK+w3dYNhQUSoCBRbz0v0VSRy+0R6KmD3TbdCF+gApAwt3lVSjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555486;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LQacofxb1i6ZWqRqLoxTy5QdWwl/l1rPUoDbmxjAF9Q=;
	b=a9ZOurdov5n2Rhr6beSNi73kIpK0p7reHY0dwTFVa6+HFNjv9fvE2+hJUyzAYYJ37/xZ
	 9ywzqK8uqFZtkE7LwSzyHnanhXGujrCNGgsbSD0SVlavs9hOMp81sZbsbBSLWeIMcLE8i
	 NmqBbm88IBs0NN/oCmqFEnkng2S/AETaWkrdOFl/UbZLJ8Ju+x8w22ZhsFynN79yY23st
	 3vYUAry39G+dS8XoPs0uwV8zOpMEySy82pKojXbvr1d7o5e4/q9Yoytx9A+CrqgAdH9Te
	 OtvCIxrMXm04NUUN8rLeZO1U6z/o875Iet34JUFmqek0cCRGlUv31nMWhYlvdGgk3Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2y7oH7e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3D606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2y7oH7e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D0D1F000C4;
	Fri, 13 Nov 2026 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794555486;
	bh=LQacofxb1i6ZWqRqLoxTy5QdWwl/l1rPUoDbmxjAF9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2y7oH7eG+LcJxWuR8jCW3+LrqCxnWXtvzi6Ugwq6qC5pEDtwsqnw00uFQU5cl6ck
	 mDWxA/A3ZHkv5Xc/COYjOM8oZJV0yzKsjfNGqeCqN07L0BrALXyk5MOULoG2tbPaLG
	 XWBKwFUnCycbntxZrWmdNfZqejgHg1FbChciO0Smhyt1fvOmj31ZBnioCjyauXRE6x
	 Ghxa6VfSzq27UWapIKkHhhIhn84f/h93sr/kjJ3/JYA9kRagc+IhaSVLWT6lynQ9LM
	 2BQ9qp3E4ktexvqcuTUCaeDSjMk8xENfu2m23fP3NdyRD9KKm9XOow+HqWZN9xAjtD
	 UhOHku219ohog==
Message-ID: <sashiko-outbox-212355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: can: ifi,canfd-1.0:
 Convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261113071325.4092169-2-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:38:05 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: net: can: single-word name in Author and
  Signed-off-by
- [Low] dt-bindings: net: can: commit message claims unused
  IRQ_TYPE_EDGE_RISING
--

commit 20b578f1ac5dfb3641ca1495585b6a04db880f29
Author: Quchaosheng <quchaosheng000406@163.com>

> dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
>
> Convert the IFI CAN-FD controller binding from free-form text to DT
> schema.
>
> Reference can-controller.yaml. interrupts is required: the driver obtains
> it with platform_get_irq().
>
> The example now uses the GIC and irq header defines instead of raw number=
s.
> The values are unchanged: GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is
> IRQ_TYPE_EDGE_RISING. Rename the example node from canfd to can so that it
> matches the $nodename pattern in can-controller.yaml.
>
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Link: https://patch.msgid.link/20260922102258.138753-2-quchaosheng000406@=
163.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: High]
Under Documentation/process/submitting-patches.rst, the Author header and
Signed-off-by trailer must use a known real full name with given and family
names separated by a space (for example, Qu Chaosheng or Chaosheng Qu)
rather than a single concatenated word.

> diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b/D=
ocumentation/devicetree/bindings/net/can/ifi,canfd.yaml
> new file mode 100644
> index 0000000000000..c8c3105c727b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    can@ff220000 {
> +        compatible =3D "ifi,canfd-1.0";
> +        reg =3D <0xff220000 0x1000>;
> +        interrupts =3D <GIC_SPI 43 IRQ_TYPE_NONE>;
> +    };

[Severity: Low]
The commit message states that "1 is IRQ_TYPE_EDGE_RISING", but neither 1
nor IRQ_TYPE_EDGE_RISING appears in the old <0 43 0> example or in this new
example.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113071325.4092=
169-1-mkl@pengutronix.de?part=3D1
