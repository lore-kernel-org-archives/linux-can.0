Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC94A4EF1
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595068; cv=none; b=d2OncE6oS7KqX4xsVeCCXHCAq8fArRLhpkdpOCnorwGp15dsduHd4lRtlRgbyZEvct4i58l2HRl8U6MqO8mTO9/EcesAVWTxOK5mzHNAvDzBm0ocmQgew78B4L+Z0lvPL4d3FuqVoxYFndcpPL7tW6UrEOH0tLHjSC8GZKdgHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595068; c=relaxed/simple;
	bh=HBGyAXdreE2+vV6+7JfuROd/c4ucFXvXweaILDfs8ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cbQvlqt99+wWktWwWap8RoPM/4Db2i3RaSFUshfJ9nEOAzCXceNuA9E4/jEFHTVicuHZRLLuY4qUT/vaMyfx8YTcrBdAznEF8yN1pNWahySosuIZs1j9BFD3jnyr/5gEFuL+KxItqjjATxwIOfx8twjDJDXf98VJdmjajfeqA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsJYZY8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsJYZY8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290801F00893;
	Mon, 28 Sep 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790595067;
	bh=Qm8gwLp7HN214wcXGoTfE1ELji/w+vRE+lXubf86PfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GsJYZY8VLLJ79wDu+F92JTjsIgfzINmn0PLh+76ruu6MnF+/bbceiDmigJSWZTe4X
	 Tp/wKULK8NwZMDZaO4wNvavzZoo/SGTpZY2yDZqacIyMLQ8q2ldlHOHbbW0q3u4Ca4
	 wk97Tb16q3ZE0or9CZJh4oLsP4jymMihApRcEZMrj8iAuhIfWoCKMNkSjqNwmhQ/4H
	 b34Ty5wBZ62/K7EoWAoHEzs5zfNEq4OqE0NMu0WrYzHQ5HAZ/fzKm4Sslx8P2V8jvJ
	 lSRsVvuvxLcxBXHFR0m2XZtwnZ7SZNwGSw4clE1tPi6BMbh9zsfrlUIG6po3/iRc2x
	 lnpU4TTtw8JYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: can: grcan: update the binding file reference in
 the driver comment
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260928112658.2119678-2-quchaosheng000406@163.com>
References: <20260928112658.2119678-1-quchaosheng000406@163.com>
 <20260928112658.2119678-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:31:06 +0000
Message-Id: <20260928113107.290801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] doc: dangling reference to missing yaml binding file
--

commit f19b659d77f11a2ca8192b1defd0f0c8ae4f2108
Author: Quchaosheng <quchaosheng000406@163.com>

net: can: grcan: update the binding file reference in the driver comment

This commit updates the driver comments in grcan.c to point to a new
YAML binding file instead of the old text binding file.

> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index ce12fa6df56d5..1b4944d1d06dd 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -10,8 +10,8 @@
>   * Full documentation of the GRCAN core can be found here:
>   * http://www.gaisler.com/products/grlib/grip.pdf
>   *
> - * See "Documentation/devicetree/bindings/net/can/grcan.txt" for informa=
tion on
> - * open firmware properties.
> + * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.=
yaml"
> + * for information on open firmware properties.

[Severity: Medium]
Is the actual devicetree binding conversion missing from this patch?

The commit message states that grcan.txt is replaced by
aeroflexgaisler,grcan.yaml, but this patch only updates the comment in
drivers/net/can/grcan.c without adding the new YAML file or removing the
old text file.

Does this leave a dangling reference to a documentation file that does
not actually exist?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928112658.2119=
678-2-quchaosheng000406@163.com?part=3D1
