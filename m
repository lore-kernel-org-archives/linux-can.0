Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2833ADB3
	for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036037; cv=none; b=qRN1aHFWoI7E71/sK/USnkvsw5FN6req1QwdZkMY6udXgk1ktF2kff7cVDY0/ISegq0mPHoJQsMMNMAwkAHj5QjpNpAfUM+o31yPHXEGaFR8pMN7Ft9o3KM8GYGsfA5JQGtxHuJVtFLf/8BS72xv6ei3RbFs9pUVV2H8bfpv+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036037; c=relaxed/simple;
	bh=Cta+ohfuvrRxhMB3h+l+r29PYyRIhBF3sNkyBpfvNP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UzrGs70nyO6uWWMDpX/qdgW7S9CDZ134unmuyMQZinFOaBhcrnTwkjZQ3PNMKEG3YOtyiaGqqRUIaGQrFKTLFqrHik0maIdlskERf5IC2MZUUQ6bws02UBbDseePQyk12tyF9Sp6JYu/5rpenw4qcTeIl2DOUpIyq01RchZ51Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Our3SUsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Our3SUsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F761F000E9;
	Tue, 18 Aug 2026 06:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036035;
	bh=xgQS0aOASbAdV+2hKX8RDaS9yZlIOENpvhObnOimZSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Our3SUsuz9jYP0kvzRGdBOouzV3i6mBPxXju2ZJb6ymjaELOAJxkAQ8m84Y0Njuvn
	 T60YsDBzy2ymPQL234ThzY0RpFE+w89ROtL2+aU6OdRrXdz2pwESLIJrX/yYvuYUyM
	 RPHc+0pPGdGl1yVGg90Ig9DGyQQSlAakGEyX5nsoW6bObdT7aM3yhZvDLRH5POZqQb
	 P5DGF2cvaka9nJ99GgAchttwOmI3NkCKHGj5m3Lne/RfvqW2/UKQsO7GzUqoWfnjs2
	 BkfuBI6+cowoBuxUVVDGNu5XamrTtiuXyDiJ67HSFv56cQ6OzYtscPlwaGU755SS6O
	 kYSiv94tZslqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll
 timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260818063832.383829-1-fanwu01@zju.edu.cn>
References: <20260818063832.383829-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:53:54 +0000
Message-Id: <20260818065355.56F761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver uses non-synchronous `timer_delete()` when stopping the=
 device or initializing the bus, allowing the timer callback to execute con=
currently with hardware teardown/startup.
- [High] The sequence counter `can->cmd_seq` is incremented concurrently fr=
om hardirq, softirq, and process contexts without any synchronization or at=
omic types, leading to data corruption.
- [Medium] Error handling in `kvaser_pciefd_setup_can_ctrls()` calls `kvase=
r_pciefd_devlink_port_unregister()` on a port that failed to register, trig=
gering a debug splat on uninitialized delayed work.
--

--- Patch [1]: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll t=
imer ---
commit b386356ff6c7a43deaac5d1df270183cf372b998
Author: Fan Wu <fanwu01@zju.edu.cn>

can: kvaser_pciefd: fix use-after-free in bec poll timer

This patch replaces timer_delete() with timer_shutdown_sync() during
device teardown to prevent a use-after-free if the bec poll timer is
concurrently re-arming or running. It also adds the timer shutdown to
the probe error path.

> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers=
/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> index d8c9bfb202304..a0597db720864 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> @@ -1739,6 +1739,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct=
 kvaser_pciefd *pcie)
>  			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
>  			kvaser_pciefd_pwm_stop(can);
>  			kvaser_pciefd_devlink_port_unregister(can);

[Severity: Medium]
This is a pre-existing issue, but since we are modifying this error path,
could this unregister call trigger a debug splat on uninitialized delayed
work?

If kvaser_pciefd_devlink_port_register() fails in
kvaser_pciefd_setup_can_ctrls():

kvaser_pciefd_setup_can_ctrls() {
    ...
    pcie->can[i] =3D can;
    kvaser_pciefd_pwm_start(can);
    ret =3D kvaser_pciefd_devlink_port_register(can);
    if (ret)
        goto err;
    ...
err:
    kvaser_pciefd_teardown_can_ctrls(pcie);
}

Since pcie->can[i] is already populated, teardown unconditionally calls
kvaser_pciefd_devlink_port_unregister(can) on the failed port.

> +			timer_shutdown_sync(&can->bec_poll_timer);
>  			free_candev(can->can.dev);
>  		}
>  	}
> @@ -1879,7 +1880,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pd=
ev)
>  		struct kvaser_pciefd_can *can =3D pcie->can[i];
> =20
>  		unregister_candev(can->can.dev);
> -		timer_delete(&can->bec_poll_timer);
> +		timer_shutdown_sync(&can->bec_poll_timer);

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing the
timer cancellation here, are there similar concurrent execution risks in
other parts of the driver?

The driver still uses non-synchronous timer_delete() when initializing
the bus and stopping the device:

kvaser_pciefd_bus_on() {
    ...
    timer_delete(&can->bec_poll_timer);
    ...
}

kvaser_pciefd_stop() {
    ...
    timer_delete(&can->bec_poll_timer);
    ...
}

If the interface is brought down (triggering kvaser_pciefd_stop) while
polling is active, could the callback still execute concurrently and
re-arm the timer or modify hardware registers out of order?

>  		kvaser_pciefd_pwm_stop(can);
>  		kvaser_pciefd_devlink_port_unregister(can);
>  	}

[ ... ]

[Severity: High]
This is also a pre-existing issue not directly related to the lines changed
in this patch, but does the sequence counter increment in
kvaser_pciefd_send_kcan_cmd() need synchronization?

kvaser_pciefd_send_kcan_cmd() {
    ...
    FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq),
    ...
}

If a hardware status packet arrives (triggering
kvaser_pciefd_handle_status_packet() from the hardirq handler) while
kvaser_pciefd_bec_poll_timer() is polling from softirq, both invoke
kvaser_pciefd_send_kcan_cmd().

Since they increment can->cmd_seq without taking can->lock, could
concurrent read-modify-write operations lose increments or tear,
resulting in mismatched responses and state machine hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818063832.3838=
29-1-fanwu01@zju.edu.cn?part=3D1
