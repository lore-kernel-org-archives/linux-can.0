Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C54315D49;
	Mon, 14 Sep 2026 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355209; cv=none; b=UCdJlK7ozPHVLhdOdkTTGYwSGmVM3hLgMTTUWSLhQOSHMwDZXgUYa2ki9TtOwOjaBMVOIlDMo5QoKEUciVE+tP0u3UiXKt2qiTDIUhRWdYYe78yf8BZLQtMxwp1fueqCuXIAYcwtdS6uGH2xa9A+azWH9dTk2D9aq6DTIZUUUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355209; c=relaxed/simple;
	bh=ikCms7dHnQ58KtfShzANpejMmdQR0aSYKYwOoOCSCdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0t/bX0+8/nIvXnk/0/CC5dCjfXBSY0Axw6yyhUTmF6dweJQSVTdGu5AWaeDVbNrhhS6l7Yc+T1R3xXxZ3cQvPD5rfLJ/l87cY3NusC8h7O4s2Wo5NAGw+4L8p99LgZLZCASJDGCZwOOgw9vSlDWFT9Y4FxWVKa50cGbYgDCtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2W5vy6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2W5vy6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E31F000FF;
	Mon, 14 Sep 2026 03:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789355208;
	bh=nPZ4G9Ucm0Nfp79cx0WsIAisJR6iTQwKI22ZFtFeTPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2W5vy6zxxW/aHk/BCkYB25Eetl9D9bJT8hwWmOWbJb+gs21+CaXxn1y9oZvXafff
	 x8BFlZGUpgwa2yIKK1zOsLBpSDqVwJY57FfkKauPZEUhuI/AATehxLzXZSiAtMFOFF
	 EVMnn0lHM6SLHcrXxaHlbu3uvvcKOmQ5rBvZio9fVEIeKoCKVwgLen6QnTSy+wHmPB
	 7LN6EoxUcre7VbhtV/yCC2FRLVvViAzRiWn/liw7Mn7ZrP4M3ZaIMxdhVU7ZMAA6wD
	 6F7kuh3Cxysp+JszgvkHcuCvSvfgslsFYrQGwxSPD7y6QQYMIk8fXtFQr/2NXanPU7
	 0uRDFlAEXz15Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: can: cc770: update the binding file reference in
 the driver comment
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org
In-Reply-To: <20260914030215.437602-2-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
 <20260914030215.437602-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 03:06:47 +0000
Message-Id: <20260914030647.7B9E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit updates a comment to reference a converted YAML binding =
file that does not exist in the repository.
--

commit e518a37460a65d07aab5618e8c0ad5c878991050
Author: Quchaosheng <quchaosheng000406@163.com>

net: can: cc770: update the binding file reference in the driver comment

This commit updates the comment at the top of the cc770 platform driver to
reference the newly converted device tree binding YAML file instead of the =
old
text file.

> diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc7=
70/cc770_platform.c
> index b6c4f02ffb97a..b690167c454fc 100644
> --- a/drivers/net/can/cc770/cc770_platform.c
> +++ b/drivers/net/can/cc770/cc770_platform.c
> @@ -30,8 +30,8 @@
>   *           bosch,external-clock-frequency =3D <16000000>;
>   *   };
>   *
> - * See "Documentation/devicetree/bindings/net/can/cc770.txt" for further
> - * information.
> + * See "Documentation/devicetree/bindings/net/can/bosch,cc770.yaml" for
> + * further information.

[Severity: Low]
Does the bosch,cc770.yaml file actually exist in the repository?

It appears that Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
was not added in this commit, and Documentation/devicetree/bindings/net/can=
/cc770.txt
is still present in the tree.=20

Is this patch part of a larger series where the YAML conversion happens in a
different commit that wasn't included?

>   */
> =20
>  #include <linux/kernel.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914030215.4376=
02-2-quchaosheng000406@163.com?part=3D1
