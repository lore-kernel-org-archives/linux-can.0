Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087146;
	b=nsSYSIRQoUgdxMv5KpTdAzB8/QX0Hw3BRpGi2lL58OTPCzFhbst8yaFz9HCibq4VUe2U
	 EN36H8hhQCbcL98FLDo/ZHFpY2QB8f3UooRD233x1XENyeCgqrFwd29FhWRTA7mDsPWmZ
	 S5CQdAcH97dE+i8SQz8i3B0HZJDksAKMmEK575pQONg43bnIcUDp/JlYpSifLK9iYrbgI
	 XG/N1XVNsFl7jTLQMj0y6wtro/CnU2k1BwiHGnZ2M96blDZIgMyQtH5LYOwzQ0GGkS4zB
	 L4ecf5uofrvNb9bGgKyXzm29dBBabuhl0lpBkROOa1JrVYo6fT7wxSTpj9R231uEmKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087146;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=wOSaUhNzRQZSZbKNyJ686z49J5S1qumvN1lcQHRpq5g=;
	b=TSqUpVdbkX1fpM8qKlTK8Y5HA1BKPlFc/jUD5yaTIQXkrT41zl3eWcJBlRq1xM8XPjpG
	 5xxh9DeQQWWi85wIsLrMswPcmP81J4aTONNEQcc5YSd4NJiKiRP6xaLpwjt0CZjR3RaSe
	 Isa/oeFKgcnWMQVSYL2RBsOL05dwLCdmvmxuNzJrkmLZxmhq4inAQo3RHCpfEy2Q5gg1M
	 lfAwPPVzkxbEEbvm/sW0uEBw43ENBudQwgK1ZOWEJh/F+fO7lZBmpWrflylTxDVSnaKqJ
	 wlrX8kcTvHZKV6/jqMAw6J/xMdET0ySHeSTjnQDzfT0VD+JHVaFr62IjLjx1TWj41pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="UpVU76Z/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F34606A33F;
	Thu, 19 Nov 2026 11:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F34606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UpVU76Z/
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B0AC72021AD;
	Thu, 19 Nov 2026 12:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795087141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOSaUhNzRQZSZbKNyJ686z49J5S1qumvN1lcQHRpq5g=;
	b=UpVU76Z/IyCbjTNGJDP5Dp7oUluAQUn1gkQ1hcxyW3giYfkXxjS+/JG75zX1Jp/1ON3VT/
	Ut3skY/Ufsjo/118bmCy4bxUmUxVGwfLLj4y66fGX2mrgxM0iA29KPETLG9sKJk9lQQiYA
	E+ygF9DVm5/ixg/duyJPd/8zSXPb+KkdFHA/bQsr7NQ8DKCoIj9efJ8TE23Igyu96Yrf9R
	3JXVCYtpd24J0EZoQOwkuKxUfyRw1/XWZwiDTwe1+/IE0/IrV8C8OVN/up2JFrur31JaRy
	iFXZt7hEzAF/SXn3Ub4VTbLd2zan8Tnf4uVXKI6XIVuqckPiPlOqZJ3TYpHCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795087141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOSaUhNzRQZSZbKNyJ686z49J5S1qumvN1lcQHRpq5g=;
	b=KUE5ro/dI6hNVpdveBw37I6voYZWxQ/Nd+b+o/+aT9jRJ9X20XOBE8xltbgKu3MERvK3dn
	xLXN5ICFcEbk6MsWMwQDEj31ADIjolOAlOZaQm7gv/rzZQvweYRrdyy+CqoiVGupR9ZVlA
	z4+a7dJcNH9winXDCs7DyiZyiOZXI2Sp+KhiBM7YiB3qUYfqKR8GnZO5AaMn88Mw20D5b2
	AmGO9wM3M30FC70J6QF4/J33s1OidEAPotFJ5KzI8RyTqAVvwmxj14pkYwKVv9OAWhHVOI
	NUMpfGWzipeiPrVf7SofjgiaE820BkTRwk4+A7f1Pcu42PIOaF94UxsB2VzgIw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795087141; a=rsa-sha256;
	cv=none;
	b=fO5cPs1WODQQC7Q3h/SIQuiymHrQofet2AHCUudg+13HDSLe3Es9HWd3beJaX4ZyGyv3/L
	woqK+7WFDniW8uMLDV6KLX7v/Fgs4fJnrxgzoNlB7AovKyNKXhImxIBbijz8dfdMiWfVru
	aSOmsQ12wA0eDOM4AH3KHorHb0ydlmt73r8pQOr8AZmkMe7Rb/sNx7EaaaBG34gCrONCcj
	XSnKr8WI1mCmCwWExJp5keGTc0ua8Bp8CNxR79PfthyW0EtebRqLwxSeXPoHY4JAOiWZJI
	CJ8iUAkUsZ1sLMqY6oBQQpG8M9Y9VvMuk66vCLqLL+LIBCFPHChkwzuPhI2rKA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 12:19:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20261119-awesome-onyx-mustang-706b19-mkl@pengutronix.de>
References: <20260822074701.22856-1-triet.hoang.dev@gmail.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pnl2lzrlprnkdhsh"
Content-Disposition: inline
In-Reply-To: <20260822074701.22856-1-triet.hoang.dev@gmail.com>


--pnl2lzrlprnkdhsh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
MIME-Version: 1.0

On 22.08.2026 07:47:01, Triet Hoang wrote:
>  drivers/net/can/ctucanfd/ctucanfd.h          | 4 ++--
>  drivers/net/can/ctucanfd/ctucanfd_pci.c      | 4 ++--
>  drivers/net/can/ctucanfd/ctucanfd_platform.c | 4 ++--

Clashiko has found an issue with the ctucanfd driver. Can you re-spin
the ctucanfd changes only?

regards,
Marc

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-=
5-mkl@pengutronix.de

--- Patch [4]: [PATCH net-next 04/12] can: convert to DEFINE_SIMPLE_DEV_PM_=
OPS() ---
commit 2eebc61f80e1b0678405e6e773cda6ae37343aba
Author: Triet Hoang <triet.hoang.dev@gmail.com>

can: convert to DEFINE_SIMPLE_DEV_PM_OPS()

This converts seven CAN drivers from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and wraps the .pm pointers in pm_sleep_ptr().
It also drops the __maybe_unused annotations from the suspend and resume
callbacks.

Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@gmail=
=2Ecom

> diff --git a/drivers/net/can/ctucanfd/ctucanfd.h b/drivers/net/can/ctucan=
fd/ctucanfd.h
> index 0e9904f6a05d6..7dcd7dc507e49 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd.h
> +++ b/drivers/net/can/ctucanfd/ctucanfd.h
> @@ -76,7 +76,7 @@ int ctucan_probe_common(struct device *dev, void __iome=
m *addr,
>  			void (*set_drvdata_fnc)(struct device *dev,
>  						struct net_device *ndev));
>
> -int ctucan_suspend(struct device *dev) __maybe_unused;
> -int ctucan_resume(struct device *dev) __maybe_unused;
> +int ctucan_suspend(struct device *dev);
> +int ctucan_resume(struct device *dev);

Discovered by: opus-5-5 =C2=B7 Missed by: sashiko-gemini
This isn't a bug, but does the size reduction in the commit message hold
for the ctucanfd drivers?

  "also reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is
  disabled."

ctucan_suspend() and ctucan_resume() are global functions in
ctucanfd_base.c. They are exported with no CONFIG_PM_SLEEP guard:

drivers/net/can/ctucanfd/ctucanfd_base.c:
int ctucan_suspend(struct device *dev)
{
    ...
}
EXPORT_SYMBOL(ctucan_suspend);

int ctucan_resume(struct device *dev)
{
    ...
}
EXPORT_SYMBOL(ctucan_resume);

With CONFIG_PM_SLEEP=3Dn, pm_sleep_ptr() only lets the compiler drop the
static ctucan_pci_pm_ops and ctucan_platform_pm_ops structs. The callback
bodies and their export entries are still built and linked.

The __maybe_unused removal in this header also has no effect.
-Wunused-function does not warn about non-static functions, so the
attribute was not suppressing anything here.

To get the saving for ctucanfd, could the base module export the PM ops
instead, for example with EXPORT_SIMPLE_DEV_PM_OPS() or
EXPORT_GPL_SIMPLE_DEV_PM_OPS() in ctucanfd_base.c, and have the glue
drivers use pm_sleep_ptr() on that? Alternatively, the commit message
could say that the claim does not apply to ctucanfd.

No later patch in the series touches drivers/net/can/ctucanfd/, so this
is still the case at the end of the series.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ct=
ucanfd/ctucanfd_pci.c
> index 4b6db28f7b670..9c9c41c3058c0 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> @@ -259,7 +259,7 @@ static void ctucan_pci_remove(struct pci_dev *pdev)
>  	kfree(bdata);
>  }
>
> -static SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resum=
e);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctuca=
n_resume);

[ ... ]

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/c=
an/ctucanfd/ctucanfd_platform.c
> index 70e2577c85416..4962b00ee8ac0 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
> @@ -99,7 +99,7 @@ static void ctucan_platform_remove(struct platform_devi=
ce *pdev)
>  	free_candev(ndev);
>  }
>
> -static SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_=
resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, =
ctucan_resume);

[ ... ]

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pnl2lzrlprnkdhsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav7bIgAKCRDMOmT6rpmt
0lvxAQDPGuQ6H1YuZnPDbbu0ybo99daEnvV3l8S/h+3OsqZBvQD/aLsp+MGOPS0G
1tfDZmtxzyn9ynfaV8st6JxU8rzv+QE=
=bZK7
-----END PGP SIGNATURE-----

--pnl2lzrlprnkdhsh--
