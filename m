Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59839E19A;
	Fri, 16 Oct 2026 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118236; cv=none; b=HbtMJCSlaRXtIdHXazthdaB1pAMWfgTJ7Yl4+z6E4M5nEBSbj5EZZfpEBmTHfrw+ebMyRmzvCZF2MTM+YzsGvhzHETjtqIrjouKIhZd/H/Fu48AgWzxSdlLEut5X1BY1L5Ku5sUa/DgLFjBZi7mb28+LVJdzOtds6K3Ft8coJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118236; c=relaxed/simple;
	bh=R/Yn0SGOZynrKMX740jy2eTWyLIrDEo2PJoP61O0lJY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2FL28ndeqOB+40Wo9tyd+zfOxgqV4xHR/OIxDV9oppSLCsk2rrl6xbPmxtTJMq5TQvER1AHLl+FP0SpHIFIuA+HeVJ8TEQAcU/3tLcNRISIcP8KijfkylHKtnBCRtRkc+5PVyE7gI5hh/18zYe57S++9PeFFq34tcoW0Hft8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2wRwvcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2wRwvcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3221F000C6;
	Fri, 16 Oct 2026 02:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118233;
	bh=u5Bw8lFEaI62e866j235OjdHZBGUZnHEmmF3ATESZW0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e2wRwvcnMQdTqk9NGcfSvuX/KeYRpI9Rg//Y5MZS6V1+nCOOM3m+ywigkTebPFpki
	 WgYrn73x6IcSl3FPtjYmoT4vBrkWUw8Yu/WN/Ycd/cq7xIIAlXQn/s6UWIdbq4V4Sc
	 iyWCiCAhdgmX5iKrm8tVAbNuGZC79tlMrVJkeXUui4Xl9gv8QiXs0ArnbfIWmCuGUl
	 krLy0NzvhnrrDwQSv9CmSnYv/yHCDPcAmduCFgM0oyGm5kRNG1jq97ppBNu/NcfSpR
	 +IzAEAjV0FssPUDe7IB1b3kUSu7cCadPbqFJUwak4lvFiDUvvWZT4FfoRL9OVe9D+i
	 PJsKXmWKuXmlQ==
Subject:
 Re: [PATCH net-next 21/37] dt-bindings: net: can: convert grcan to DT schema
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:12 +0000
Message-ID: <179211823229.434549.6830532108439542194@kernel.org>
In-Reply-To: <20261015015336.816543-22-mkl@pengutronix.de>
References: <20261015015336.816543-22-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch deletes
  Documentation/devicetree/bindings/net/can/grcan.txt.
- [Low] The binding description (aeroflexgaisler,grcan.yaml lines 18-20)
  and the commit message both say the node name "<core…

--

dt-bindings: net: can: convert grcan to DT schema

This converts the free-form grcan.txt binding to a DT schema. The nodes
are built by the PROM and have no compatible string, so the schema selects
on the node name. It also moves systemid into the description, because
that property is read from /ambapp0 and not from the controller node.

Link: https://patch.msgid.link/20260929073703.2748220-2-quchaosheng000406@163.com

> diff --git a/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
> new file mode 100644
> index 000000000000..d5cba5b1bac1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
> @@ -0,0 +1,65 @@

[ ... ]

> +  On a LEON SPARC system there are no device tree source files. The nodes
> +  are built by the PROM from the AMBA plug&play information, which does not
> +  provide a compatible string. The driver therefore matches on the node
> +  name, which is built as "<core name>@<irq>,<address>" from the "name" and
> +  "reg" properties of the AMBA plug&play core.

[Severity: Low]
Does this describe the source of the <irq> field correctly? In
ambapp_path_component() in arch/sparc/kernel/prom_32.c, that field comes
from the first cell of the "interrupts" property, not from "reg":

arch/sparc/kernel/prom_32.c:ambapp_path_component() {
    ...
	prop = of_find_property(dp, "reg", NULL);
	if (!prop) {
		reg0 = (unsigned int)dp->phandle;
	} else {
		regs = prop->value;
		reg0 = regs->phys_addr;
	}

	/* Not all cores have Interrupt */
	prop = of_find_property(dp, "interrupts", NULL);
	if (!prop)
		intr = &interrupt; /* IRQ0 does not exist */
	else
		intr = prop->value;

	sprintf(tmp_buf, "%s@%x,%x", name, *intr, reg0);
}

Only <address> comes from "reg", and it falls back to the phandle when
"reg" is missing.

The commit message uses the same wording:

  The node name format is "<core name>@<irq>,<address>", as built by
  ambapp_path_component() in arch/sparc/kernel/prom_32.c from the "name"
  and "reg" properties of the AMBA plug&play core.

Could both places say the name is built from the "name", "interrupts" and
"reg" properties? The example and the select pattern already match the
real behaviour.

[ ... ]

> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
> deleted file mode 100644
> index 34ef3498f887..000000000000
> --- a/Documentation/devicetree/bindings/net/can/grcan.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.

[ ... ]

[Severity: Low]
At this commit grcan.txt is deleted, but the header comment in
drivers/net/can/grcan.c still refers to it:

drivers/net/can/grcan.c:
 * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
 * open firmware properties.

The commit message says the driver comment is updated by a separate patch.
The follow-up "can: grcan: update the binding file reference in the driver
comment" points it at aeroflexgaisler,grcan.yaml, so the stale reference
is fixed by the end of the series.

Could that one-line change be folded into this patch? Then the reference
would not dangle at this commit, or if this patch is backported without
its companion.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
