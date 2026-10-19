Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EC4D7D37;
	Mon, 19 Oct 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405477; cv=none; b=LiKnWR9wAEQA13ZolsMYoNPrqTHVAURRUtY4FDnNXT+6+aobkDOkQ4zQoc5F9QMyBSlQo9nnNq+4RezU4HRHSBUFEUnfvF7Et39idUaTvEr5QvPKTNQ5s3dyJi1MrgzKR88gjnoMnKLWeZJVcGyZklMjyFItsUt/xQ3+c1pdN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405477; c=relaxed/simple;
	bh=GPMPY+kQ3Cha9/fJLAJ6lUOWS1m2jWJzHBqL0fup13M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/tzFkz5Gj4PJppb7TpJcZZLGscEdlvjfHF4La6jo37BcYdzrrsKz+K41qiyGzP9mVg3xfgXwhATBqS2JI1+jeUZrRctQ3XRWo4sqo90COBYwNUD2t3EFAVHRbOZPUX6E6Wkz8MHJ32BKBXZFiCulua3OxNpQJc0Jo2uz/WnnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hso6/ckf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hso6/ckf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A9E1F000C4;
	Mon, 19 Oct 2026 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792405476;
	bh=E91DtUbgK5MUC0RbOMDKbAZ4TgBobeht9O9jUXX8XBQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hso6/ckfFMc4C23ZiOqS1niuaRpbrnZ0fMa3OilkBuJrK2DXcBDTZf456t4t0iBTl
	 pc3k7+rCgoeSiHw0sb/q0QjjZCqnGMIyA7JdqYFxHM8BzfQm65/nUa8ccPKkLSUWNc
	 vWNxIwWlqSGM1rAmQtBq9ZHH8RQY3JSiMFHatgX0xUR59UZPeh8kH1Lc7NUxnorqG5
	 DZYhMIlVrzk87wLrKN6WnodcFq9cbEwLYoXCRrWUUUHuPGjbWauGK/dBmKR08L0fRy
	 bzQrldBsDIcwyjUQyzn1CjAUMgHOaCNAG+uFXfjMgq1JelK10nJYiKe0zIx2iST4tc
	 txnHyLuFQFcsQ==
Subject: Re: [PATCH net v4] can: dev: can_fill_info(): don't wake up
 controller if interface is down
From: netdev-bot+sashiko@kernel.org
To: chunyuzhiqiang@yinhe.ht
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, kuba@kernel.org
Date: Mon, 19 Oct 2026 10:24:35 +0000
Message-ID: <179240547538.3135.2010975389384383545@kernel.org>
In-Reply-To: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The patch changes netlink uAPI output for every CAN driver that
  implements do_get_berr_counter: IFLA_CAN_BERR_COUNTER is now left out…

--

can: dev: can_fill_info(): don't wake up controller if interface is down

This adds a netif_running() check to can_get_size() and can_fill_info().
When the interface is down, do_get_berr_counter() is no longer called and
IFLA_CAN_BERR_COUNTER is no longer reported. The check used to be in the
flexcan driver and is now in the CAN core, so it applies to all drivers.

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..b958c04d53db6 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c

[ ... ]

> @@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
>  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
>  
> -	    (priv->do_get_berr_counter &&
> +	    (priv->do_get_berr_counter && netif_running(dev) &&
>  	     !priv->do_get_berr_counter(dev, &bec) &&
>  	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||

[Severity: High]
Is this fix complete? Later in the same expression, can_fill_info() calls
can_tdc_fill_info() for IFLA_CAN_TDC and IFLA_CAN_XL_TDC. That path can
still read controller registers while the interface is down:

drivers/net/can/dev/netlink.c:can_tdc_fill_info() {
    ...
	if (tdc_is_enabled) {
		...
		} else if (dbt_params->do_get_auto_tdcv) {
			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
		}
    ...
}

Nothing on this path checks netif_running().

On Xilinx CAN-FD, xcan_get_auto_tdcv() reads XCAN_SR without taking a
runtime PM reference. By contrast, xcan_get_berr_counter() calls
pm_runtime_get_sync() before it reads anything:

drivers/net/can/xilinx_can.c:xcan_get_auto_tdcv() {
	...
	*tdcv = FIELD_GET(XCAN_SR_TDCV_MASK, priv->read_reg(priv, XCAN_SR_OFFSET));
	...
}

After probe, or after xcan_close() calls pm_runtime_put(), the device is
runtime suspended. At that point xcan_runtime_suspend() has disabled bus_clk
and can_clk. xcan_close() does not clear ctrlmode, so TDC_AUTO stays set
after every ifdown.

TDC_AUTO can also be turned on while the interface is down. For example,
"ip link set canX type can bitrate ... dbitrate ... fd on" goes through
can_calc_tdco(), which enables TDC_AUTO when the driver supports it. After
that, the RTM_NEWLINK notification or an unprivileged "ip -d link show"
would end up in:

can_fill_info()
  can_tdc_fill_info()
    xcan_get_auto_tdcv()
      priv->read_reg(priv, XCAN_SR_OFFSET)

and the read happens with the register clock gated. Depending on the SoC,
this either returns garbage or causes a bus stall or external abort.
rcar_canfd_get_auto_tdcv() also does a live readl() of cfdsts from this
path, whatever the interface state.

The commit message says "This fixes a generic logic problem that exists on
all platforms". Given that, should the do_get_auto_tdcv() readback in
can_tdc_fill_info() also be gated on netif_running()? Alternatively, should
xcan_get_auto_tdcv() take a runtime PM reference?

[Severity: Low]
This also changes what userspace sees for every driver that implements
do_get_berr_counter(). Together with the matching change in can_get_size(),
IFLA_CAN_BERR_COUNTER is now left out of RTM_GETLINK and RTM_NEWLINK
messages whenever the interface is down. As a result, "ip -details link
show" no longer prints berr-counter for a down interface.

Before this patch the attribute was always present:

- flexcan, xilinx_can and c_can woke the device and reported the real
  counters.
- m_can_get_berr_counter() and mcp251xfd_get_berr_counter() returned 0 with
  zeroed counters when the interface was not up:

drivers/net/can/m_can/m_can.c:m_can_get_berr_counter() {
    ...
	if (!(dev->flags & IFF_UP))
		return 0;
    ...
}

The netlink path can no longer reach these driver-level IFF_UP checks.

The commit named in Fixes:, ec56acfef2af1, was added so that userspace could
call flexcan_get_berr_counter() even while the interface was down. This
patch reverses that behaviour rather than fixing a defect in it, and it is
tagged for stable.

Could the commit message say that IFLA_CAN_BERR_COUNTER is no longer
reported for down interfaces, and explain why that change is acceptable for
stable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018101744.93657-1-chunyuzhiqiang%40yinhe.ht
