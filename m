Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D533387363;
	Sat, 12 Sep 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248938; cv=none; b=QytlJr6+yVju0K8zU9AvR1+7Oah29VcUmrq9IX5Kje1g0yORzsKNgGqiYETCIhwJnv8lXN/OKhCLV6rbwC+NmXhy5DWULpG53e7rR3NCzDBc0xAZSGpsQvUpq50BqnG557aSz0lA+zuLKPBP/2IiTCbPs4wriPwSKd3mx7kTU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248938; c=relaxed/simple;
	bh=9bEFWRrLRynT1q20S6WDkkvD8TfuLXNDTWJmDjr7OS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nICJRPRzqx+isSXPVaEjHLcrEw25tQdnSCLxSYe7DlwIhQx5QYWsY/BrbFF7SSUg5lIfr+wJxILG83hke3oU2GkCJPMPt8raMpiMj2QpKGPGLs29XZ6dVKm2HtrxUudACkXFosXwLsBuiVVJKZ2+i6t7sH2brtcJ97qP4+/FAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpYaXFGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpYaXFGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211151F000FF;
	Sat, 12 Sep 2026 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789248936;
	bh=+co1zKJaLCHHEtDJlm8SRpPTZfwPNtyE+k1LDvY6YuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpYaXFGAlV+igsDjjYFNsNcljEwcaZ51qEq/txqWyDKHiRD45PC/YDKwyvU0RBRDd
	 qm5Pi0XjM/GZClcXFISvThS2qL+JJbsA6+9DdueboQxe8rr5VbeekIXg6SamkmFvId
	 e+iMnbUOLGCiZ+QVzBhzKXsWlQibou/0gR/Swrz/rp1ZeSVW++MYW0XUsK9BoVQR9A
	 eUeb4OgsI7Ifgg0kg1cxQs2fnTeEQbcuTe7mcWAy0t3iiMYKQBQJaFunUJKhT0vWX5
	 bFa06YRBQqWOi257olvz0F2UsRM1p027sTqTvgO09OLSOZAO7vRE4zZ5dpXB9/1be1
	 FRscXenbdK0qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, robh@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260912-temp-v5-2-2e3201c02109@ti.com>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
 <20260912-temp-v5-2-2e3201c02109@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 21:35:35 +0000
Message-Id: <20260912213536.211151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing rollback in m_can_class_suspend error path leaves device p=
ermanently unusable if deinit fails.
--

commit f4778144b1ead7bde54359bb563953cd8601ac93
Author: Kendall Willis <k-willis@ti.com>

can: m_can: add ti,am62-mcan compatible with out-of-band wakeup support

This commit introduces the ti,am62-mcan compatible with match data to
identify the out-of-band wakeup capability for TI AM62 SoCs. It also
updates the suspend path to set the out-of-band wakeup flag when
the device is configured appropriately.

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16f80607e150e..67ac6995a7f27 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2622,8 +2622,14 @@ int m_can_class_suspend(struct device *dev)
>  		cdev->can.state =3D CAN_STATE_SLEEPING;
>  	}
> =20
> -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> -		pinctrl_pm_select_sleep_state(dev);
> +	if (!ret) {
> +		if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
> +			if (cdev->out_band_wakeup)
> +				device_set_out_band_wakeup(dev);
> +		} else {
> +			pinctrl_pm_select_sleep_state(dev);
> +		}
> +	}
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but could this error path leave the CAN device
permanently unusable?

If cdev->ops->deinit() returns a negative error code (e.g. due to an SPI
error in a peripheral driver), ret is set, but m_can_class_suspend()
unconditionally stops the clocks and changes the state earlier in the
function:

    if (cdev->pm_wake_source) {
        ...
        if (cdev->ops->deinit)
            ret =3D cdev->ops->deinit(cdev);
    } else {
        m_can_stop(ndev);
    }

    m_can_clk_stop(cdev);
    cdev->can.state =3D CAN_STATE_SLEEPING;

If an error is returned to the PM core, the suspend operation is aborted
and the resume callback is never invoked. Does this leave the network
interface detached via netif_device_detach(), its clocks stopped, and the
state stuck in CAN_STATE_SLEEPING indefinitely without a manual module
reload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-temp-v5-0-=
2e3201c02109@ti.com?part=3D2
