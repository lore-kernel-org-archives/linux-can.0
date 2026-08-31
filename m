Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85E443AB0;
	Mon, 31 Aug 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201451; cv=none; b=nXHrKByACnaNheit/i+kN6iOJ4uNsb6ISur4N2t7Ob9mLvwov2WoFSLTQ0Svqx1mn2Q+rIHPC2KvNkdgMh5m/OxfViL+JgVyM2Q67qyeGx5hplfrH07DdLGgEfhnzWXlLNKN1HGL6pj0wl/Arl1SGR9YC6MCYcseXeeIz0uCWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201451; c=relaxed/simple;
	bh=Lh4APJvTv8reX8Q87TX1Rl6zasg7VMXLUYBK3kUgfP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9QWZzN3GDbhcN2Ohpzoo+IpbOaUXj4fheywVjVG4NrvOP3ZChbDl9ypVuyNyNmkOLt+UNdRHK1bhQk/9JclLRGBfKeNVpMnpGsJm12Pz0oEbVC/z0jkvqv/spw/chITLifBgLzruHSZEVuh8/91+QDhSrYz+p17EZF5x1sS/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdY7d/3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdY7d/3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A71F000E9;
	Mon, 31 Aug 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201450;
	bh=HREneAFRBlMW9u/Le7CHGfsKDjVf0NPfW/FmhX4GLcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PdY7d/3AvZ2JFw0gLUQvutP1cK7dQC0PG8p4bbxQEG+KItS6nMbi2AZA4eiPw5IDG
	 JQ3uhrAVF1Dfei94eRRx59Hf5u25E659CIEUXT/dZglsxkQFhv2UkPkjEQWYIbHuib
	 +rQqZcfPc/jGQMcp6pcQeFeyyvr9Wp0JM5wwLaYdIGSnpfrpZjM+DNIsyW9Td1f2Uq
	 hVqx5DRJHVVeIeKZCIfhaUeAXkUB2UAEBSLwYHhAPUe2xGLVoAJZLUqG6JsfsRsHnK
	 bqrmSKNlloWH7/BZmiiaXG9PaJVrm91Ef1XdWMnVBhIRZHpnFdfOe47Y//xUU6aIjr
	 1umZG53XonxJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79
 SoC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, robh@kernel.org, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260831143449.12828-5-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-5-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:37:29 +0000
Message-Id: <20260831183729.C40A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of split IRQ handlers corrupts rx-offload skb=
_irq_queue and CAN state.
--

commit c8453ab295dd4a8e4e7831e7734d0b2de7b63259
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support

Add NXP S32N79 SoC compatible string and interrupt properties.
On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index f81d56f7c12a5..d098a44c2b9c2 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml

[ ... ]

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32n79-flexcan
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Message Buffer interrupt for mailboxes 0-127
> +            - description: Bus Error and Device state change interrupt

[Severity: High]
This is a pre-existing issue, but this multi-IRQ configuration exposes a
concurrent execution bug in the split IRQ handlers.

When multiple interrupt events (e.g., mailbox processing and bus error) fire
simultaneously, the handlers mapped to different IRQ numbers on multi-IRQ
platforms (like S32G2 or S32N79) can be dispatched concurrently on different
CPU cores.

For example, in drivers/net/can/flexcan/flexcan-core.c, flexcan_irq_mb()
calls flexcan_do_mb():

	handled =3D flexcan_do_mb(dev, mb_mask);

	if (handled)
		can_rx_offload_irq_finish(&priv->offload);

This can run concurrently with the state change interrupt in flexcan_do_sta=
te():

	/* state change interrupt or broken error state quirk fix is enabled */
	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
	    (priv->devtype_data.quirks &
	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
		flexcan_irq_state(dev, reg_esr);

These concurrent handlers invoke can_rx_offload_irq_offload_timestamp() and
can_rx_offload_queue_timestamp(), which use the lockless
__skb_queue_add_sort() API to insert SKBs into offload->skb_irq_queue.

Since these list insertion APIs omit locking (relying on a single-IRQ
execution context), can this concurrent execution corrupt the doubly-linked
list pointers and lead to a kernel panic during normal CAN traffic?

Additionally, with the FLEXCAN_QUIRK_BROKEN_PERR_STATE quirk, both
flexcan_irq_berr() and flexcan_irq_boff() can concurrently execute
flexcan_do_state(), causing data races in can_change_state().

This issue was introduced by the earlier commit "can: flexcan: use dedicated
IRQ handlers for multi-IRQ platforms" in this patchset, and it was not
resolved by the end of the series. Should locking be introduced to protect
the CAN state and offload queues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D4
