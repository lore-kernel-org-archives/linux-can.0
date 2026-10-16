Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F83422E2E
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145622; cv=none; b=WZy14e//AOpK47EMfoPpOOWaV4TJROb4ZVETYN2E8XlMjcn46LmaWpGN/6zm2xlZfyDzZBBjLUzEppJlWAebupsmK518lidkwL08a4FbmNTst2lMBhhwwBKVEcWDAf5M0ZjPbap7hugdNmNerdTn6mkB+JDJLQ8Ie7vEGDk0rjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145622; c=relaxed/simple;
	bh=nzhIyYzlQ/VhoGKD9oHrNcFNwzYr7sPxid7AWxlGea0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DajSzB1EkFXH5gQDjhKL9SkBh8Pz5Tijyfer27OuTuU6bVJdA+bEbPkhu9EcXX6OmjA+lHQVddMVS2FABMQUb9NkGau5fQ4099nKnMuitnp6XDGPboPL7vXZwjyMz+r7NRvj7iLM1eVMZxFOizlDKlm8B1tk24JTCiQrqH9Fkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaPIRss/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaPIRss/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CC11F000C4;
	Fri, 16 Oct 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145620;
	bh=TCm6fg9T2ov4eMygTActNZPk/eSscG21GBHaIaKf6Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaPIRss/mrMmNj+ZgRw/jeu2vbErv8TmwaUWtx1BSBbjWhlIxhQZPftqhMZ343ueL
	 8kXf9pSchv7zAY0WoFk/tKRU5Qb7bSXBF3FdHolJ4IxlwG5mdc3RdgSSPtkWe3I4Ce
	 iX0rFX+BwYzoeaLn5jRBRCyLPfbn4HPmyXPq0zEhlwKb7yGDTrBzACQemWvlE1Quwn
	 +e+o2pZjc7qQHbmYHuQf7Sikmn0gKq1X7tbujxKmTxHaq3U4bnvWJD0O23IrVbRnq/
	 1+Y8x7OlM6iUxvzPV/+bwQEW3WjGPD0tkP+9YoJU2L8JWnRaC8l2TjgXFGuweRygMN
	 GufMULKEgeUKA==
Message-ID: <sashiko-outbox-174132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: m_can: Fix suspend deinit() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFya3VzIFNjaG5laWRlci1QYXJnbWFubiAoVEkp?= <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-1-7efa2b172cce@baylibre.com>
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-1-7efa2b172cce@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:13:39 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: m_can: suspend error path permanently stalls polling mode
- [Medium] can: m_can: race in suspend error path leads to permanent rx sta=
ll
--

commit 483c34ecb4b606d88b805473f5b905d713840725
Author: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

can: m_can: Fix suspend deinit() error path

When suspending mcan, deinit is called and its return value is returned,
but nothing is restored. This commit adds an error path to restore the
device to its previous state, including restarting the coalescing hrtimer.

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16f80607e150e..02a95a769a784 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
[ ... ]
> @@ -2625,6 +2631,23 @@ int m_can_class_suspend(struct device *dev)
>  	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>  		pinctrl_pm_select_sleep_state(dev);
> =20
> +	return 0;
> +
> +err_pm_wake_source:
> +	if (netif_running(ndev)) {
> +		if (cdev->pm_wake_source) {
> +			bool coalescing_active =3D (cdev->active_interrupts & (IR_RF0N | IR_T=
EFN))
> +						 !=3D (IR_RF0N | IR_TEFN);

[Severity: High]
If the device operates in polling mode (!cdev->net->irq) and acts as a wake
source (cdev->pm_wake_source =3D=3D true), does this error path permanently
stall the polling mode?

The tcan4x5x driver allows pm_wake_source to be true even if spi->irq is 0
(polling mode). In polling mode, all active interrupt bits (IR_ALL_INT) are
retained, so coalescing_active will evaluate to false. As a result, the
polling timer cancelled earlier in suspend will never be restarted here.

Additionally, if the timer were to be restarted, would using the coalescing
parameters (cdev->irq_timer_wait, HRTIMER_MODE_REL) be correct, or should it
use the polling parameters (HRTIMER_POLL_INTERVAL_MS,
HRTIMER_MODE_REL_PINNED)?

> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);

[Severity: Medium]
Could this non-atomic read and write introduce a race condition leading to
a permanent RX stall?

Earlier in m_can_class_suspend(), m_can_write(cdev, M_CAN_IE, IR_RF0N)
enables RX wakeups, which allows a concurrent threaded ISR to run if an
RX packet arrives.

If the ISR coalescing timer expires exactly between evaluating
coalescing_active (reading cdev->active_interrupts) and writing it to
M_CAN_IE here, the hardware could be overwritten with a stale mask that
leaves RX disabled.

If the error path then restarts the timer, the ISR's next execution
might see the software state already has RX enabled and skip updating the
hardware, leaving the hardware and software states permanently out of sync.

> +			if (coalescing_active)
> +				hrtimer_start(&cdev->hrtimer,
> +					      cdev->irq_timer_wait,
> +					      HRTIMER_MODE_REL);
> +		}
> +		netif_device_attach(ndev);
> +		netif_start_queue(ndev);
> +	}
> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-v7-3-topic=
-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com?part=3D1
