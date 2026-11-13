Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549723;
	b=nud3vAXoKnch2VIesVo/IXrB5M7STHo3WIlgbOuf2dnzB4qSVokkvPQnxUaieW2M4ZuN
	 pRTv4WzTM8ul+j6IbWpgBoG88HVYE8AaI85tp41qNGsbWTdLWFF0IfcfM3OmymrH+TebX
	 Qi52kszJoCfIsVeSbPoaZZ30Of6/T8zxDPluDG4ng5ZLYfmmQO46JoLSh2AirkYGLoyXF
	 zcSXYdTKeaBAk0qh1iJmxApPfoWlpuTb+hMD44nZJ9+xG/BeF+oR1sovzQFWF2negar0t
	 EAcB6/2tpSg+PB+Nxbya9qUKJYhWTIKiSWx1h5WUFz6fJj5nbWhdLDTgg26vrcsS2og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549723;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g8hxueMIblj1g7XgDPhvYyKOmygpo1ip3S6Ii/4RJSo=;
	b=A6LOLnkPZXeCraHmoVWsCEM0YyhiaAXopBvLjQMkgov0QVkJN5ZgPSemrrXbyz9JneH5
	 W1lhloeaogF8+JgcvRIvl1gxjrvAVG2T+FkTg9xl/JwQq6pgIHDc50iaGMoNjh6RTOFou
	 TyIFZXqiHJPBtL3+MkQnw001ky1g1tiW5zA1JGUhUvyu/mJrJWhXSxPNkSm20hqi7T02S
	 iVRgng/aXxbstoLBLnQC1h5QLTVfQHhsv9VRwG1bCG/I3+JPb30pUcagkPeDLwQLEQGG4
	 MHlkjngCltKxZ0jskpy8GwyQ2kWGOixF/u7/D9j4iZOe5etAZlxBZrG7MnElB1tMonw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+6vXGI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D440606A888;
	Fri, 13 Nov 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+6vXGI9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC021F000C4;
	Fri, 13 Nov 2026 06:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549723;
	bh=g8hxueMIblj1g7XgDPhvYyKOmygpo1ip3S6Ii/4RJSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N+6vXGI9VzZ8iYmPYsL2EuKqsDVRlRQOx/day2l2r6tgVmIE6hll04LKUFih4Btig
	 ARc4ZvnoHC66A62Zzk6FjdsXmTlfykGXPnokRrUDZmO7wOKgYRzejQoGnQVj/bGx3U
	 853FryG9bdWgnDEr/OqA+usi09QGMYDeWv89drILuRpZTY+2wc3u/Wb6wmbzbxFEL0
	 ljaDcFR6CS7HTMe3aB3KhNU4TZpW8ZPkm5QrEtcekSDBynDbpwT23x1VI0Mhp2pj6K
	 KKDscLvd/W8quyVrPgum5p7NAVGPeik5khUxRWbAsJXr8GFmsePUc3igzw6F+41Azi
	 Kp9p9jo01/Kug==
Subject: Re: [PATCH can-next v3 5/9] selftests: can: add J1939 addressing and
 concurrency tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 13 Nov 2026 06:02:02 +0000
Message-ID: <179454972211.488853.7880439276106658212@kernel.org>
In-Reply-To: <20261111-j1939-selftests-v3-5-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-5-5a80277ab363@pengutronix.de>
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

- [Low] The ACLAIM_* block comment in
  tools/testing/selftests/net/can/test_j1939_addr.c (lines 99-100) says:…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  depends on it and works around it.

--

selftests: can: add J1939 addressing and concurrency tests

This commit adds a J1939 selftest. It covers NAME-based addressing, the
Address Claimed frame and its 250 ms hold-off, address claim conflicts,
and a stress run of concurrent TP sessions. To avoid a hang when the
interface is deleted, the tests keep a socket open until the hold-off
timer has run.

> diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
> new file mode 100644
> index 0000000000000..b3e325be38ddd
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_addr.c
> @@ -0,0 +1,736 @@

[ ... ]

> +/*
> + * The kernel lets a NAME use a claimed address only ACLAIM_HOLDOFF_MS after
> + * the Address Claimed frame (j1939_ecu_timer_start() in
> + * net/can/j1939/bus.c). Before that, a send from or to that NAME fails with
> + * EADDRNOTAVAIL.
> + *
> + * The first send must succeed no later than ACLAIM_MAX_MS (strict:
> + * ACLAIM_STRICT_MAX_MS). A defended address must stay ours, and the
> + * contender must get none, until that latest time. The tests that time the
> + * first send also check that it does not succeed before ACLAIM_MIN_MS.

[Severity: Low]
Is this comment accurate? Only name_addressing and address_claim_send
check EXPECT_GE(elapsed_ms, ACLAIM_MIN_MS).

ac_conflict_lose also times the first send to NAME_LOWER after the forged
claim with send_after_claim_ok(). It only uses elapsed_ms in TH_LOG():

	EXPECT_TRUE(send_after_claim_ok(self->rx, data, sizeof(data), &winner,
					&forge_t0, &elapsed_ms))
		TH_LOG("send to NAME_LOWER failed after %ld ms: %s",
		       elapsed_ms, strerror(errno));

The baseline send_data_after_claim_ok() in ac_conflict_probe_ok() has no
lower bound check either.

The kernel makes the winning NAME reachable only once the hold-off timer
fires, so a lower bound check in ac_conflict_lose would be valid. As
written, a kernel that maps the winning contender right away would still
pass ac_conflict_lose.

Should the comment be reworded, or should ac_conflict_lose add an
EXPECT_GE(elapsed_ms, ACLAIM_MIN_MS) check?

> + * ACLAIM_MARGIN_MS is a guess.
> + */

[ ... ]

> +FIXTURE_TEARDOWN(j1939_addr)
> +{
> +	/*
> +	 * A failed test can stop while the hold-off timer of a claim is
> +	 * pending (see ac_conflict_lose). The teardown does not know when the
> +	 * claim started, so wait as long as a claim may take.
> +	 */
> +	/* POSIX allows usleep() to fail with EINVAL for 1 s or more */
> +	if (_metadata->exit_code != KSFT_PASS)
> +		poll(NULL, 0, ACLAIM_MAX_MS);

[Severity: High]
This isn't a bug introduced by this patch, but this teardown works around
a leak in net/can/j1939. Because of the workaround, the suite cannot catch
that leak.

j1939_ac_process() arms the hold-off timer and then drops its own
reference. During the hold-off, only ecu->ac_timer holds the new ECU:

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	j1939_ecu_timer_start(ecu);
 out_ecu_put:
	j1939_ecu_put(ecu);
}

When the last socket closes, __j1939_rx_release() tears down the priv but
does not cancel a pending ac_timer:

net/can/j1939/main.c:__j1939_rx_release() {
    ...
	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);
    ...
}

j1939_ecu_unmap_all() only walks priv->ents[], so it skips an ECU that is
still in its hold-off:

	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
		if (priv->ents[i].ecu)
			j1939_ecu_unmap_locked(priv->ents[i].ecu);

When the timer fires later, j1939_ecu_timer_handler() maps the ECU
without any check. That takes a new mapping reference:

	write_lock_bh(&priv->lock);
	j1939_ecu_map_locked(ecu);
	j1939_ecu_put(ecu);
	write_unlock_bh(&priv->lock);

Nothing unmaps the ECU after that. The priv is already detached from the
ndev, so j1939_netdev_notify() returns early on NETDEV_UNREGISTER:

	priv = j1939_priv_get_by_ndev(ndev);
	if (!priv)
		goto notify_done;

The ECU keeps its netdev_hold() and j1939_priv_get(), and the priv keeps
its own netdev_hold(). unregister_netdevice() then waits forever.

can_create() and J1939 bind/sendto check no capabilities. Can a local
unprivileged user trigger this by sending an Address Claimed frame and
closing the socket within 250 ms? A claim from a remote ECU that arrives
just before the last local socket closes looks like it would take the same
path.

This poll(), and ac_conflict_lose keeping a socket open until NAME_LOWER
is mapped, keep the suite out of that window. The suite therefore passes
on a kernel that has the bug. The commit notes say "the fix belongs in the
stack". Could a test that closes the last socket during the hold-off and
then deletes the interface be added once the stack is fixed?

> +
> +	if (self->tx >= 0)
> +		close(self->tx);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-j1939-selftests-v3-0-5a80277ab363%40pengutronix.de
