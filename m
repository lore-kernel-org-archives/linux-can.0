Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005F3ED11B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586069; cv=none; b=Ze2G/87mjtT57hS4oPDjMCnZNJ/r2bGkKrV14loOECaZUuW8JVF8fU2EM8lTxrowejCsjD8NF5pthFSx1lrc9XgaaA9qhln/1e88FAcNwKRkhXPzGl974ewx2GZI0MQvx1W5rTaqSC48HQuJc2OCfTHGlq382JYBnOaMywSiMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586069; c=relaxed/simple;
	bh=0LYsjZaPy/d1QC/xmGdGmLnwo0Hm19KBcyOEVsMKdZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBTBxat0qk9RJJz9ite1ClCF4DTGY9S+UXdDAeCOiNgmQHcAC9J8v7uf9nfi/SeGWCUU1NARQvqzBoIoZsCFmKe+/8gfcvnSJxmU74dK/He1ygXC+QVYLsbsB9Z//N+KbXXhdb47EV7PEFF2vuZvgllP3Yun3/2ASwBlbG82Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDWxWjUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDWxWjUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6791F000E9;
	Thu,  9 Jul 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586068;
	bh=QWbQ24ztFiisvH5inF7S81x8cNWT2ASyz1aRNezmoM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDWxWjUUOusuVtwKBN3/jO+NEInyZHu92FkZqe5aGFp0ReLZGHEhIV59KriaxL6w0
	 HA00GBm3XOL66XtqtWyOUwJfh3o7td5/ARO4Ad+kkvJjIOIEi75YP0xuOdF7hRjGES
	 jpCPISUDAAOnGMAgTnW1BTEShz9vcHiySv1iS9IOZmkTs2V0mfu14ru9DDrqDWyE3G
	 WZBhvfMezR//lrFJSwcighOQwT48jM2fuh4iCyzwRrhqNDik3n0T1ttaCPvozK1IzV
	 vHSxXgTApsAIPwzWMbUIoFJFtJQhiVXts3BwYLIlOdenrOyk17uYTCGnLzy5eoOPM+
	 tbB6sYxB3op6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/10] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v9-1-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-1-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:34:27 +0000
Message-Id: <20260709083428.1B6791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Module exit triggers a kmem_cache_destroy warning because the prot=
ocol slab cache is destroyed before the deferred workqueue frees the remain=
ing sockets.
--

--- Patch [1]: [PATCH v9 01/10] can: bcm: defer rx_op deallocation to workq=
ueue to fix thrtimer UAF ---
commit d847f243125a944d43b2a6970166b528eea27549
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free condition in the broadcast manager=20
rx operation teardown. It moves the timer cancellation and memory deallocat=
ion=20
to a dedicated unbound workqueue, and ensures the socket reference is held=
=20
until the deferred work executes safely in process context.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1869,6 +1898,8 @@ static void __exit bcm_module_exit(void)
>  	can_proto_unregister(&bcm_can_proto);
>  	unregister_netdevice_notifier(&canbcm_notifier);
>  	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>  }

[Severity: High]
Will this sequence trigger a kmem_cache_destroy warning on module unload?

Since bcm_module_exit() calls can_proto_unregister() before
destroy_workqueue(), the protocol slab cache is destroyed while deferred
work items that release sockets back to the cache might still be pending in
bcm_wq.

Should destroy_workqueue() be called before can_proto_unregister() to
ensure all pending socket frees are completed prior to the protocol slab
cache destruction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D1
