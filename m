Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025201;
	b=y96JbuiVG7w26naqCxi8xLapQcDsG7u0vMH+OOIo8HGPourmFhbbq6VQg8XJi86n0LU0
	 QjvZaEV9tKX6FU10fbVmwbHFZCUklOLiZ9Y355RogGs1nZvLglduAlOhTPdR+YkuKg6sd
	 3wUNInlhDwxgQ0qBW7cT0q+iGVvB78Y8MRWcDQSDB+H1y37D+NDpkfM3UFieMYtf5JiJZ
	 rkeIJ7j3q9hFrnuNnR8Oj9fqLpoANCiwm3/a/B3ENu2qT4/Zr2vcWuTbCtz5l7t6YVGr9
	 VTU7zw5P73a96O/MyHZAWXVr++4Sq2LqVL4P/HKO5rxKjROBEfRLMBv6ZPjk46X9TUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025201;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=n1RI3UsSrdfht+t8RXz2etQ/flEh8u5Q9ScRCNY5aKU=;
	b=1jgdf8XbjP5DzW7FNDi4BsXtZZExhIdL5iDzh5jRjrqt/wzBSzgQ7uLaykG3ztWj+11I
	 7nk7rQZwG/ZMpjQWExGE7caq+X/2JHr8XTkgSfJfNHoxEZLaYDcqbODGv78ApyEHzdKW5
	 sXn7B920a7l3XhGYkmzMStrgwzwubSF4twT47RDvnIiRYleAHi8UdSy5+uBdeDPTvn69J
	 6mXI/Gup/xA4EylMhqBojYh1jvryw+ta4ZOAQyCCQFU2JfhKDBUI6rQVoPq9Z8VfM/GoO
	 X3dkrlCTlNT95ipBt3qiHq8QlL0CEKaRVF0mxP5Arxc5Ai9xQCuCWNFCw/snLlsOx1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYRst09z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EAD606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYRst09z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149001F008A1;
	Sat,  7 Nov 2026 04:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025200;
	bh=n1RI3UsSrdfht+t8RXz2etQ/flEh8u5Q9ScRCNY5aKU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hYRst09zLQGh1OdnmZkwqVKI3aQCKAR4e8YFUARxdR6Z0pjFh3Ju3oxfvphFLLhXp
	 cjOPRGIrCfFPYz+tP6ccGTDPdBNBjvv50KuwIaYgocKTqO9YmQwtUnHBCrbb6iVfE9
	 jU+vxlxhl3OQ9CkWb/uWOI81wNmtteDPDGEroNsom9FLCuTIHAuxEnhBmiXXoxytlP
	 MUOX/kI5WEKLa2qScdQVK2v2nc75FxaeP+MjKI/0MW7+1s8ePhTYGQ6S96M/+sH2Nx
	 ASYy+RiCqUjztEb8YO18aWjFC7UlowvIF+P4kLqU7os5qhjmAZRuUT5ZDgRRbh2CXe
	 HewcC7AZ/JgSg==
Subject: Re: [PATCH v7 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
 in j1939_ecu_map_locked()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sat, 07 Nov 2026 04:19:59 +0000
Message-ID: <179402519966.488853.1117515661539913987@kernel.org>
In-Reply-To: <f12e4200-9267-424d-99f2-584774bd8eb1@I-love.SAKURA.ne.jp>
References: <f12e4200-9267-424d-99f2-584774bd8eb1@I-love.SAKURA.ne.jp>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch adds the new conditions
  (`READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED` and…

--

can: j1939: fix "struct j1939_ecu" refcount leak in j1939_ecu_map_locked()

With this commit, j1939_ecu_get() fails if the netdev tied to j1939_priv
is no longer NETREG_REGISTERED, or if __j1939_rx_release() has already
dropped priv->rx_kref to zero. The aim is to stop
j1939_ecu_timer_handler() from mapping an ECU back into priv->ents[]
after j1939_ecu_unmap_all() has run.

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..11d08b7485489 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -50,8 +50,13 @@ void j1939_ecu_put(struct j1939_ecu *ecu)
>  
>  static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
>  {
> -	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
> -	return kref_get_unless_zero(&ecu->kref);
> +	struct j1939_priv *priv = ecu->priv;
> +
> +	/* Don't get an ECU ref if netdev is no longer registered or
> +	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
> +	 */
> +	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
> +		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);

[Severity: Critical]
The new gate is in the shared j1939_ecu_get(), not only on the map path.
Does that make the two name lookups in bus.c disagree?

Once reg_state leaves NETREG_REGISTERED, j1939_ecu_get_by_name_locked()
fails even for a live ECU. j1939_ecu_find_by_name_locked() still only
checks j1939_ecu_valid():

net/can/j1939/bus.c:j1939_ecu_find_by_name_locked() {
	...
	list_for_each_entry(ecu, &priv->ecus, list) {
		if (ecu->name == name && j1939_ecu_valid(ecu))
			return ecu;
	}
	...
}

j1939_local_ecu_get() takes a NULL from the gated lookup to mean there is
no ECU with this NAME, so it creates one:

	ecu = j1939_ecu_get_by_name_locked(priv, name);
	if (!ecu)
		ecu = j1939_ecu_create_locked(priv, name);

The duplicate (E2) is added after the original (E1) and holds its own
kref, netdev_hold() and j1939_priv_get(). j1939_local_ecu_put() uses the
ungated j1939_ecu_find_by_name_locked(), so it finds and puts E1, not E2.

unregister_netdevice_many_notify() sets reg_state to NETREG_UNREGISTERING
before it calls synchronize_net() and before it sends NETDEV_UNREGISTER.
In that window, the re-bind branch of j1939_sk_bind() runs without any
reg_state check:

	/* drop old references */
	j1939_jsk_del(priv, jsk);
	j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
	...
	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);

The first-bind reg_state check runs without rtnl, so it can race too.

Could this sequence happen?

1. Socket A is bound with NAME N, so E1.kref == 1.

2. An address claim for N goes through
   j1939_ac_process()->j1939_ecu_timer_start(E1). E1.kref == 2 and the
   250ms ac_timer is armed.

3. The device is unregistered and reg_state becomes NETREG_UNREGISTERING.

4. A re-binds. j1939_local_ecu_put() drops E1 to 1. Then
   j1939_ecu_get_by_name_locked() fails and E2 is created.

5. NETDEV_UNREGISTER runs
   j1939_sk_netdev_event_unregister()->j1939_local_ecu_put(). That finds
   E1 again and drops it to 0, using up the reference held by the
   pending timer.

6. __j1939_ecu_release_work() calls kfree(ecu) without cancelling
   ac_timer. j1939_ecu_timer_handler() would then run on freed memory.

There is also a variant. Suppose the timer fires and re-maps E1 before
reg_state changes. The misdirected put then frees E1 while
priv->ents[addr].ecu still points at it. After that,
j1939_netdev_stop()->__j1939_rx_release()->j1939_ecu_unmap_all() would
dereference and put the freed ECU. E1->nusers and ents[].nusers would
also go negative.

In both cases E2 is never put. It leaks together with its netdev and priv
references, so unregister_netdevice() would wait forever. Isn't that the
same kind of j1939_ecu refcount leak this commit is meant to fix?

Also, the comment in __j1939_ecu_release() still says readers can
validate with either j1939_ecu_valid() or j1939_ecu_get(), as if they
were the same check.

Is the reg_state test needed for the reported bug at all? The rx_kref
test under priv->lock already looks enough to order the timer handler's
map against __j1939_rx_release().

Could the new checks go only in j1939_ecu_map_locked() and
j1939_ecu_timer_start()? Or could both name lookups use the same check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/00aae7aa-8351-4d69-8938-4d8e4eee78c2%40I-love.SAKURA.ne.jp
