Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E3569F2B
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710420; cv=none; b=umw9cBWKLYveYGEtBs7iwHj7ZQXy2fudeluKn0swD/XjAGh1b/jelnvjSge/cwF9BA2CzdMieJQ4tRDYNTlfcerOgOOHWEGJiB3Ykc0h7JvI0gmABWKa8b+9S3Avb4X2xE2v/S/WMtn5OUAkwxAuujMGQ1PeqwalAM8PfqfhaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710420; c=relaxed/simple;
	bh=X/lc7pBUDm+RGWnYW+pAxsnc47sD06cH5dZX2WqwjK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pi1Z6bsH537MdrJasUYkeiGzdX9DWKHdoz5jysl9SqspG31hqcI3UhFUPVfwAv9UGyUn2f+dQPjXgBQ50EtIDGQdaBpA0fMWy6+wbed+J31QrksU3j56vvdkJ0Xmw8q7l3ftZG562hcXJ/KAZsaTfqCZQzDkW06NG2HUrTuMGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHMM/57W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHMM/57W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E721F00893;
	Tue, 29 Sep 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710417;
	bh=3d2DfzLC7GsbIdyppjF5aNI8H20VEb8+BrVjy0QB2wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHMM/57WCV1ntwTz5z2lTjHgPBXO9orsUgqbCZHRWHOOdy0ucow54axEH3LnHhPiE
	 V7ZT/vPwDahU994tnBuCIgz2btEuwTmfNwlpI8tecJJGJdp1HBFb7KwNdk4AhRKQGg
	 pExt2UPbdQHV3MiwViRq25NWW3I5RPcYl2rKMxNin0+C9NqArqyNCa+9gAtdYcHNXY
	 QmXQg4D9goUyay3YBoEC2UlvvlqQyY0X5f9hy8awFS/D8H9+CjTxH+l+DZjeuEH8FR
	 R449bLb4ut0oJLSr0dAlWgLPXLbRVvpqR8xXMh02XsPc48rM010n02HvbOpEhlW8Hs
	 LxAQaiVRxhTJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix
 suspend deinit() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260928193312.553632-13-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-13-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:33:36 +0000
Message-Id: <20260929193336.D5E721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] can: m_can: data race on active_interrupts between suspend error p=
ath and ISR
- [Medium] can: tcan4x5x: unbalanced enable_irq_wake() when m_can_class_sus=
pend() fails
- [Medium] can: m_can: polling hrtimer is permanently disabled on suspend f=
ailure
--

commit c427425150087d727cfdd3220f1be90e0a87c37e
Author: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

can: m_can: m_can_class_suspend(): fix suspend deinit() error path

This commit modifies m_can_class_suspend() to restore the device to its
previous state and return an error if deinit() fails. Previously, a
deinit() failure would return an error but not restore the interface.

Link: https://patch.msgid.link/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-=
1-e24fa70c754e@baylibre.com

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16f80607e150e..91a0c5eca260c 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2612,8 +2612,14 @@ int m_can_class_suspend(struct device *dev)
>  			hrtimer_cancel(&cdev->hrtimer);
>  			m_can_write(cdev, M_CAN_IE, IR_RF0N);
> =20
> -			if (cdev->ops->deinit)
> +			if (cdev->ops->deinit) {
>  				ret =3D cdev->ops->deinit(cdev);
> +				if (ret) {
> +					netdev_err(cdev->net, "failed to deinit device while suspending %pe=
\n",
> +						   ERR_PTR(ret));
> +					goto err_restore_interface;
> +				}
> +			}

[Severity: Medium]
Will this error return cause issues for callers that blindly return the res=
ult
without cleaning up on error?

For example, in drivers/net/can/m_can/tcan4x5x-core.c:tcan4x5x_suspend():

    if (cdev->pm_wake_source)
        enable_irq_wake(spi->irq);

    return m_can_class_suspend(dev);

If m_can_class_suspend() returns an error here, the PM core aborts the syst=
em
suspend and skips calling tcan4x5x_resume() for this device. Does this leave
the IRQ wake_depth counter unbalanced since disable_irq_wake() is never
called, potentially triggering a WARN_ON in the IRQ core and breaking system
wakeup functionality?

[ ... ]

> +	return 0;
> +
> +err_restore_interface:
> +	if (netif_running(ndev)) {
> +		if (cdev->pm_wake_source) {
> +			/* Enable interrupts that trigger immediately if
> +			 * something is there and keep the hrtimer off
> +			 */
> +			cdev->active_interrupts |=3D IR_RF0N | IR_TEFN;

[Severity: High]
Can this read-modify-write operation corrupt the software-cached interrupt =
mask
cdev->active_interrupts?

Because suspend_device_irqs() is not called by the PM core until the
suspend_late phase, hardware interrupts are still fully enabled here (and
IR_RF0N was just explicitly re-enabled earlier in this function).

If a hardware interrupt fires concurrently, m_can_isr() runs and calls
m_can_interrupt_enable(), which performs an unprotected assignment:

drivers/net/can/m_can/m_can.c:m_can_interrupt_enable() {
    ...
    cdev->active_interrupts =3D interrupts;
    ...
}

Will this concurrent modification result in a data race, leading to permane=
nt
misconfiguration of the hardware M_CAN_IE register (such as permanently lost
RX/TX interrupts)?

> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
> +		}
> +		netif_device_attach(ndev);
> +		netif_start_queue(ndev);
> +	}
> +
>  	return ret;
>  }

[Severity: Medium]
Does this error path need to restart the polling hrtimer?

If a device operates in polling mode (!cdev->net->irq) but has wakeup-source
set in DT, cdev->pm_wake_source is true.

Earlier in this function, the hrtimer is cancelled:

    hrtimer_cancel(&cdev->hrtimer);

However, this error path restores the network queues but completely fails to
restart the hrtimer. Will this cause the CAN interface to completely stall
with no TX/RX processing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928193312.5536=
32-1-mkl@pengutronix.de?part=3D12
