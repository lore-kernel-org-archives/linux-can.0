Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930C312825
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026134; cv=none; b=lHMs30tSUicddLFDkuIDFGKpstsmfpEQkIdp7FqxjilCss4lX33HszeYwdXzzfjO8KEwEwRLbcOlqOt+HeldD33M2nfq09TnM9AbwpBWtK8zWbUEu5jGVHKxro4ixlq1/bZax1G6LvzLoHiNKn8l0VZbpPJzOjXoWwIQBF2XRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026134; c=relaxed/simple;
	bh=Ps3ma8RfxomgSWpMekIt0c6i+M0qMdg7RRC0660rxe4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+/GOtuxjWQBwo/4KfB8JHGoP0p1G2aQlGKbWo4NtDewCWVmH/tLb1G7DB/YUzn5I0qbgpprkNoWkA2waOOAaoZXvmjd2pVqQiAhhbnjRFJJx3UbbWPpaJdxAMVMlgPzY6kmaCH4GRnQdTmSLAraI9aYqNoXFddSB96Gxmm4sOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMeWHJW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMeWHJW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50441F000C4;
	Thu, 15 Oct 2026 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792026129;
	bh=NycErCX23eieEx/U78cf8yqiF9YaSUsjfFa22e4Z5pA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CMeWHJW9TV4Tn07/z4k6rtmojRlsXqDsHLWmxx6I8Sb/WxyLpIlgLKJuPyroslnH5
	 i9tuBea/uAK2xzeIBN1NhEL8pvY8EP01fTyULeGffAOrr0Y8Jn6VQ10rUG/NWs7c+V
	 wOhZcsSkzoEwasNiTy0BrK20w6sr4PGhY8qOtKdjtm7qaIyPH45eldKTv2jUtbWdh4
	 wFbWAtLJlfvW/2HWVjMNeGMbMjokUXymkTTitGdcBa5w4eGsEjhVjA5r4ck1it4C4k
	 PLM7aLfyBGW2xfFtKXADpajK14/06ZhU8ppmqDkNREgUXjaCuXF38+Z61EIGcSwpTe
	 MZwrI5FP8tikQ==
Subject: Re: [PATCH can-next] can: raw: take rtnl_lock() before leaving the
 notifier list
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, kuba@kernel.org
Date: Thu, 15 Oct 2026 01:02:08 +0000
Message-ID: <179202612843.1406898.1976844402266899912@kernel.org>
In-Reply-To: <20261013115557.114582-1-socketcan@hartkopp.net>
References: <20261013115557.114582-1-socketcan@hartkopp.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message for raw_release() (net/can/raw.c) says the
  change is meant to "Align raw_release() with the isotp and bcm fixes…

--

can: raw: take rtnl_lock() before leaving the notifier list

This commit moves rtnl_lock() in raw_release() so it runs before the
socket is removed from raw_notifier_list. A concurrent netdev notifier
then can't skip a socket that is being released. Under RTNL,
raw_busy_notifier can't point to the released socket, so the busy-wait
loop is replaced with a WARN_ON_ONCE().

> Align raw_release() with the isotp and bcm fixes for the same window and
> take rtnl_lock() before removing the socket from the notifier list. As
> raw_busy_notifier can not point to the released socket under RTNL,
> replace the busy-wait loop with a WARN_ON_ONCE().

[Severity: Medium]
Which isotp and bcm fixes does this refer to? The message has no commit
ids or Link: tags. In this tree, both of those release paths still look
the way raw_release() looked before this patch.

isotp_release() in net/can/isotp.c still calls list_del() before it takes
RTNL:

net/can/isotp.c:isotp_release() {
    ...
	spin_lock(&isotp_notifier_lock);
	while (isotp_busy_notifier == so) {
		spin_unlock(&isotp_notifier_lock);
		schedule_timeout_uninterruptible(1);
		spin_lock(&isotp_notifier_lock);
	}
	list_del(&so->notifier);
	spin_unlock(&isotp_notifier_lock);

	rtnl_lock();
	lock_sock(sk);
    ...
}

bcm_release() in net/can/bcm.c has the same busy-wait loop. It calls
list_del(&bo->notifier) without holding RTNL at all.

For isotp, this window also seems to matter more than it does for raw.
Suppose dev_change_net_namespace() runs in the window (for example,
ip link set <candev> netns X). isotp_notifier() skips the socket,
because it is already off isotp_notifier_list. isotp_release() then
calls can_rx_unregister() with net = sock_net(sk), and that returns
early once the device has moved:

net/can/af_can.c:can_rx_unregister() {
    ...
	if (dev && !net_eq(net, dev_net(dev)))
		return;
    ...
}

Wouldn't that leave receivers with data == sk on the device's receive
lists after sock_put() frees the socket? raw avoids this only because
raw_release() passes dev_net(ro->dev) instead of sock_net(sk).

Could the commit message name the isotp and bcm commits it relies on?
Alternatively, it could be reworded so it doesn't suggest isotp and bcm
are already fixed for this window. As written, the isotp and bcm
changes that are still needed could be missed in review or stable
backporting.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013115557.114582-1-socketcan%40hartkopp.net
