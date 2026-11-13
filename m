Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556309;
	b=U8HhWYIctG0+wsi1egGO4aKKaNwOhZ1HONbq3rbcCWXgSc/BinMwE4WNGTMDRN4t2cqO
	 NWyDhb08koh/AiXCy633ziBsXJWODlTtpN1g5eZIqENjKjoREWopUEBY1YEjaqndXJcDg
	 8W3YFm/lfPR4ga1IuEJ0Oqym+5gWRO+WCWgynqoL/GAjpH9rfaDEXKteCwnRSiUdQ9Lty
	 /uu+9sXw3YNni/lS9zAOrtCkqrJkDjTgybDjEVFyeDjx3lb4NaGtXyXgOPJKQ5kSYDtkY
	 8Kj3wjkCUzDfIBYQnAFK3GFgIdV1MGBJSDs5rjnkDDC71xU9lIHLxvyhXh2FhuplDzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556309;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=BWefGk4puDoDVQr0nLGSSA6FF1qoZg/O5V+gtT/rjLc=;
	b=wMWz0AxuKOZUHh8+WGKvXh4Lw9ZOUrWUnN4zvRiyDNzgYhKO7oUGJ3VWEnONI3X+GP8T
	 bAjsCJWAubTL8+8ZPVdS7rYe5TZiSFJrcTxsasDCqkeaKg6F4z8epxauTzkHaeReRNZMK
	 IcH97/WWw69AlZqLtQzYQ2JTD2olcoLOW3Ww4XtH5hTHwXiBrSXb6F4VcHiBN67ClOcg3
	 Vq0B8SyznG4ri1U69ueOUVDBPe+QgM09ni9oIjwSjBCDMmi54FQNRUaGphfLZkDRxeVUF
	 W6zojHHBMXzpIFbsFyWjVknIHaOB5kt92nZvmoqVXokklu+vTY5ZQbcz9jFYzls+qFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BNMtn1rD;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FB606A31C;
	Fri, 13 Nov 2026 07:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BNMtn1rD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=BWefGk4puDoDVQr0nLGSSA6FF1qoZg/O5V+gtT/rjLc=;
	b=BNMtn1rDOMbAlMap9vvR/BpB+LvNymn11X5rVkyT3CypQb7U8y/P2f6+PtM4Uh
	MTg5X9QjaDQ+on2g0A/v409yGQp5zWb/wTvGtMAkKKqgV4sEgpoxTAhvHGt1rFeA
	Dl/C5gPchHi9ykicQOfVU2y/XJrMbOg0sqX2MchF2yqXY=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH can-next v3 7/9] selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW
Date: Fri, 13 Nov 2026 15:49:49 +0800
Message-ID: <179455618934.121136.10008965335170070665@163.com>
In-Reply-To: <179454972353.488853.9453703448480835098@kernel.org>
References: <20261111-j1939-selftests-v3-7-5a80277ab363@pengutronix.de> <179454972353.488853.9453703448480835098@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL61gwfZqI58BHA--.10753S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1DCF1rJr1fKr13Kw15Arb_yoWfZw4kpF
	WrGFyUtr1kGrWIyw4kZa18W34Fyrn3JrW5Xr1UJ34UA398Xr4fKFsxK3y7ZFyDCwn5Za4j
	vw4Sg34DGa1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoqcUUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAHgVmr2wWEQpAAA3-

Hi,

I am only on the Cc list of this series, not its author, so this is a
third-party check of the review rather than a respin note. I went through
all four mails against the patches as posted, with the surrounding code read
in a v7.3-rc7 tree (which carries unrelated local changes in transport.c, so
treat the line numbers there as approximate; the function names are what
matter). None of the findings is wrong. Below is what I could confirm, the
two places where I would state the claim more narrowly, and the smallest
change I think each one needs. Oleksij should decide what to take; the
pw-bot tag is his to add.

7/9 (Medium, echo race in test_j1939_multi) -- confirmed

Every step of the mechanism checks out:

  net/can/raw.c:67,386-388   MASK_ALL is 0, so the raw socket lands on
                             rx[RX_ALL] via can_rcv_list_find()
                             (af_can.c:395)
  main.c:122-123             J1939 registers with CAN_EFF_FLAG |
                             CAN_RTR_FLAG, so it lands on rx[RX_FIL]
                             (af_can.c:410)
  af_can.c:601,607           can_rcv_filter() walks RX_ALL before RX_FIL
  vcan.c                     echo=0 by default, so the loopback is
                             netif_rx() in can_send() (af_can.c:263,289)

so the raw peer does see a frame before the stack does, on the CPU that
sent it. The two cancel sites are the ones named: the default case of the
last_cmd switch in j1939_xtp_rx_dat_one() (transport.c:1949) and the
last_cmd != 0 check in j1939_xtp_rx_rts_session_active()
(transport.c:1768).

One detail that decides which half of the file is fragile: the switch has
cases for 0xff, DPO, BAM and TP CTS (0x11) only. An ETP session whose last
command was the peer's ETP.CTS has last_cmd 0x15, which matches nothing and
goes to default, so in ETP TX the echo of the previous block's last DT that
arrives after the peer's next ETP.CTS does cancel the session. In TP TX the
equivalent echo arrives with last_cmd 0x11 and takes the TP_CMD_CTS case,
which breaks for a TP session and is accepted. So the DT-echo half of the
race is ETP-only, and the ETP TX tests should be expected to be the flaky
ones, not TP and ETP equally.

One thing I would state more narrowly: deliver() is called twice inside a
single can_rcv_filter(), on one CPU, with no scheduling point between them.
"RX_ALL is walked first" orders the two deliveries, not the two consumers'
reads. For the peer to win, the test task has to be woken on another CPU
and complete the whole reply path back into j1939_can_recv() before the
first CPU finishes the second loop body. That is a real window but a narrow
one, which matches "I have not seen this in QEMU runs". I would not argue
about the ordering guarantee; I would just not let a test depend on it.

On the three suggested remedies, XFAIL is the one I would avoid. In
kselftest_harness.h, __test_passed() is exit_code != KSFT_FAIL &&
exit_code <= KSFT_SKIP, so KSFT_XFAIL (2) and KSFT_XPASS (3) both count as
passing, and ksft_test_result_code() prints XPASS as "ok # XPASS". An
XFAIL test is green both when the race fires and after the stack is fixed,
so a later regression in these tests would be invisible.

TEST_PROGS_EXTENDED does what the mail asks for without that cost:
Documentation/dev-tools/kselftest.rst:283 says such entries are "not tested
by default", lib.mk:131-133 still rsyncs them into an out-of-tree build and
lib.mk:163 still installs them; the binary is built because it stays in
TEST_GEN_FILES. For this Makefile that is

	TEST_PROGS_EXTENDED := test_j1939_multi.sh
	TEST_GEN_FILES := $(TEST_PROGS:.sh=) $(TEST_PROGS_EXTENDED:.sh=)

and the existing "$(filter $(OUTPUT)/test_j1939_%,$(TEST_GEN_FILES))" rule
keeps working. That plus a paragraph in the commit message, as asked,
seems like the right shape until the stack handles its own echo.

3/9 (Low, base skipped for a missing CAN_RAW) -- confirmed

j1939_test_main() in j1939_tests.h skips on CAN_RAW for every binary, and
test_j1939_base.c only ever creates SOCK_DGRAM/CAN_J1939 sockets: the data
path is send_recv_verify_ok()/recv_timeout() and the setup is
j1939_open_flags()/j1939_open()/j1939_connect_ok(). No open_raw(),
open_raw_rcvbuf() or J1939_SETUP_RAW anywhere in the file.

The configuration is reachable: CAN_J1939 (net/can/j1939/Kconfig:6) only
depends on CAN and does not select CAN_RAW, which is merely "default y"
(net/can/Kconfig:24). CAN_J1939=y with CAN_RAW=n builds, and on it all
seven base tests report SKIP while they could run.

A flags argument to j1939_test_main(), with J1939_NEEDS_RAW passed only by
the four binaries that open a raw socket, fixes it. Keeping both symbols in
config is right either way; what needs changing is the v2 changelog line
"every test needs it".

4/9 (Low, ordering barrier in filter_pgn) -- partly confirmed

There is a stronger guarantee than the comment claims, in the common case.
Both sends land on the same sk_session_queue. The first one calls
j1939_sk_queue_session(), sees an empty queue, and activates plus schedules
its txtimer with 0 ms from sendmsg(); the second one only queues, and is
activated later from j1939_sk_queue_activate_next_locked() inside the first
session's txtimer, with err == 0 so time_ms is 0 as well. The second timer
is therefore started from the softirq of the first timer, on the same CPU,
and both loopbacks go into that CPU's FIFO backlog in order.

The comment only breaks if the second sendto arrives after the first
session has already left the queue (so sendmsg() activates it itself), and
the task has migrated between the two syscalls, and the first CPU's NET_RX
has been deferred past the second CPU's. All three at once, and as noted it
can only produce a false pass. So I would keep the barrier and make the
last read bounded instead of instant:

	EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
			       J1939_NEG_RECV_TIMEOUT_MS), -1)

That costs 300 ms on the passing path and catches a late PGN_B on any CPU,
which is exactly the case the MSG_DONTWAIT read misses.

5/9 (Low, ACLAIM_* comment) -- confirmed

The comment says "the tests that time the first send also check that it
does not succeed before ACLAIM_MIN_MS", but only name_addressing and
address_claim_send have the EXPECT_GE. ac_conflict_lose passes elapsed_ms
to TH_LOG() only, and the baseline send in ac_conflict_probe_ok() has no
lower bound either.

Adding the check there is valid, not just cosmetic: a send to NAME_LOWER
goes through j1939_ac_fixup() -> j1939_name_to_addr(), which returns the
address only while j1939_ecu_is_mapped_locked() is true and otherwise
returns J1939_IDLE_ADDR, which turns into -EADDRNOTAVAIL
(address-claim.c:115-119, bus.c:253-270). The mapping happens only from
the hold-off timer, so a kernel that maps the winner immediately would be
caught. I would add EXPECT_GE(elapsed_ms, ACLAIM_MIN_MS) after the send to
NAME_LOWER and leave the comment alone; then it is accurate.

5/9 (High, pre-existing ac_timer leak and the teardown that hides it) --
confirmed, but I would not fix it here

The chain is exactly as described:

  address-claim.c:240,242   j1939_ecu_timer_start() takes the only
                            reference, then j1939_ac_process() drops its own
  main.c:210-219            __j1939_rx_release() unregisters, unmaps and
                            clears the ndev
  bus.c:99-108              j1939_ecu_unmap_all() walks priv->ents[] only,
                            so a pending ECU is skipped
  bus.c:128-147             the timer handler maps unconditionally, which
                            takes the mapping reference back
  bus.c:159,167 + main.c:140  ECU holds the netdev and the priv, priv holds
                            the netdev

and netdev_wait_allrefs_any() then never returns; it prints
"unregister_netdevice: waiting for %s to become free" every
netdev_unregister_timeout_secs (10 s) and keeps waiting.

It is reachable without privileges: can_create() has no capability check,
and a user namespace with its own netns has CAP_NET_ADMIN there, so an
unprivileged task can create the vcan, send the Address Claimed frame,
close the socket inside the 250 ms window, and leave the netns teardown
spinning.

What I would push back on is doing it in this series. Cancelling the timers
in j1939_ecu_unmap_all() runs into the existing ABBA that Marc described on
2026-10-15: j1939_ac_process() calls j1939_ecu_timer_cancel() while holding
priv->lock, hrtimer_cancel() waits for j1939_ecu_timer_handler(), and the
handler starts by taking priv->lock. There is also the rule that the final
j1939_ecu_put() must happen under priv->lock, which the unlocked puts in
j1939_ac_recv() already break. And the work is in flight: Tetsuo Handa's
"struct j1939_ecu refcount leak" series is at v11 as of 2026-11-10, with
2/3 being the j1939_ecu_timer_cancel() lockup. Marc dropped the unmap_all()
version from the queue on 2026-10-15 saying the review bot was not happy
with it, so this area is currently somebody else's to land.

So: the suite does not catch this leak, that is true, and the teardown
workaround is why. But the regression test (close the last socket during
the hold-off, then delete the interface, expect the delete to return) only
means something on a fixed kernel. It should land with the stack fix, not
in front of it, and this series should keep the workaround and say so.

Thanks for the careful read of the timing assumptions; the two places I
would tighten are the ones above.

Chaosheng

