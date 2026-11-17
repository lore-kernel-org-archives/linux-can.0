Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888163;
	b=VAU/wp1cXm7+YzzlPbwRxRGauo5+Ql5jlHuhvO4txdfoqaVrmz0m+7sLdofOOZs2QdGS
	 TrM65K8WpjvP8IbPl0Qk0FCs5vHulkyz71MX0dotKQm4yoNw676TzfPL2LMm9H7dSR6Hr
	 otJXrUnkU1rrJ/XoN16xVlkINo533PAGD5eJiFUemutkbF9FsEiJI5+H3//JOo6ROXbV2
	 P47k5Jz7MPzctp4RDEORo0sti+g+LZDW0X38zPrFMyXTUsoRhIxULHh3o75MY9L9wmxFo
	 eL3PSxfFvTFi5WVrJ3UooUQftFY0zJv0vsLAH6JL2kua/4t+ziPeQBUEayRvfyLP0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888163;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=p736YppcMJac9L8iKnlaKOMhLhfdqxioQtFzzdE8Khk=;
	b=WcwTdoLLX9lEhHhM0MRZrWo/kOREKRF53cJGX1RZ6bBHEFCEApylzkp+pdEOM7XlwoHQ
	 y3V8gHeJLEz7nsumHuHp/qa/bxSu6Lu3Mze7MTkU6iyOFOgpBZHYrD5Q8nW7DgIhRLSs6
	 CM5A5Tvgw9pE8vuUAW/j9KPWVj1/C7GJd65belU8Bguqsvq0xAI+a1x6AFp8ZHGNUdIVs
	 xPeMcnOPuROgC4yAcphk65JP2/vOH4oRaX7o2j8CldneaEhmNyCj0h4piLr5gEgdXcqAq
	 dcd9oMzuAGAjE5jTDKYl2WvYNf2kXFlrwogeyLTRDPuQteoQPCX7P0EL4M+QeWkUirw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OReZYP3Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAF606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 04:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OReZYP3Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836B71F000C4;
	Tue, 17 Nov 2026 04:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794888163;
	bh=p736YppcMJac9L8iKnlaKOMhLhfdqxioQtFzzdE8Khk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OReZYP3YOFkY4Blb9vZ4bZPG1p8C8XQFu9Fb+7gXPA48uZgHxqQBwtBQF4jYHN1We
	 aL3KcpT2ML8yT2F/cVFN1uqjP4UeBAdHGVPi8Lf/Z+78qLdty67FAzIXHxVfaHE6eN
	 njmnOD8kfNO5ocpLZWTn7C0ZOC0Kg7VFGwcXVpGE4ai9Jbo1UuIVEn/EIpl9AP4K/u
	 rp5uuEkbl4x0xNbxkUWm7KmDovzDQAYZ22UjGfQ00Wvb47X9l4qqL5nOLth9m5FkA3
	 esMaB3m2Nu3l5i7ah0k/RFlGEHB+DEV6lEBnBEscubQHcE15sIIWnG9c13NZtvO0n1
	 XIAfzi+/Fna8A==
Subject: Re: [PATCH v14 2/6] can: j1939: add a safeguard to
 __j1939_priv_release_work()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Tue, 17 Nov 2026 04:02:42 +0000
Message-ID: <179488816204.3132.12202280066452473940@kernel.org>
In-Reply-To: <fc9af395-3578-494b-bc6d-b8481845e435@I-love.SAKURA.ne.jp>
References: <fc9af395-3578-494b-bc6d-b8481845e435@I-love.SAKURA.ne.jp>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit is tagged `Fixes: 9d71dd0c7009` and `Cc:
  stable@vger.kernel.org` as a fix for a use-after-free, but no caller…

--

can: j1939: add a safeguard to __j1939_priv_release_work()

This commit adds a write_lock_bh()/write_unlock_bh() pair on priv->lock
at the start of __j1939_priv_release_work(). This delays kfree(priv)
until any current holder of priv->lock has released it. It is meant to
protect against a caller that drops the last j1939_priv reference
through j1939_ecu_put() while holding priv->lock.

> If a user calls j1939_ecu_put(ecu) with priv->lock held but without knowing
> that this "struct j1939_ecu" is the last user of a "struct j1939_priv",
> __j1939_priv_release_work() via __j1939_priv_release() from
> j1939_priv_put() from __j1939_ecu_release() might call kfree(priv)
> before priv->lock is released (i.e. causing UAF).

[ ... ]

> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org

[Severity: Low]
Is there a caller in the tree that can actually reach this? The commit
message describes a hypothetical case ("If a user calls ..."). The
Fixes: and Cc: stable tags present it as a use-after-free fix.

Each place that calls j1939_ecu_put() with priv->lock held seems to
still hold another j1939_priv reference.

j1939_ac_process() runs under j1939_can_recv(), which pins priv:

net/can/j1939/main.c:j1939_can_recv() {
    ...
	j1939_priv_get(priv);
	can_skb_set_owner(skb, iskb->sk);
    ...
}

The matching j1939_priv_put() happens at the done: label, after the
address claim processing.

For j1939_ecu_unmap_all(), the NETDEV_DOWN notifier holds a reference
from j1939_priv_get_by_ndev(). On the __j1939_rx_release() path,
j1939_netdev_stop() drops its reference only after kref_put_mutex()
returns:

net/can/j1939/main.c:j1939_netdev_stop() {
    ...
	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
	j1939_priv_put(priv);
}

j1939_ecu_unmap() is reached from j1939_ac_fixup(), which holds its own
ECU reference around the unmap.

All three callers of j1939_local_ecu_put() in socket.c hold jsk->priv
and the j1939_netdev_start() reference. They call j1939_netdev_stop()
only afterwards.

j1939_ecu_timer_handler() is the remaining case:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	j1939_ecu_map_locked(ecu);

	/* The corresponding j1939_ecu_get() is in
	 * j1939_ecu_timer_start().
	 */
	j1939_ecu_put(ecu);
	write_unlock_bh(&priv->lock);
    ...
}

Here j1939_ecu_map_locked() does one of two things. It either takes a
new ECU reference, or it skips because ents[addr].ecu already points to
another mapped ECU. That other ECU holds its own priv reference from
j1939_ecu_create_locked(). In both cases this put is not the last priv
put.

The later patches in this series don't add such a path either. Both
"can: j1939: fix possibility of list corruption in __j1939_ecu_release()"
and "can: j1939: defer j1939_session_destroy() to WQ context" move the
releases to j1939_wq. They call j1939_priv_put() after
write_unlock_bh(&priv->lock).

If this is hardening rather than a fix for a reachable bug, should the
Fixes: and Cc: stable tags be dropped and the change described that way?

Also, the new lock/unlock pair only waits for holders of priv->lock. It
does not wait for holders of priv->j1939_socks_lock or
priv->active_session_list_lock.

If such a caller did appear, would the usual approach be for it to hold
its own priv reference across the locked section?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1d96e742-0479-4c36-ad0a-a0aaeda0a4fc%40I-love.SAKURA.ne.jp
