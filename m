Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAB48E0F4;
	Sat, 10 Oct 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640980; cv=none; b=h1Z2z/8PMNdNr3MkfKZOHt71i3nVJKz28f+iXZhK00uw1PoIWsvN5doemY7dAXKx0wTJ31/F8ZUTjVjPFvUP+PLXaQ2WOyY5PnzbUyiXHmbZ1+aFO+RKoMlGI0OH1TE9ol3/1Udwqyfamq7sQxZ+pcnHCZKsinJI5hc9RcNTY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640980; c=relaxed/simple;
	bh=Asw3wF4vCmOtnrj1Qso5qlgT+Ut2inAO9F9gZNjnso4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nfk3d9fcNnvUPlNGhuxcXNlIKHcGHHYZhIE5s+02vbbWXG0mIvMLDAo6OKtmr3G8f+l2TKeO250RV7Btybj+V6IuRsIziK41CkrWvTczsmAY+53oJluy3ZT1i6kup4a4aKMHnf7/frd0H+xF+MPZ0307qdHPbmKuH6luABEjNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1snh06Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1snh06Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7C31F000FF;
	Sat, 10 Oct 2026 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640979;
	bh=FlvwBpvB5ITktkXB1bruTuvQZ2qzc0e1Qe/3ZBfBtOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X1snh06YbiqpHsv46bdlH5m91acEIALTajUL/L29H6buGt/uCBVoKZFE3A3U35maq
	 zruR9rKe+y0s9fwA2D8/5yAubtkdGgLMRaHrNqV8mdTaqqvtPkvWqwhVzxKtckoU5k
	 fcJ/F5/8i7ffImWTfeuE9X/LN2GI5v/IJp2d/gnDvzv0sayO2FfekknMMAm9P/DVWS
	 XHU8hj5MQ+RVcD4C+miG/W8I80QEk2PiRWMjVxU07iDF62DeFHiVzq3X23QZGICMQk
	 KfCVMnx34fU6Xe+rDSqhU5ks58hwuGbkH0bqZGRjsxCmV0wVsSOCoVxJL5ez8DDhQ4
	 tbvCeDCwM9PAw==
Subject:
 Re: [PATCH net-next 18/37] dt-bindings: net: can: convert grcan to DT schema
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:58 +0000
Message-ID: <179164097829.434549.3805612419282435655@kernel.org>
In-Reply-To: <20261009134323.64064-19-mkl@pengutronix.de>
References: <20261009134323.64064-19-mkl@pengutronix.de>
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

- [Low] Commit "dt-bindings: net: can: convert grcan to DT schema"
  deletes Documentation/devicetree/bindings/net/can/grcan.txt, but the…

--

dt-bindings: net: can: convert grcan to DT schema

This converts the free-form grcan.txt binding to a YAML DT schema. Because
these nodes have no compatible string, the schema selects them by node name.
The text file is then deleted.

Link: https://patch.msgid.link/20260929073703.2748220-2-quchaosheng000406@163.com

[ ... ]

> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
> deleted file mode 100644
> index 34ef3498f8870..0000000000000
> --- a/Documentation/devicetree/bindings/net/can/grcan.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.

[ ... ]

[Severity: Low]
After this commit, the file header comment in drivers/net/can/grcan.c still
points to the file being deleted here:

drivers/net/can/grcan.c:
 * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
 * open firmware properties.

Would scripts/documentation-file-ref-check report this as a broken
reference at this commit?

The commit message says "The driver comment is updated by a separate patch."
A later commit in the same series, "can: grcan: update the binding file
reference in the driver comment", changes the comment to point to
aeroflexgaisler,grcan.yaml. So the stale reference only shows up when this
commit is bisected to or backported on its own.

Could the comment update be folded into this patch, or ordered before it?
That would keep the reference valid at every point in the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
