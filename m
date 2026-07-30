Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5D3D9DDF
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407399; cv=none; b=Xb5b1bRjMaDXWdCuD40TPBXproh3n4FLRY+ae928ZEK8ciRlx9GN4VGABYkzElRAJqu6x5zq5c/aa6vE1P4j8ns3sj1PV4knf/ZdcDIcCuB63acaVLXiq67iZFGn67g/iqI8JAsxycmnlBCJFbctTjBqz3Yps9QtUCARpQgGDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407399; c=relaxed/simple;
	bh=I6bfxhfxUEMC5x5e+aRVMpTq39ymomS0ysIZnZVFEOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMv2bRFZKH4ISPEN2leY3IDZuFw66r6Ac0LXPpGOlKgJ9FkU79PuSGsJFVToW7aHBWVgXr79wfOOVDYTKpSaKLpuNpwu4zFI17lVloxpdg/8LUBjAFolx3ON9T2XDvkylEkaWG/XH2YVF76NZ3YTP/JaG2MLPKcQsTnGLV95Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/LFWbWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/LFWbWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B9D1F00A3A;
	Thu, 30 Jul 2026 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407397;
	bh=7z/HUDbkSDHeLW5wEV+wJB9GV4BARSJ2wh7ISMv7X18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/LFWbWIvoVcHb3A50klFIVmDXlR2t5qsj0HsLSuAW8jt8JQnGjuDV+Xi0dqpPh6y
	 02gD8vXhedmFZZzQ1j/iwABSM3E2T5jsAClmz/CiMTrX/eTBCjm9I/gfozPbJMCk46
	 2SwDT6G01CcDXK0Oe6BZP5N3JYm+JrCaGjnJPydKNzKbqZKSIWexzFKyuCcmI2uN2w
	 tWrf08UYusnn9wTpeSE1td4SQW+Q5WEAzf1oe+h5TI7VSUw/iJ5dsRuDKPSZWGKchH
	 tt5zoEaLMVupe7Ce0dBlom0+0uvHm4sMmqLgm8VVQN7HBnm6eRmZbBgBnsPIrZHL2F
	 WsPH5B7yBg+Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 15/20] can: rcar_canfd: change the initializing flow
 for clocks and resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260729102802.505168-16-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-16-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:56 +0000
Message-Id: <20260730102957.50B9D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `rcar_canfd_global_init()` fails, `rcar_canfd_probe()` incorrec=
tly calls `rcar_canfd_global_deinit()`, causing a kernel panic from accessi=
ng registers with disabled clocks, followed by a double-disable of clocks a=
nd double-assertion of resets.
- [High] If `register_candev()` fails during channel probe, the network dev=
ice is freed, but the global context retains a dangling pointer to it, whic=
h is subsequently dereferenced and double-freed during the driver probe err=
or teardown.
--

--- Patch [15]: [PATCH net 15/20] can: rcar_canfd: change the initializing =
flow for clocks and resets ---
commit 4a859a221c1b4bd83a846c702809583b08a6af18
Author: Tu Nguyen <tu.nguyen.xg@renesas.com>

can: rcar_canfd: change the initializing flow for clocks and resets

This patch updates the initialization order for clocks and resets to match
the hardware manual, ensuring clocks are supplied before resets are
deasserted. It also updates the teardown path in rcar_canfd_global_deinit()
to mirror this new init ordering.

Link: https://patch.msgid.link/20260625135216.130450-1-biju.das.jz@bp.renes=
as.com

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -2068,14 +2068,14 @@ static int rcar_canfd_global_init(struct rcar_can=
fd_global *gpriv)
> =20
>  fail_mode:
>  	rcar_canfd_disable_global_interrupts(gpriv);
[ ... ]
> +fail_ram_clk:
> +	clk_disable_unprepare(gpriv->clk_ram);
> +fail_clk:
> +	clk_disable_unprepare(gpriv->clkp);
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the probe error path
cause a panic and double-disable of clocks here?

When rcar_canfd_global_init() fails, it correctly cleans up its state and
disables the clocks. However, in rcar_canfd_probe(), the failure jumps to
the fail_mode label:

rcar_canfd_probe() {
    ...
    err =3D rcar_canfd_global_init(gpriv);
    if (err)
        goto fail_mode;
    ...
fail_mode:
    rcar_canfd_global_deinit(gpriv, false);
    ...
}

Since the clocks were already disabled by the initialization failure path,
calling rcar_canfd_global_deinit() will access hardware registers with
disabled clocks via rcar_canfd_disable_global_interrupts(). Can this trigger
a precise or imprecise external abort? It also looks like it will redundant=
ly
assert the resets and disable the clocks a second time.

[Severity: High]
This is also a pre-existing issue, but could this probe error cleanup seque=
nce
trigger a double-free on a channel probe failure?

In rcar_canfd_channel_probe(), the device pointer is saved to the global
array before registration:

rcar_canfd_channel_probe() {
    ...
    gpriv->ch[priv->channel] =3D priv;
    err =3D register_candev(ndev);
    if (err) {
        ...
        goto fail_candev;
    }
    ...
fail:
    free_candev(ndev);
}

If register_candev() fails, the memory is freed but the dangling pointer
remains in the global array. Back in rcar_canfd_probe(), the error is caught
and rcar_canfd_channel_remove() is called for all channels in the mask. Does
the cleanup loop find this dangling pointer and try to operate on the
already-freed network device, causing a use-after-free and double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D15
