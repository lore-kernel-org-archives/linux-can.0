Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190710;
	b=Ln2i2fLPhog73PDvYQ7rK1BH0ps4KLxeVuvFkQAyQBcAaeBEsqptDe6o5P4pQDgs+Yow
	 4t+dghOShaCNZuTTShzc0wECHKcW9Cg89/r2XTvWC+l4LZk3JHFGmxgU2WDEAULNM1IV7
	 uDWdm4A4PGbEbZc3s2LDFuRh+PvHQPEYOxuPTkpaaClPaWI7kYk9zniUU+1EOxvnNLmTF
	 sQRELfPjFS2ZHqTKhFejZOQqxqQVgDuXxY3651kHHAeQa2DiQA4CdsddJTxGoJ5KKjpGC
	 Ae7/wCNe2BIM/ruZqaxY3fc/EMmojIDjW/0hrUz160eKOmgmxfiYbG91L8qd/NOTycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190710;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dmly4DUcZXSyqRnYrDP4D8BKGDOU3GhIDD80/iUNNgU=;
	b=LQv9+9KZvmZnra/9bWTWNZwJYufzA+UeFgJHFDQ1XgFPuyU+HlmS5CbPU0NELhHcU6bx
	 zE8TokGOFeDOm0GotLb4TTV6QDAZkRoFod1NP3oHYWlBxddJG6OJLaRK0LC+J+ex2iXq8
	 Qxb9SWN/+sZnQUC2a/zKVTwtqqw5eloGjWH4KaPB6lroKts/VfrsQEwnmHppP+hOKckjg
	 5qNyuAv00KYC5kB6SVWIQZ6LkaMbEH/DpYiVX7ezWQ/ngzWw66WqIyEB99S0+t5QsBtjz
	 h9ebh7Eoq8gxyeO5mZN/wPekS9+ARuWGsoaqnS5y7j0I5Gl0dXTGQwxQb7TCdKQbaqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPYnSH7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1A606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPYnSH7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F0A1F008A1;
	Mon,  9 Nov 2026 02:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190709;
	bh=dmly4DUcZXSyqRnYrDP4D8BKGDOU3GhIDD80/iUNNgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IPYnSH7PbZDkBdFirvarPRekUynNIknzJEfhay4ZdWhTsJMzzHH7UhwqsE3u+Wxac
	 mvo16hEukbf8j6ZaWnOsanSmFFIQN8WABoEpy24xZLAJ5IcdWXGiqGxLQuRnAjm9/d
	 rz42THSPdCD4lItEOWpENdFcykciphXhCVsk7VV3rwHX8uDdgVbhpQFIWmeW+30yht
	 If9rfn3bQzFVaZF3FXU5wSEgXSum7rGjSujeoDSPIMJolTk+Alt0WBTOgZVXXg7n5F
	 PagHKivSXizBeNt0sEnXOAZSGAMDawWh4Tr0mkZ/ciNow3zGQYlCsHgPoLRPl0ne6s
	 n8N5Mo/Hz8BqA==
Subject:
 Re: [PATCH 2/3] can: bcm: do not remove the procfs entry in bcm_notify()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Mon, 09 Nov 2026 02:18:28 +0000
Message-ID: <179419070881.488853.11899058559222233626@kernel.org>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The procfs reader now races with bind and unbind.

--

can: bcm: do not remove the procfs entry in bcm_notify()

bcm_notify() no longer calls remove_proc_entry() while holding RTNL.
The entry now lives from the first bcm_connect() until bcm_release().
bcm_connect() creates the entry only if it does not exist yet, and
bcm_proc_show() reports an unbound socket as "unbound".

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 9c39f7363ca59..0631293a8b54a 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -223,7 +223,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  
>  	seq_printf(m, ">>> sock inode %s", bo->procname);
>  	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
> -	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
> +	if (READ_ONCE(bo->bound))
> +		seq_printf(m, " / bound %s",
> +			   bcm_proc_getifname(net, ifname, bo->ifindex));

[Severity: Medium]

Can bcm_proc_show() now race with bcm_notify() and bcm_connect() on
bo->bound and bo->ifindex?

Before this patch, bcm_notify() called remove_proc_entry() before it
cleared bo->bound and bo->ifindex. remove_proc_entry() waits for running
readers. bcm_connect() also created a fresh entry only after it had
assigned bo->ifindex. So bcm_proc_show() never ran while bo->ifindex was
being written.

The entry now stays from the first connect() until bcm_release(). That
means these writers can run while a reader is inside bcm_proc_show():

bcm_notify() NETDEV_UNREGISTER:
    WRITE_ONCE(bo->bound, 0);
    bo->ifindex = 0;

bcm_connect():
    bo->ifindex = dev->ifindex;
    ...
    WRITE_ONCE(bo->bound, 1);

Take the unbind case: the reader loads bound == 1, then bcm_notify()
clears both fields, then the reader loads ifindex == 0. In that case
bcm_proc_getifname() returns "any" and the output is "bound any". Isn't
that the output the commit message says this patch removes?

For the rebind case, WRITE_ONCE() and READ_ONCE() don't give
release/acquire ordering. Could a reader see bound == 1 together with
the stale ifindex == 0, and print "any" for a socket bound to a specific
device?

The plain store to bo->ifindex and the plain load in bcm_proc_show()
also look like a data race that KCSAN would report.

The comment this patch keeps in bcm_notify() no longer seems accurate:

    /* Paired with the lockless fast-path check in
     * bcm_sendmsg(); bo->ifindex itself is only ever
     * accessed under lock_sock() so it needs no
     * annotation.
     */

The comment in bcm_sendmsg() relies on the same assumption, that
bo->ifindex is only mutated under lock_sock().

Taking lock_sock() in bcm_proc_show() would not fix this.
bcm_release() calls remove_proc_entry() while holding lock_sock(sk),
and that call waits for active readers:

bcm_release()
    lock_sock(sk);
    ...
    remove_proc_entry(bo->procname, net->can.bcmproc_dir);

Would it work to use WRITE_ONCE()/READ_ONCE() on bo->ifindex and
smp_store_release()/smp_load_acquire() on bo->bound? bcm_proc_show()
could then read one snapshot of ifindex into a local variable.

> +	else
> +		seq_puts(m, " / unbound");
>  	seq_printf(m, " <<<\n");
>  
>  	rcu_read_lock();

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd%40hartkopp.net
