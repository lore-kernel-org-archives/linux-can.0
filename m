Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082069;
	b=knD1jHWhNtikUriW/xOrlE1tf4efDDZtQuIEHjLihwdIN9xJbMY+S9btw0DT8+ROa5R1
	 yY7ZDeStERBkKs6nHHp6poYDxsxKhg5KTcvpXhkgR98q6uVYxixSmMVlo8GkYbFPDdbMY
	 O3Kg9gXGJeZ5Okm2su8qhLwdK/nzdiW9l1Np9y9RF0OidyrHDHA/8sUBO1Lhmj3uYYamE
	 p7J3HiTBhN8mQtEW2LgnmXnUEMOvzO2NrQI6S/J/ZTFOXqzq2gcYWp/kP1+w+ExLYP4RV
	 YibRQSpzKRjSWs3LMTSi3pD4duMLRokNpn6YraIjBG9FFDae0qRk+Gm+lY7jMmttoiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082069;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=obGBpySIvx6emk3zOnHCrpwW6BEFOnCL9XiX5vLr8nw=;
	b=C/Wh7XRmL7Se9xG4J77b4vnjqKWECBapVkvhmRk2hEd02pxFX/e9NhEdyZtMbKiCAvV8
	 ArrSwWNWrw7nMhLDwELOJs2aobh2mnvoZLsDw7Zz6lgFdyxj5GsKROHiiQ9k7hZvjvoJA
	 9mZHC82WKbc35jhm0gNEtq7s0+kZX1NzBzAw+3Rx3/FX4vyPECo0a+7kyDpNDqScyoUpr
	 SC8I6lMSDwZ6cUs5NQl9U49C5iB/CtIxkR8C/4zJT8uXx+jeHkXZimO6JAFx+ba8YlKEa
	 LsFmuan/k0QVKeVmtNkXwc5zahpg59isFlEeg6tVYrxS3JF8bJ/Bt5h3QKv3bS/V4uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ddP/n2PA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B18606A320;
	Thu, 19 Nov 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddP/n2PA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E881F000CA;
	Thu, 19 Nov 2026 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082069;
	bh=obGBpySIvx6emk3zOnHCrpwW6BEFOnCL9XiX5vLr8nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ddP/n2PA7NfcaZCgedOYThStDr74AP3H6ZJ6NvmdzvQy/O+XEklszTupmJm631wyE
	 IWFpdX+CYG+WG2wU3uX42DqY/nIPlGCbbGbxUwttubikIdD42IfNBuYBWBMCwwmxbe
	 WjWSEN7Tfs57f5QP/PPjHhjrlJdyR0ueIWHWHQnAHOCr+AAm2pwbciPUDituIBmquX
	 PJPtxXswZTePeANUrJnaIi4t+q83qzg549/Vc43T+a5RPnVQaBUa4E9cAl+FGdtFKR
	 LZk5PDIxTSqS1PEb5j6vcM6DDOSYmrkh1LZMiraflqZXQfhV45/nkbXcdriNJcSa5J
	 P6YjjBgH0ZzgQ==
Subject: Re: [PATCH net-next 04/12] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 dev.kurt@vandijck-laurijssen.be
Date: Thu, 19 Nov 2026 09:54:28 +0000
Message-ID: <179508206819.3136.5143765579402417874@kernel.org>
In-Reply-To: <20261118092955.1283165-5-mkl@pengutronix.de>
References: <20261118092955.1283165-5-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] For the ctucanfd glue drivers, the commit message's claim that
  the conversion "reduces kernel size in case CONFIG_PM or…

--

can: convert to DEFINE_SIMPLE_DEV_PM_OPS()

This converts seven CAN drivers from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and wraps the .pm pointers in pm_sleep_ptr().
It also drops the __maybe_unused annotations from the suspend and resume
callbacks.

Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@gmail.com

> diff --git a/drivers/net/can/ctucanfd/ctucanfd.h b/drivers/net/can/ctucanfd/ctucanfd.h
> index 0e9904f6a05d6..7dcd7dc507e49 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd.h
> +++ b/drivers/net/can/ctucanfd/ctucanfd.h
> @@ -76,7 +76,7 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr,
>  			void (*set_drvdata_fnc)(struct device *dev,
>  						struct net_device *ndev));
>
> -int ctucan_suspend(struct device *dev) __maybe_unused;
> -int ctucan_resume(struct device *dev) __maybe_unused;
> +int ctucan_suspend(struct device *dev);
> +int ctucan_resume(struct device *dev);

[Severity: Low]
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

With CONFIG_PM_SLEEP=n, pm_sleep_ptr() only lets the compiler drop the
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

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> index 4b6db28f7b670..9c9c41c3058c0 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> @@ -259,7 +259,7 @@ static void ctucan_pci_remove(struct pci_dev *pdev)
>  	kfree(bdata);
>  }
>
> -static SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resume);

[ ... ]

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/can/ctucanfd/ctucanfd_platform.c
> index 70e2577c85416..4962b00ee8ac0 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
> @@ -99,7 +99,7 @@ static void ctucan_platform_remove(struct platform_device *pdev)
>  	free_candev(ndev);
>  }
>
> -static SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_resume);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-2-mkl%40pengutronix.de
