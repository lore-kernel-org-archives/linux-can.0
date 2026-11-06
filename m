Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943323;
	b=XrdVURo3p/1TiaGIo1P7XGPJtbn3tkVBnTvQrPJvgMchuSPMwwxbRSGreIe90eKs75xq
	 WJgZoGjflOF7oL7dpGP4yro8hoyQb5EdVX3qTOqTGoERA9RE0HU4b483wYZZ/4YJTbybm
	 /4mTsGT/w8FQa1t11fqAdo3jEt6vdlWEwHEoKiwonj2xRsFT5EA75gSx0FC3dxW3Weght
	 EilnasDmeBgh5BuoOEdSumCjNfidyhDnXg3hQF2eC5hVk1L6aDjQ8qaWu6klC+aPFei0B
	 w+If/9do5+EqTTHEYAGlWYcpfFMGdnoCmpiUU5hCxq8f2pC89TZok2LyX+je8QAEu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P3vxheL6ZI89R8wXXiNHiC3EY/wvfxAe4QhhrVPhFdY=;
	b=20SpNbtk8yIRveudIcECYMuSXW68h0O++YOgbyB2QfVDv0PcWlBzDAglHgtP+n9zrMLU
	 24XYcD4HyKx+a93xWovYNzMnDUGClhLLML6mp+v/TGW9Mi5PZEs5ToFIyQ23A1gnuTvMb
	 YiHf2hOF+LKzKrfMhUZhecIqTvtBf1+Y5dU2Z/5xeqBnCvagCLfw0qpSXrDsWoACRG9uF
	 E0GN6wYpXX8V16ED2Ebmg+/qgvV4nqRFqxEgSqPegNkEECT6pvXZ+j6xMsiDeCzAZFIQ4
	 AbUl6jAEVJzBdkZxG+TqurH6CWsz6HXYJ9rP9TRgbJDaNBkxwlblfTuAy6/ifXVHoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDQxl67k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76489606A32C;
	Fri,  6 Nov 2026 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDQxl67k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DBF1F008A7;
	Fri,  6 Nov 2026 05:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943323;
	bh=P3vxheL6ZI89R8wXXiNHiC3EY/wvfxAe4QhhrVPhFdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QDQxl67kdj4Wz0SHkX3hkC+uhkJcyypq4OLH9AI1t/9eRdT6fuG9e6c2mK3xtgJlO
	 8QeoXaHcq37MA79aR0fPZHzrefW/mrAGJMA5Oag6VVTGyVazINZWt/gfVfgm+t6cXb
	 oD+HRNQAoprabgRGHDvlconApCG/wKiThB9RHQnDET+RSwz6dTB/R7HQ3KTb2tfNvE
	 j6dF9et9HRxxgjlW3xiZRSyeazZy70AzYbRfLyhGR5Vv/NX6FvxYyFMMZhxs13iVcP
	 WJBgy4UcR9QkBs2TfKUuJoLUljSFR+U4QMSWXY138lW1wzaJIeTegzu/TuvK2zzs5n
	 WOk46HK/qPUow==
Subject: Re: [PATCH can-next v2 5/9] selftests: can: add J1939 addressing and
 concurrency tests
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:21 +0000
Message-ID: <179394332195.488853.12586024266286059916@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-5-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-5-cf797c83317b@pengutronix.de>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_j1939_addr.c avoids the kernel's address-claim hold-off
  race only on the success path.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a kernel
  bug that the patch works around rather than fixes.

--

selftests: can: add J1939 addressing and concurrency tests

This adds test_j1939_addr, a selftest for J1939 name based addressing,
address claiming with the kernel's 250 ms hold-off, address claim
conflicts and concurrent TP sessions. The test that loses its address
keeps a socket open until the winning name is mapped, which avoids a hang
when the interface is deleted.

> diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
> new file mode 100644
> index 0000000000000..02f9e504b567f
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_addr.c
> @@ -0,0 +1,679 @@

[ ... ]

> +TEST_F(j1939_addr, name_addressing)
> +{

[ ... ]

> +	ASSERT_TRUE(forge_address_claim_ok(self->raw, self->ifindex, SA_RX,
> +					   NAME_RX, &t0))
> +		TH_LOG("failed to inject address claim: %d", errno);
> +
> +	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
> +	ASSERT_GE(self->tx, 0);
> +	ASSERT_TRUE(j1939_connect_name_ok(self->tx, self->ifindex, NAME_RX,
> +					  J1939_NO_ADDR, PGN_TEST))
> +		TH_LOG("connect to peer NAME failed: %d", errno);
> +
> +	ASSERT_TRUE(send_after_claim_ok(self->tx, tx_buf, sizeof(tx_buf), NULL,
> +					&t0, &elapsed_ms))
> +		TH_LOG("send to peer NAME failed after %ld ms: %s",
> +		       elapsed_ms, strerror(errno));

[Severity: Medium]
If one of these fails, does the selftest run hang instead of reporting
the failure?

forge_address_claim_ok() has just caused the kernel to arm the 250 ms
ac_timer for NAME_RX. If j1939_open() or j1939_connect_name_ok() fails
here, the ASSERT_GE()/ASSERT_TRUE() ends the test. Then
FIXTURE_TEARDOWN(j1939_addr) closes tx, rx and raw right away, so the last
J1939 socket on the vcan closes while the timer is still pending.

The commit message describes what happens next:

  If the last socket closes while the hold-off timer of a claim is still
  pending, the kernel keeps a reference to the interface and deleting it
  hangs.

So the ip link delete in cleanup() in j1939_lib.sh would block forever. A
regression in connecting by name, which this test is meant to catch,
would then look like a hang and not like a test failure.

In strict mode, send_after_claim_ok() seems to leave the same window
open. It gives up once elapsed_ms is past aclaim_max_ms():

	if (*elapsed_ms > max_ms) {
		if (ret == want_len)
			errno = ETIMEDOUT;
		return false;
	}

With J1939_STRICT_TIMING that limit is 300 ms after t0. The kernel only
arms its 250 ms timer when it processes the claim, which is after t0, and
the soft hrtimer can fire later still.

The same thing looks possible in a few other places:

  address_claim_send(): send_data_after_claim_ok() fails in strict mode
  while the NAME_CLAIM timer is still pending.

  ac_conflict_probe_ok(): the baseline send_data_after_claim_ok() returns
  false in the same way, and the caller's ASSERT_TRUE() tears down at once.

  ac_conflict_lose(): ASSERT_GE(self->rx, 0) aborts before the wait for
  NAME_LOWER, or the strict-mode send_after_claim_ok() times out while
  that timer is still pending.

Could every exit path wait out the hold-off, for example by keeping a
J1939 socket open until ACLAIM_MAX_MS after the last claim, before the
sockets are closed?

[ ... ]

> +/* A higher-priority competing claim takes the address away from us. */
> +TEST_F(j1939_addr, ac_conflict_lose)
> +{

[ ... ]

> +	/*
> +	 * Keep the sockets open until the kernel maps NAME_LOWER at the end
> +	 * of its hold-off. If the last socket closes while that timer is
> +	 * pending, the kernel keeps a reference to the interface and
> +	 * deleting it hangs.
> +	 */
> +	self->rx = j1939_open(self->ifindex, SA_RX, J1939_NO_PGN);
> +	ASSERT_GE(self->rx, 0);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
hang that this comment works around looks like a netdev reference leak in
the kernel. Should it be fixed in net/can/j1939 instead of being avoided
in the test?

When the last J1939 socket closes, j1939_netdev_stop() ends up in
__j1939_rx_release():

net/can/j1939/main.c:__j1939_rx_release() {
	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);
	mutex_unlock(&j1939_netdev_lock);
}

j1939_ecu_unmap_all() only unmaps. Nothing on this path calls
j1939_ecu_timer_cancel(), whose only caller is j1939_ac_process().

If a timer armed by j1939_ecu_timer_start() fires after this, the handler
maps the ECU again:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
	write_lock_bh(&priv->lock);
	...
	j1939_ecu_map_locked(ecu);
	...
	j1939_ecu_put(ecu);
	write_unlock_bh(&priv->lock);
}

j1939_ecu_map_locked() takes a new ECU reference, and the handler drops
only the reference the timer held. The ECU then stays mapped in a priv
that is no longer attached to the netdev.

j1939_netdev_notify() looks up priv with j1939_priv_get_by_ndev(), which
now returns NULL. So NETDEV_DOWN and NETDEV_UNREGISTER never unmap the
ECU, and __j1939_ecu_release() never runs. That leaks
ecu->priv_dev_tracker, the priv reference and priv->dev_tracker, and
unregister_netdevice() waits forever.

The claim can come from a remote ECU on the bus as well as from a local
socket. Creating CAN sockets needs no capability. So it looks like an
unprivileged user can make the interface undeletable by closing the last
J1939 socket within 250 ms of a claim.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
