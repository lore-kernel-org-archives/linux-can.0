Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9537F328
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900943; cv=none; b=cq/t0SMl4vLit/Qiel1486VencFTTS/cKk4Qg0PNvoebB5ZQLL3ji8N9JKmr7XE/FusMnwyQwmdycdvTWON16yhzjODsxnaQ4TuNCB0HOiirRHxaWrKtPjGD2T3kAYUFeB2ruyWj3kDyRyqCy3Nzy68Nc+1V2dHOjVB1vMp6Ppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900943; c=relaxed/simple;
	bh=HgiI2EAWZ8xZY0jM+i/yOOVh/aOmmja9Eb9GAO6dPHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qn7C2kX9EdoLd8pRDJBWyxg+xP0SDm5t0vnxdniL8WShIJZ0KfPZkMDLmaF8PFqxVQVdv3p6mocU0mJ9KSy2PrUar/l6dEgGucO8QLaHxMSm2+gRiQq8HdHNjanrN7eamTOesC6hc2MddNioOi03mUH099ZwgilOzUosxX/rFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSEglVKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSEglVKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2CC1F000E9;
	Fri, 28 Aug 2026 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787900941;
	bh=gyOxtcfM5AXTvM2HwludKPLWN5EDEvKvXVhHrQBK+L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSEglVKtFrMPd1DBqTvr4zg3KFnKQ/N0xnkU2zol3EHt3hPRnyIi0cRP7m1rewRc/
	 h+Y9jiwU1Tpy9b24ySumHO5EBjei9/XmTgQc+EeSfVnu7i+ToPCrCuhUjdVmCZooDP
	 Wq2kuVKZr0JL/oK0yfpTvHD9/aNrrRNLKDR5EViZEZTqXcfvVelY5kRThYkV5RaB5t
	 J15gVPSpMl6ken4R8Fj4nPQrdK0/8t+DEkU8egmzwSxMDybehelqfydACGpcPrAy9A
	 7D5UllDvLfTjCF6tdRxj9GMcBKYxCVmcU197W4gusvBws34LYQW+Ty2GAV1qHxtQz2
	 rWp4QtpCtX8nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] can: j1939: cancel all pending ECUs on device
 stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260828064621.91364-2-dmantipov@yandex.ru>
References: <20260828064621.91364-1-dmantipov@yandex.ru>
 <20260828064621.91364-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 07:09:00 +0000
Message-Id: <20260828070901.3C2CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditional cancellation of ECU timers in j1939_netdev_stop() br=
eaks address claiming for all sockets.
- [High] Race condition allows ECU and priv memory leak because timers are =
cancelled before the RX path is disabled.

Pre-existing issues:
- [High] Deadlock in __j1939_ecu_work due to acquiring write_lock(&priv->lo=
ck) without disabling softirqs.
- [High] Module unload while asynchronous ECU workqueue items are still pen=
ding causes an Execution-After-Free panic.
--

commit 5eb4b9f58ccbd7c9b7e110c01dfe98b7a95acee8
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: cancel all pending ECUs on device stop

This commit cancels all pending ECUs in j1939_netdev_stop() to prevent
a situation where a stopped device no longer processes ECUs. This
ensures the ECU and its reference to the j1939_priv structure are
properly freed.

Link: https://syzkaller.appspot.com/bug?extid=3D489e907b2a026a6f5fa0

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..1f68ba8037004 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_devi=
ce *ndev)
> =20
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);
>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);

[Severity: High]
Does unconditionally cancelling all ECU timers here break address claiming
for all sockets?

When any single socket closes, it invokes j1939_netdev_stop(), which
unconditionally cancels all ECU timers for the shared priv structure.

Does this forcefully abort pending address claim timers for every other
active socket on the interface, leaving those ECUs unmapped permanently?

Should the timer cancellation be properly scoped to the destruction of the
last socket in the __j1939_rx_release callback instead?


[Severity: High]
Can this sequence race and cause an ECU memory leak?

If a socket is closed, initiating j1939_netdev_stop(), j1939_ecu_cancel_all=
()
runs. If a new AC frame is received on the bus before __j1939_rx_release()
disables CAN RX, it triggers j1939_ac_process() which starts a new ECU time=
r.

Since j1939_ecu_unmap_all() already ran synchronously during teardown, the
new ECU timer will fire later, taking a reference and leaving the new ECU
permanently unmapped.=20

Does this permanently leak both the ECU and its referenced j1939_priv?

>  	j1939_priv_put(priv);
>  }

[ ... ]


This is a pre-existing issue, but I noticed a potential deadlock here:

    net/can/j1939/bus.c:__j1939_ecu_work() {
        ...
        write_lock(&priv->lock);
        list_del(&ecu->list);
        ...
    }

[Severity: High]
Does acquiring write_lock(&priv->lock) without disabling softirqs cause a
deadlock?

Because write_lock() disables preemption but not softirqs, the workqueue
thread can be preempted by the CAN RX softirq on the same CPU.=20

If a CAN RX interrupt arrives and triggers j1939_ac_process() in softirq
context, it will spin on write_lock_bh(&priv->lock), resulting in a lock
inversion deadlock.=20

Should this use write_lock_bh() instead?


This is a pre-existing issue, but I also noticed a missing synchronization
here:

    net/can/j1939/main.c:j1939_module_exit() {
        can_proto_unregister(&j1939_can_proto);
        unregister_netdevice_notifier(&j1939_netdev_notifier);
    }

[Severity: High]
Can unloading the module while asynchronous ECU workqueue items are still
pending cause an Execution-After-Free panic?

When a socket closes, __j1939_ecu_release defers freeing the ECU via
schedule_work(&ecu->work).=20

Because j1939_module_exit() lacks a flush_scheduled_work() or similar
synchronization call, the module memory can be freed before the workqueue
executes __j1939_ecu_work.=20

Does this crash the kernel when the worker thread branches to the unmapped
function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828064621.9136=
4-1-dmantipov@yandex.ru?part=3D2
