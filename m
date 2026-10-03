Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A572D5C7A
	for <linux-can@vger.kernel.org>; Sat,  3 Oct 2026 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791006518; cv=none; b=r+SavEFuC3tQsKUr2nGVEHREfba97caP1ZmBeacqq7fyhBgv/lZ8CY3R0O0bmakF+TjOj+XWNv/GK/B6VQ3kW7zuKfly1QicnO+M7ot8l0hM0ICkWuin7oeY2nFA8diWBuWpGPfzvU8qfKpv/n8pnytD2VRiw5nq1AjZ65HccnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791006518; c=relaxed/simple;
	bh=HHF21otj/GL5tDM4JutFVfU8dGmp9Rj2UeG8+pu9Zz8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3/g0RHN1FgAIUR44nKS4hTGQK3nwABHeUZpjvFC5o8WjArHsJXOcTDUkKvldJdzArGx1WYsLW8qsENlJ8fFOQKtmt4NBQerJ7YPaPrmVQXNl/HbSEgp4BKamnitgC4mFDHxYlqSQffqgQY5ONq/lSPGljPszB5TzSZEgnYBzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGqq/JF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGqq/JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2775C1F0089C;
	Sat,  3 Oct 2026 05:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791006516;
	bh=1rU5SKWg2kcrQKBM/WFtj4QkpEXR36VZJqdLIc28MwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MkGqq/JF7kVgCk89EpYzdhgBYBZ+ctU9GbSAFZGwk534+0x+EktzHoP/JMMjbghgs
	 SuhhpFx2HOjMJc021rRO9dRTJxGN/WpxN/BONN4CBbPpiQgcjPnN6Waa7VSx5N/rar
	 I6COo9tzjHOshfd9lNpEoRK+RjjV1MptlrE4QNScTLS9jMq5YGOMxMdDGiFY+/1JKE
	 mSqKqRh3f/yIX6P1FnpOownm0tNTNYnzTzurPuIsA2nWuTvgEyKPaW4LT/lmK1Gxfk
	 IGzkmQjLPOv1PZ2AIUwYP8Q0efgNmQqYgAofR0hrRqzvufNOvtHuIixDxm+3Jo65b8
	 hgYlY48R9BFjQ==
Subject: Re: [PATCH v5 2/3] can: convert unreliable ARPHRD_CAN type checks to
 robust can_get_ml_priv()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, stable@kernel.org, o.rempel@pengutronix.de,
 kuba@kernel.org
Date: Sat, 03 Oct 2026 05:48:35 +0000
Message-ID: <179100651569.1406898.574032658944604939@kernel.org>
In-Reply-To: <20260929163424.16382-3-socketcan@hartkopp.net>
References: <20260929163424.16382-3-socketcan@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not say what user-visible bug this
  stable-tagged patch fixes.

--

can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

This patch replaces the dev->type != ARPHRD_CAN checks in af_can, bcm, gw,
isotp and raw with can_get_ml_priv() checks. The stated reason is that
TUNSETLINK lets a down TUN/TAP device change its type to ARPHRD_CAN while
dev->ml_priv stays NULL.

> This has been used directly by the referenced commit in the CAN specific
> j1939 and proc code but not in the other parts of the CAN subsystem.

[Severity: Low]
Is the "not in the other parts of the CAN subsystem" part accurate?

af_can.c already checks can_get_ml_priv() in can_rx_register(), which was
added by commit 8aa59e355949 ("can: af_can: fix NULL pointer dereference
in can_rx_register()"). It is also checked in can_rcv(), canfd_rcv() and
canxl_rcv(). The removed lines in this diff show it:

    if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
        return -ENODEV;

> Instead of checking dev->type being the unreliable ARPHRD_CAN value convert
> the missing "valid CAN devices" checks to can_get_ml_priv().

The patch is tagged for stable, but the message reads like a cleanup.
Could it also describe the user-visible bug being fixed?

Before this patch, a NULL pointer dereference looks reachable through
CAN_ISOTP. isotp_bind() only checked dev->type, so it accepted a TUN
device whose type had been set to ARPHRD_CAN. It also ignores the
-ENODEV that can_rx_register() returns:

    if (isotp_register_rxid(so))
        can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
                        isotp_rcv, sk, "isotp", sk);
    ...
    so->bound = 1;
    ...
    so->dev = dev;

On close(), isotp_release() then calls can_rx_unregister() on so->dev.
Before this patch, can_rx_unregister() only checked the type:

    if (dev && dev->type != ARPHRD_CAN)
        return;

So it carried on into can_dev_rcv_lists_find(), which has no NULL check:

    struct can_ml_priv *can_ml = can_get_ml_priv(dev);
    return &can_ml->dev_rcv_lists;

dev_rcv_lists is the first member of struct can_ml_priv, so this returns
NULL. The call chain is:

close()
  isotp_release()
    can_rx_unregister()
      can_dev_rcv_lists_find()     <- returns NULL
      can_rcv_list_find()
      hlist_for_each_entry_rcu()   <- NULL dereference

isotp_notify() for NETDEV_UNREGISTER reaches the same path. Creating the
TUN device needs CAP_NET_ADMIN, and an unprivileged user can get that
inside a user namespace.

Could the message mention the crash, the affected protocol, and the
trigger (TUNSETLINK to ARPHRD_CAN, then binding a CAN_ISOTP socket)? That
would make it clear to stable backporters that this is a crash fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net
