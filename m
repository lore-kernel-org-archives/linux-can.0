Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F23B27FA
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407389; cv=none; b=AxEYUzbdFWsCWx6jKa6/wg2x7ruLeW6h9j98m5/KVZHzPgP2jPPkVMBwLz8Jmp5A9zX2CQOJEhuKiCUoVlpjuYEiFTHPj/3KbMPv7xXwgQUYb0LrKMIW3NHm28UBllPTYrcNXTsJ5DOXzTigLvDlZBggGXa6PDvYYB7LOLfjkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407389; c=relaxed/simple;
	bh=yXm31xqtdOB+hsTMz2WRiJzrATst7JbHXWMP718l6AI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OStXvjh4qzqOlv8FUMTnhZ6yEmlFzOwp/YWmfUXW3N6DQWiGb3Q10QQHHCyCwoS0T/uSPPQtxc31xqCZyD1qnP0XaGcY4GoJjE9Hm8d0YAPzDvAw6O5An/eeqomXQhccNUW67w5BL07umWUTpMQYYBK2oFaevuTf/H5VKWmoAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzga0r/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzga0r/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0C1F00A3A;
	Thu, 30 Jul 2026 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407387;
	bh=2PivC2tcomYKuSVXw65LvFKTPg3XVNskQOreYAeeQk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzga0r/62IB0Daw0fMYMHSVKoSLVagPx1r5zT2i4Ljlv2kacQPYw0zpCsq4OomkT3
	 qH61IUSneegHTHMHOCLbD5qyitVrRDl1WawQpWJYR9qslMKXCPlvCspJb+lrGBnhvs
	 yRd/Bln1WklO2FwTb8ngJw1CRT1Jq8UkPhH6z+LZaxochbzdui+8xb7ItCvy6bljFP
	 LPgh/jKGyEy5cnFqcjt32An0PKkWb1+yCdbcwQnBImRrj7O/SO8R5e0WHQnTMuiZwk
	 HhFtOScUuqtCJ3hmyJtBNTMmo4jERqpQLNpxrE7Q0rD2VVqvbufDmrrUn3g8YbwSF/
	 0EgkeSaVfbU9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 01/20] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260729102802.505168-2-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:47 +0000
Message-Id: <20260730102947.8ED0C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Teardown race in j1939_ecu_timer_handler causes j1939_priv and net=
_device leak.
- [High] __j1939_ecu_release() modifies the priv->ecus list via list_del(&e=
cu->list) without holding priv->lock, causing list corruption if the last r=
eference is dropped concurrently.
--

--- Patch [1]: [PATCH net 01/20] can: j1939: use netdevice_tracker for j193=
9_{priv,session,ecu} tracking ---
commit 65a0f5e1134c318a0874d847f3b02716f80d26b7
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

To investigate a dev_hold()/dev_put() imbalance in j1939_priv management,
this commit adds netdevice_tracker support to j1939_{priv,session,ecu}.
This helps debug refcount leaks reported by syzbot when unregistering
vcan0 devices.

Link: https://patch.msgid.link/20260728055835.1151785-2-o.rempel@pengutroni=
x.de

> This refcount leak in j1939_priv might be caused by a refcount leak in
> j1939_{session,ecu} because j1939_{session,ecu} holds a ref on j1939_priv.
> For further investigation using upstream kernels, enable netdevice_tracker
> in j1939_{priv,session,ecu} management.

[Severity: High]
This is a pre-existing issue, but regarding the syzbot report about the
unregister_netdevice hang and the refcount leak mentioned above:

Could this leak be caused by a teardown race involving
j1939_ecu_timer_handler()?

When the interface is brought down, __j1939_rx_release() unmaps existing
ECUs via j1939_ecu_unmap_all(), but does it cancel the pending ac_timer
hrtimers?

If the timer fires after teardown, j1939_ecu_timer_handler() unconditionally
maps the ECU and takes a reference:

	j1939_ecu_map_locked(ecu);

Since the unmap phase has already passed, the ECU permanently holds a
reference to priv, which holds a reference to the net_device, preventing
unregister_netdevice from completing.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index dc374286eeb6e..cdc3c0a719379 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	list_del(&ecu->list);

[Severity: High]
This is a pre-existing issue, but does __j1939_ecu_release() safely modify
priv->ecus without holding priv->lock here?

If j1939_ecu_put() is called from lockless contexts like j1939_ac_recv() or
j1939_ac_fixup(), and another thread drops the penultimate reference while
holding priv->lock, could the final reference be dropped in the lockless
context?

This would cause list_del() to modify the list concurrently with other
threads iterating or modifying it.

> +	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D1
