Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132479;
	b=peQzexFCEX+/zTwaPpu/1w6teoa4kvUFo/pzJgao5T8MplSvrC5qLDpfd2QGO8gubV/7
	 NF2XiErjSRndqY81cLWl3cflcdeQSnfgwuzhzXrFNdaCwacXIPh3B6NJZgJaeRLqFYL/2
	 zx2Wv+x+58uGTSzjD0CkMDSkfF8SMmP+QXDY9003Syno3BhnMDud2va16eokr9CRGvsSC
	 /dojKpCgoV0X3nYNpw3UuNfMVZV3XrsUh5xbbkLErEpA17QsjrmSOW16OcPyzjSi0Xv0g
	 qA3mVjiDQ+aOtDy2DRavbECwBQsoI2j33VfwH3oYnS2cN0ehXY4w+Z/qN7U0mINDifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132479;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MFGxZ2Xkih07FRFLHqlCNyVWMKhUAhlJU97Z0YCYj0A=;
	b=iBxnuWNf1EgCRVQ9K2Eff4hnIOOXD/9AH3p+qrqUR71K5MQecvrdja8H3lN80T6OqFIW
	 d+Rlxj2wMxLbCOHfFLzIyWXbnhrBzejK92dXOiW8S4AxbU2Wn5AqAuquq3NPiqwXG3dzD
	 1ReBLv6JO3SeD3Xvyx3ni9Vz27Auwcx+JL91L1Q989TpOkB6m0JN1VMf3r4ux+kxPjTWd
	 e0unL1lRY7OWH2ncVNq3BFOcGyInOwU2eslcCCc6cTUuLnBvBx1CtnIhlppJG6c43FZ6e
	 FrGKOe21bt+j5vfZoEROEHDOKoXwmnYon75mJL03ilUf8vzYManwFD5P84Eqo2s7IyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKvLuyYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F17606A338;
	Thu, 19 Nov 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKvLuyYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE3C1F000D2;
	Thu, 19 Nov 2026 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795132479;
	bh=MFGxZ2Xkih07FRFLHqlCNyVWMKhUAhlJU97Z0YCYj0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PKvLuyYH4opg6GFFo7b+ncy0Sc94D79WFN5Vd7iI7UelP2G3pu9jYKjS87tigvH/t
	 pFnrJrch8POG0BAyNtt3NG0HpmZLXljh2GHJpkH0+kAeMNzR2H1/opWBiZW71LDYY0
	 UbIYH74IeE4lP1FgijKH5NMAtPQ7uz/lK161zbi/uhrgJvT7a33bm4+KcySPHj7ifS
	 lq22C5KfLUnFNUMR8tRc0ce74INxGkg4oerVMY3S14q4pfvu/DisyMl/N2hlOpBKVC
	 VGVMhtJIsjwcz2NxQC/gxuBMbGqScImL/LCLMst4p0AtcvBpPM6PqmNio0TiZzDyhn
	 y7F8f3IY+EaMA==
Subject: Re: [PATCH can-next v4 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Thu, 19 Nov 2026 23:54:38 +0000
Message-ID: <179513247817.3132.9443006972128193443@kernel.org>
In-Reply-To: <20261118-j1939-selftests-v4-7-756768d32ff2@pengutronix.de>
References: <20261118-j1939-selftests-v4-7-756768d32ff2@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message argues that test_j1939_multi.sh can stay in
  the default TEST_PROGS run (not TEST_PROGS_EXTENDED or XFAIL) because…
- [Low] In j1939_helpers.h, errqueue_empty_ok() is documented as "Is the
  error queue of s still empty after J1939_NEG_RECV_TIMEOUT_MS?".

--

selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW

This adds TP and ETP round-trip selftests in both directions between a
J1939 socket and a CAN_RAW peer. The TX tests check that the
TX-completion ACK comes only after the peer's EOMA. By default the peer
runs on a separate vcan behind the CAN gateway, which is meant to avoid
a known loopback echo race in the stack.

> diff --git a/tools/testing/selftests/net/can/j1939_helpers.c b/tools/testing/selftests/net/can/j1939_helpers.c
> index b7490c335d8b7..d60e49b3cc4e3 100644
> --- a/tools/testing/selftests/net/can/j1939_helpers.c
> +++ b/tools/testing/selftests/net/can/j1939_helpers.c
> @@ -523,6 +523,13 @@ bool errqueue_read_ack_ok(int s)
>  	return msg_has_tstamp_ack(&msg);
>  }
>  
> +bool errqueue_empty_ok(int s)
> +{
> +	struct pollfd pfd = { .fd = s, .events = POLLERR };
> +
> +	return poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS) == 0;
> +}
> +

[ ... ]

> diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
> index 92d6af3214f2d..bc5eef14bea23 100644
> --- a/tools/testing/selftests/net/can/j1939_helpers.h
> +++ b/tools/testing/selftests/net/can/j1939_helpers.h
> @@ -372,6 +372,9 @@ bool msg_has_tstamp_ack(struct msghdr *msg);
>   */
>  bool errqueue_read_ack_ok(int s);
>  
> +/* Is the error queue of s still empty after J1939_NEG_RECV_TIMEOUT_MS? */
> +bool errqueue_empty_ok(int s);

[Severity: Low]
Does this comment match what errqueue_empty_ok() checks? For a J1939
socket, POLLERR covers more than the error queue:

net/core/datagram.c:datagram_poll_queue() {
    ...
	if (READ_ONCE(sk->sk_err) ||
	    !skb_queue_empty_lockless(&sk->sk_error_queue))
		mask |= EPOLLERR |
    ...
}

So errqueue_empty_ok() also returns false when the error queue is empty
but sk_err is set, for example ENETDOWN or ENODEV from
j1939_sk_netdev_event(). It also returns false when poll() itself
returns -1.

The test fails in all of these cases. However, tp_tx_to_raw() and
etp_tx_to_raw() would then log "error-queue entry before the EOMA",
which names the wrong cause.

Should the comment, or the TH_LOG() message in the callers, also cover
the sk_err and poll() failure cases?

[ ... ]

> diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
> new file mode 100644
> index 0000000000000..a97fa8b998b89
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_j1939_multi.c
> @@ -0,0 +1,682 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * J1939 multi-frame wire selftests: TP and ETP against CAN_RAW.
> + *
> + * A CAN_RAW socket plays the transport peer against the kernel J1939 stack,
> + * in both directions. It takes the other side of the RTS/CTS/DT/EOMA
> + * exchange, for TP with a short message and for ETP with a payload that
> + * spans several CTS blocks (DPO windows).
> + *
> + * Known stack race: the stack updates a session from the loopback echo of
> + * its own TP and ETP frames. A CAN_RAW peer on the same vcan can read
> + * that echo first. If the peer replies quickly, the stack can cancel the
> + * session. See j1939_lib.sh for where the peer runs. The fix belongs in
> + * the stack; this file does not work around it.

[Severity: Medium]
The commit message says:

  By default the peer runs on its own vcan behind the CAN gateway that
  j1939_lib.sh sets up. With RPS off on that vcan, the peer then gets
  each frame only after the stack has handled its echo.

The notes below the cut line add "RPS must be off on the peer's vcan.
It is off by default."

Does anything in the series make sure RPS is off on CANIF_RAW?
vcan_setup() in j1939_lib.sh creates the interface with:

	if ! ip link add name "$dev" type vcan; then

setup() then starts j1939_gw, but nothing writes or checks
/sys/class/net/$CANIF_RAW/queues/rx-0/rps_cpus.

If the host has net.core.rps_default_mask set, the new vcan1 gets a
non-empty RPS map:

net/core/net-sysfs.c:rx_queue_default_mask() {
    ...
	rps_default_mask = dev_net(dev)->core.rps_default_mask;
	if (rps_default_mask && !cpumask_empty(rps_default_mask))
		res = netdev_rx_queue_set_rps_mask(queue, rps_default_mask);
    ...
}

The gateway's copy for the peer then goes through:

can_send()->vcan_tx()->vcan_rx()->netif_rx()->netif_rx_internal()->
get_rps_cpu()

A CAN skb always has a non-zero flow hash, so get_rps_cpu() picks a CPU
from the map. That CPU may not be the one handling the J1939 stack's
loopback echo.

In that setup, can the CAN_RAW peer reply before the stack has handled
its echo? That would bring back the race this comment describes, and
tp_rx_from_raw, tp_tx_to_raw, etp_rx_from_raw and etp_tx_to_raw could
fail at random in the default TEST_PROGS run.

j1939_test_main() only warns when the peer shares the vcan:

	if (j1939_needs_raw && !strcmp(CANIF_RAW, CANIF))

So this case would fail without any warning, and it would look like the
protected default setup.

Since the test stays in TEST_PROGS, should j1939_lib.sh clear rps_cpus
on CANIF_RAW, or at least warn or skip when it is set?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-j1939-selftests-v4-0-756768d32ff2%40pengutronix.de
