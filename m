Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111488;
	b=SBLEn4WBfSt6KeyBiiKHiSUtLkbFyqWzZbZZYVuUb3EqIzWhoqt+vlbXj3qP3SaJT2QL
	 ttZQZVfYkz8XielizE7g3ml0XPOp+jdjAunDklpBhFFYqcQ+junq7qa56U6Uz3mtDBoz4
	 hcbLKhqbDQ75IzzH2j15qCaGNn95CfxrVgdzEypYVsvxs4NoNLMbE/EcHW8SniSWIDXmD
	 9dh0O3bv5uaqqiXw21yxR/419HVH8F4xkWPrcDuAK/M/J4XqbbEixu/6bR2/e7Ri6x3eP
	 HtiapEjpHcqr0XHlIJ8dVHuSp4nDMctw1mpcQ2CeifXS/rZx1Q7DQUy2HqS9S8QNhEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111488;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jpK1l1F5pW/ydaH6n2XF7Hl01Ho02PvXdb7j5xI6DNE=;
	b=JApXzMu71YyH0Ge1p0ktIO1hTM3v3bT0aFZ8XaLhp6+6NsPvUxWO1Kp6AX6asxS6nOwZ
	 RKYpa6HbR5Vv2taAoKt3D3gNjuN7AAASkQjzI+kKyO8zVKcaxwJLUX4dJe8W78+Ou5Kxa
	 7TU6xLZXZMq8pJUpiuBb5aOCcs/bipkHp8dpMctYK9m0GHv8j/H76gQcolbzZgYbo2ISc
	 dmZSNFuZOG1PTuWijcKMlyyooYg7roe8R8ORHVv1LoyfVHjfiMlwwOhaZxkcHAdSNp+BZ
	 JBUp0IvWRXASfIglu+ocgNZw2ROnxfXRBZaTZBCvDetsN1X6AUnPJc1YTn2cVswRQrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=K1Fx9THo;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F6fXxLZ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96561606A320
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96561606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=K1Fx9THo;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F6fXxLZ8
ARC-Seal: i=1; a=rsa-sha256; t=1793111474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VRGkPnAVWdVZ5XwqWrb281GO2YSy/QLuhgwivDprqtjWfCwPjB14MFrScpvKoCiuDK
    VAbi1XuqIx35AK+daf1uzDaSp0vqvfPRdWAKY5PT7la19FFayoa6WWQcAI2CQiM77P4A
    LDMzaw/Ac5byt7GLkd0cjceFBLKbclvtFJn2zezFWPbGvn17WnNfTFZUHUDZkQPcldVh
    ZNcbuoRo62z9ZbWSCYy7AT7sL0k49eeqmUD3sh9kuKgq1FXgZp88lbu0KR4zsoXK6ymh
    zX/3p6s6+2NU5ll+WuNlPG2ZghjZMKtfgchzXPP7Qp+KeCUOGOfWdLY/WSjEN3s+GWlk
    R0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jpK1l1F5pW/ydaH6n2XF7Hl01Ho02PvXdb7j5xI6DNE=;
    b=o+Buq2qBmgYyNL7AwdhBC/G1ZHLaWaLp9XII1qzxuhaERyOL2DJ0l8B7TV4LDiuCPa
    i5w8NYdbIZ54wO+1K/pJWnsbHWWlwPw5WVHVvZuEWpFnqDaaba3SEpkoGPcHNzhpUBip
    YJZCsh2xnGkBdbb1zPyY8But6zkLvwIdiWACpOIoGJyjPkjJHbfdEdMbEo/wKaVfANX1
    IppT06QUKLIx4DkCsfz8o88ryFUray0J7sdfUlnRkxfe10e74HQ9jdymn8ny5HJPAy/3
    G6FeQZ83W4t/6DVRg82Y9PgVfY40wpdy3xg0SPnhb2j8tySAsmzBEON4MeAN/3OAs2B2
    eiag==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jpK1l1F5pW/ydaH6n2XF7Hl01Ho02PvXdb7j5xI6DNE=;
    b=K1Fx9THoROq/Nd+XHkxhcKxS+DGWVTTS6W/umZA4upO4fgq+TyjDEt5W/5koAtJFe2
    +F7imAC42BhYpa+p1Bgc5LxeYnN8rwCSenF89LoXX9YaDl4A+bW74vsoomKhxT/FT4um
    dUjgPhyR8jySJ7tpg+yhrqTv3dZnaj+wvnQYLYpSyHnkTZq/F9eCv6WQLJ3okobdAZn2
    B1FxT5m7g4JNLk1ntzCiIvYoh+r7Ugmw00AiGOfTJuKG7vY/v2Hvjcfjofj8eWNKHjIF
    oSs+fOLqjCIrC6U8eGKn024Mwk/C/vSkYqP92Jft3cda4XVs2xRRHzeFWZURz/gj9A9N
    dRxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=jpK1l1F5pW/ydaH6n2XF7Hl01Ho02PvXdb7j5xI6DNE=;
    b=F6fXxLZ8EhvFuBQWk2YH/ofoQ+sGppRg1kcju4hOza6VhTOhs4KbFsXt01JjLiy6BO
    3OgGlOLusPiqm1ToS9Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVEAL5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 27 Oct 2026 15:31:07 +0100
Subject: [PATCH v12 3/7] can: protect the receive lists with a per-device
 lock
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-can-rx-lock-v12-3-eb5afc2d8b9b@hartkopp.net>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Norbert Szetei <norbert@doyensec.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=38286;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=jMyUZ0dD0pS55xn8B+lfpvTekiDw4Om9aHPcKPjYFAk=;
 b=sN4ZXqgu96A6wgSrPi71zDqpOuXbSG0IKiKBmWTWMUtz92M0IOitDnXY1J/B+2d1cZEh6SCQC
 gX6vMjYFfSTBuIWksAtHouEWNQfhvMCg+IcLvMJZusxRJ8qSiLCwo03
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The receive lists of a CAN device are located in the device's
can_ml_priv and travel with the device when it is moved to another
network namespace. But they are protected by the per-netns
rcvlists_lock. So can_rx_unregister() needs dev_net(dev) to pick the
right lock and silently returns when the passed namespace does not
match dev_net(dev) anymore.

isotp_release() and bcm_release() leave their notifier list before they
take any lock that serializes against the netdev notifier, which runs
under RTNL. When the bound device is moved to another namespace in this
window, the notifier skips the socket and the release path has to remove
the filters itself. isotp_release() passes the socket's namespace, which
does not match dev_net(dev) anymore. bcm_rx_unreg() passes dev_net(dev),
which can_rx_unregister() reads again for its check, so a namespace
change between both reads makes the check fail as well. In both cases
can_rx_unregister() silently returns. As can_rx_register() stores
rcv->sk without a reference, the remaining receivers point to the freed
socket (isotp) or the freed op (bcm):

  BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
  Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
   can_rcv_filter+0x4af/0x8c0
   can_receive+0x28d/0x3c0
   can_rcv+0x2a9/0x310
   __netif_receive_skb_one_core+0x21a/0x260
   process_backlog+0x210/0x760

Besides this, the lists of a device are protected by the rcvlists_lock
of the namespace that is passed in. Callers which pass dev_net(dev) read
it at different times, so the same lists may be modified under the locks
of different namespaces while the device is moved.

Taking RTNL in these release paths is no option: raw_bind(),
raw_setsockopt() and raw_release() already hold RTNL while adding and
removing up to CAN_RAW_FILTER_MAX filters per socket, which unprivileged
users can trigger repeatedly and which makes RTNL a global bottleneck.

Instead fix the root cause and add a spinlock to struct
can_dev_rcv_lists, which protects the receive lists of a CAN device or
the 'any' CAN device lists of a namespace. It is initialized in
can_set_ml_priv(), which is used by all CAN network devices. With this,
can_rx_unregister() finds the subscription independently of the
current namespace of the device. The protocols keep the device valid
with their tracked references. The per-netns rcvlists_lock only protects
the receive list statistics anymore, and CAN_RAW, CAN_BCM and CAN_ISOTP
pass the namespace that has been used for can_rx_register().

So isotp_release() and bcm_release() now remove their filters correctly
without RTNL, and raw_release(), raw_setsockopt(), raw_bind() and
isotp_bind() do not need RTNL anymore and add and remove their filters
under lock_sock(). To serialize bind() with NETDEV_UNREGISTER, bind()
publishes the device inside the RCU section of its lookup, and
raw_notify() and isotp_notify() recheck the bound device under lock_sock().
As RTNL does not keep NETDEV_DOWN out of bind() anymore, bind() checks
IFF_UP after publishing the bound device, with a barrier pair against
raw_notify() and isotp_notify(), so a down transition during bind() is
still reported with ENETDOWN.

Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v12:
- rebased on the IFF_UP check change in patch 2, the resulting code is
  unchanged
- moved from patch 6 to patch 3 in front of "can: proc: remove pointers
  from CAN specific proc output" (context change in raw.c only, no
  functional change)
- v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-6-3b9a2b829dab@hartkopp.net/

Changes in v11:
- rebased to net/main without "can: raw: remove redundant NULL check
  before netdev_hold()": keep the NULL check of ro->dev before
  netdev_hold() in raw_bind() as found in net/main
- v10: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v10-6-281c4b556a1a@hartkopp.net/

Changes in v10:
- rebased on the reworked patch 5: isotp_bind() sets so->ifindex before
  the registrations, removes the echo receiver when the RX registration
  fails and resets so->ifindex together with the published so->dev when
  bind() fails
- v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-6-7ef2a2b5c2b4@hartkopp.net/

Changes in v8:
- rebased on the new patch "can: isotp: check the return values of
  can_rx_register() in isotp_bind()": isotp_bind() resets the published
  so->dev again when the registration of a receiver fails
- isotp_bind(): check IFF_UP at the end of a successful bind(), as
  raw_bind() does, so that a failing bind() does not report ENETDOWN
- isotp_notify(): report NETDEV_DOWN only for a bound socket. As
  isotp_bind() sets so->bound before its IFF_UP check, a failing
  isotp_bind() can not get a needless ENETDOWN from the notifier anymore
- isotp_sendmsg() / isotp_recvmsg(): read so->bound with READ_ONCE(), as
  it is written with WRITE_ONCE() now
- raw_setsockopt(): moved copying the user space data outside of
  lock_sock() to a separate patch to keep this patch focused on the
  locking changes and to ease review
- v7: https://lore.kernel.org/linux-can/20261022114202.180023-6-socketcan@hartkopp.net/

Changes in v7:
- raw_bind() / isotp_bind(): report ENETDOWN before release_sock(), so
  that a concurrent NETDEV_UNREGISTER waiting for lock_sock() in
  raw_notify() / isotp_notify() can not have its ENODEV overwritten by
  ENETDOWN (Sashiko review)
- raw_notify() / isotp_notify(): report ENODEV for NETDEV_UNREGISTER
  before release_sock() for consistency (Sashiko review)
- v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/

Changes in v6:
- isotp_bind(): check the device (CAN device, MTU) before publishing
  so->dev, so bind() can not fail after so->dev has become visible to
  isotp_notify(). A failing bind() can not get a needless ENETDOWN from
  a concurrent NETDEV_DOWN anymore (Sashiko review)
- v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/

Changes in v5:
- raw_bind() / isotp_bind(): check IFF_UP after publishing the bound
  device, with an smp_mb() pair against raw_notify() / isotp_notify() for
  NETDEV_DOWN, so a down transition during bind() is reported with
  ENETDOWN again, as with RTNL before (Sashiko review). isotp_bind()
  already published so->dev before the IFF_UP check, but without a
  barrier the load could still pass the store.
- raw_bind() no longer reports ENETDOWN when bind() fails
- rcvlists_lock comment names the rcv_entries(_max) stats (Sashiko review)
- can_rx_unregister() kernel-doc and commit message: @net should be the
  namespace of can_rx_register(), otherwise only the statistics become
  imprecise (j1939, Sashiko review)
- v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/

Changes in v4:
- rebased on linux-can-next/testing: the context in raw_bind() changed
  with "can: raw: remove redundant NULL check before netdev_hold()",
  which made v3 fail to apply
- added "can: proc: skip stats calculation after reset in
  can_stat_update()" from linux-can-next/testing to the base sequence
- no functional change
- v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/

Changes in v3:
- not RFC anymore, sent as new series with the patches 1-3 from the
  linux-can-next pull request to build on top of mainline (see cover letter)
- commit message: describe the isotp and bcm cases separately (bcm passes
  dev_net(dev), which can_rx_unregister() reads again for its check) and
  mention that the lists of a device could be modified under the locks of
  different namespaces
- can_rx_unregister() kernel-doc: @net also selects the 'any' CAN device
  lists for @dev == NULL
- v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/

Changes in v2:
- v1 relied on the NETDEV_UNREGISTER rebroadcast in
  netdev_wait_allrefs_any() to catch a bind() racing with the notifier,
  which is not sent on a namespace change. raw_bind() and isotp_bind() now
  publish the device inside the RCU section of dev_get_by_index_rcu()
  (CAN_RAW: new ro->bind_dev hint with smp_store_release() /
  smp_load_acquire(), CAN_ISOTP: so->dev is published early and reset
  when bind() fails)
- moved the implementation details from the commit message to the notes
- shortened the code comments
- replaced the rebind rate measurement with an RTNL latency measurement
- v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Notes:

- bind() vs. NETDEV_UNREGISTER: Both on unregistration and on a
  namespace change, unlist_netdevice() and synchronize_net() precede
  NETDEV_UNREGISTER. bind() publishes the device (ro->bind_dev /
  so->dev) inside the RCU section of dev_get_by_index_rcu(). So either
  the notifier sees it after synchronize_net() and handles the socket
  under lock_sock(), or the lookup does not find the unlisted device and
  bind() fails with -ENODEV. The NETDEV_UNREGISTER rebroadcast in
  netdev_wait_allrefs_any() is not relied on, as it does not happen on a
  namespace change.

- raw_notify() / isotp_notify() keep a lockless READ_ONCE() fast path,
  so RTNL only waits for lock_sock() of sockets that are bound or being
  bound to the vanishing device. CAN_RAW needs the separate
  ro->bind_dev hint, as ro->dev still points to the previously bound
  device until a rebind completes. ro->bind_dev is never dereferenced;
  a stale value only causes a needless lock_sock(). raw_notify() reads
  ro->bind_dev with smp_load_acquire() before ro->dev, paired with
  smp_store_release() in raw_bind(): A later bind() can only overwrite
  ro->bind_dev after the previous bind() has set ro->dev and released
  lock_sock(). Otherwise the notifier could see a stale ro->dev and the
  ro->bind_dev of a subsequent failing rebind to another device, and
  miss the binding. CAN_ISOTP does not support rebinding and publishes
  so->dev after checking the device and resets it when the registration
  of a receiver fails. bcm_notify() always takes lock_sock() and
  bcm_rx_setup() looks up the device under lock_sock(), so bcm needs no
  extra handling.

- raw_setsockopt(): The dev->reg_state check is only a shortcut now
  (READ_ONCE()) and does not catch a namespace change. raw_notify()
  waits for lock_sock() and removes the filters set by raw_setsockopt().

- NETDEV_DOWN: raw_notify() / isotp_notify() check ro->dev / so->dev
  locklessly. They are written with WRITE_ONCE() in bind() and in the
  notifier. IFF_UP is cleared in __dev_close_many() before
  netif_close_many() or __dev_notify_flags() send NETDEV_DOWN in the
  same context, and bind() checks IFF_UP after publishing the bound
  device. With an smp_mb() on both sides, either the notifier sees the
  binding or bind() sees the cleared IFF_UP. isotp_notify() additionally
  requires so->bound, which isotp_bind() sets before its IFF_UP check, so
  a failing isotp_bind() is not reported.

- j1939 benefits as well: After a namespace change its
  can_rx_unregister() with dev_net(ndev) picked the rcvlists_lock of the
  wrong namespace. The receive list statistics may still become
  imprecise in this case, as before.

- Tested v8 on a lockdep + KASAN + failslab kernel and on a kernel
  without debug options (numbers from the debug kernel):
  - 10 min CAN_RAW / CAN_BCM / CAN_ISOTP traffic and procfs reads in two
    namespaces while moving the CAN device between them (2220 moves)
  - CAN_RAW / CAN_ISOTP bind and CAN_RAW rebind churn (incl. failing
    rebinds to a non-CAN device) against 1001 namespace moves, checking
    that no filters are left on the device in the other namespace, and
    against 609 device deletions
  - bind() vs. NETDEV_DOWN: bind() while the device is toggled down/up,
    no missed ENETDOWN in 23024 CAN_RAW and 3906 CAN_ISOTP checks
  - the same bind churn with failslab on the can_receiver cache (-ENOMEM
    in can_rx_register()): no leaks, no "receive list entry not found"
  - socket option set/get/error checks for CAN_RAW and CAN_ISOTP
  - bcm_release() with a stalled procfs reader does not block RTNL
  - RTNL latency (no-op SIOCSIFMTU on lo) under CAN_RAW 512 filter
    churn: avg ~1 us, max ~0.1 ms (before: avg ~250 us, max ~24 ms)
---
 include/linux/can/can-ml.h |  3 ++
 include/net/netns/can.h    |  2 +-
 net/can/af_can.c           | 39 ++++++++++++--------
 net/can/bcm.c              | 43 +++++++---------------
 net/can/isotp.c            | 89 ++++++++++++++++++++++++++++------------------
 net/can/raw.c              | 88 +++++++++++++++++++++++++++++++++------------
 6 files changed, 160 insertions(+), 104 deletions(-)

diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 1e99fda2b380..cfefa4a385be 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -43,10 +43,11 @@
 #define CAN_ML_H
 
 #include <linux/can.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/spinlock.h>
 
 /* exposed CAN device capabilities for network layer */
 #define CAN_CAP_CC BIT(0) /* CAN CC aka Classical CAN */
 #define CAN_CAP_FD BIT(1) /* CAN FD */
 #define CAN_CAP_XL BIT(2) /* CAN XL */
@@ -57,10 +58,11 @@
 #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
 
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 struct can_dev_rcv_lists {
+	spinlock_t lock; /* protects the receive lists and entries */
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
 	int entries;
 };
@@ -79,10 +81,11 @@ static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
 }
 
 static inline void can_set_ml_priv(struct net_device *dev,
 				   struct can_ml_priv *ml_priv)
 {
+	spin_lock_init(&ml_priv->dev_rcv_lists.lock);
 	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
 }
 
 static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
 {
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..54f23681e0d4 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -27,11 +27,11 @@ struct netns_can {
 	struct proc_dir_entry *bcmproc_dir;
 #endif
 
 	/* receive filters subscribed for 'all' CAN devices */
 	struct can_dev_rcv_lists *rx_alldev_list;
-	spinlock_t rcvlists_lock;
+	spinlock_t rcvlists_lock; /* protects the rcv_entries(_max) stats */
 	struct timer_list stattimer; /* timer for statistics update */
 	struct can_pkg_stats *pkg_stats;
 	struct can_rcv_lists_stats *rcv_lists_stats;
 
 	/* CAN GW per-net gateway jobs */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index dc27ace43719..167b2dc40eeb 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -460,13 +460,14 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
 	if (!rcv)
 		return -ENOMEM;
 
-	spin_lock_bh(&net->can.rcvlists_lock);
-
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+
+	spin_lock_bh(&dev_rcv_lists->lock);
+
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	rcv->can_id = can_id;
 	rcv->mask = mask;
 	atomic_long_set(&rcv->matches, 0);
@@ -476,10 +477,13 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv->sk = sk;
 
 	hlist_add_head_rcu(&rcv->list, rcv_list);
 	dev_rcv_lists->entries++;
 
+	spin_unlock_bh(&dev_rcv_lists->lock);
+
+	spin_lock_bh(&net->can.rcvlists_lock);
 	rcv_lists_stats->rcv_entries++;
 	rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
 					       rcv_lists_stats->rcv_entries);
 	spin_unlock_bh(&net->can.rcvlists_lock);
 
@@ -507,10 +511,18 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
  * @func: callback function on filter match
  * @data: returned parameter for callback function
  *
  * Description:
  *  Removes subscription entry depending on given (subscription) values.
+ *  The receive lists of a CAN device are protected by a per-device lock,
+ *  so the subscription is found even when the device has been moved to
+ *  another network namespace after can_rx_register(). The caller has to
+ *  ensure that @dev stays valid, e.g. by holding a reference to @dev or
+ *  RTNL. @net should be the namespace that has been used for
+ *  can_rx_register(). It selects the 'any' CAN device lists for
+ *  @dev == NULL and is otherwise only used for the receive list
+ *  statistics, which become imprecise when another namespace is passed.
  */
 void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		       canid_t mask, void (*func)(struct sk_buff *, void *),
 		       void *data)
 {
@@ -520,16 +532,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev && !can_get_ml_priv(dev))
 		return;
 
-	if (dev && !net_eq(net, dev_net(dev)))
-		return;
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 
-	spin_lock_bh(&net->can.rcvlists_lock);
+	spin_lock_bh(&dev_rcv_lists->lock);
 
-	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
@@ -545,30 +555,30 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	 * As this case may potentially happen when closing a socket while
 	 * the notifier for removing the CAN netdev is running we just print
 	 * a warning here.
 	 */
 	if (!rcv) {
+		spin_unlock_bh(&dev_rcv_lists->lock);
 		pr_warn("can: receive list entry not found for dev %s, id %03X, mask %03X\n",
 			DNAME(dev), can_id, mask);
-		goto out;
+		return;
 	}
 
 	hlist_del_rcu(&rcv->list);
 	dev_rcv_lists->entries--;
 
+	spin_unlock_bh(&dev_rcv_lists->lock);
+
+	spin_lock_bh(&net->can.rcvlists_lock);
 	if (rcv_lists_stats->rcv_entries > 0)
 		rcv_lists_stats->rcv_entries--;
-
- out:
 	spin_unlock_bh(&net->can.rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
-	if (rcv) {
-		if (rcv->sk)
-			sock_hold(rcv->sk);
-		call_rcu(&rcv->rcu, can_rx_delete_receiver);
-	}
+	if (rcv->sk)
+		sock_hold(rcv->sk);
+	call_rcu(&rcv->rcu, can_rx_delete_receiver);
 }
 EXPORT_SYMBOL(can_rx_unregister);
 
 static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
@@ -821,10 +831,11 @@ static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.rcvlists_lock);
 	net->can.rx_alldev_list = kzalloc_obj(*net->can.rx_alldev_list);
 	if (!net->can.rx_alldev_list)
 		goto out;
+	spin_lock_init(&net->can.rx_alldev_list->lock);
 	net->can.pkg_stats = kzalloc_obj(*net->can.pkg_stats);
 	if (!net->can.pkg_stats)
 		goto out_free_rx_alldev_list;
 	net->can.rcv_lists_stats = kzalloc_obj(*net->can.rcv_lists_stats);
 	if (!net->can.rcv_lists_stats)
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 60406439a13f..9288b96724da 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -962,11 +962,11 @@ static void bcm_remove_op(struct bcm_op *op)
 }
 
 static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 {
 	if (op->rx_reg_dev == dev) {
-		can_rx_unregister(dev_net(dev), dev, op->can_id,
+		can_rx_unregister(sock_net(op->sk), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
 		netdev_put(dev, &op->rx_reg_dev_tracker);
@@ -988,25 +988,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 
 			/* disable automatic timer on frame reception */
 			op->flags |= RX_NO_AUTOTIMER;
 
-			/*
-			 * Don't care if we're bound or not (due to netdev
-			 * problems) can_rx_unregister() is always a save
-			 * thing to do here.
-			 */
 			if (op->ifindex) {
-				/*
-				 * Only remove subscriptions that had not
-				 * been removed due to NETDEV_UNREGISTER
-				 * in bcm_notifier()
-				 *
-				 * op->rx_reg_dev is a tracked reference taken
-				 * when the subscription was registered, so it
-				 * stays valid here even if a concurrent
-				 * NETDEV_UNREGISTER already unlisted the dev.
+				/* Only remove subscriptions that had not been
+				 * removed in bcm_notify(). op->rx_reg_dev keeps
+				 * the device's receive lists accessible.
 				 */
 				if (op->rx_reg_dev)
 					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
@@ -1934,10 +1923,11 @@ static int bcm_release(struct socket *sock)
 		spin_lock(&bcm_notifier_lock);
 	}
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
+	/* bcm_notify() can not access this socket anymore */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
@@ -1947,33 +1937,24 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
 		list_del_rcu(&op->list);
 		bcm_remove_op(op);
 	}
 
-	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-		/*
-		 * Don't care if we're bound or not (due to netdev problems)
-		 * can_rx_unregister() is always a save thing to do here.
-		 */
+	list_for_each_entry(op, &bo->rx_ops, list) {
 		if (op->ifindex) {
-			/*
-			 * Only remove subscriptions that had not
-			 * been removed due to NETDEV_UNREGISTER
-			 * in bcm_notifier()
-			 *
-			 * op->rx_reg_dev is a tracked reference taken
-			 * when the subscription was registered, so it
-			 * stays valid here even if a concurrent
-			 * NETDEV_UNREGISTER already unlisted the device.
+			/* Only remove subscriptions that had not been removed
+			 * in bcm_notify(). op->rx_reg_dev keeps the device's
+			 * receive lists accessible.
 			 */
 			if (op->rx_reg_dev)
 				bcm_rx_unreg(op->rx_reg_dev, op);
-		} else
+		} else {
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
-
+		}
+		cond_resched();
 	}
 
 	synchronize_rcu();
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3efdce022c55..626316596c6a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1122,11 +1122,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	u32 my_gen;
 	u32 old_cfecho;
 	int off;
 	int err;
 
-	if (!so->bound || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
+	if (!READ_ONCE(so->bound) || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	/* claim the socket under so->rx_lock: this serializes the claim
 	 * with the RX path and with sendmsg()'s own error paths below, so
 	 * none of them can ever see a transfer mid-claim
@@ -1167,11 +1167,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	spin_unlock_bh(&so->rx_lock);
 
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile => recheck
 	 */
-	if (!so->bound) {
+	if (!READ_ONCE(so->bound)) {
 		err = -EADDRNOTAVAIL;
 		goto err_out_drop;
 	}
 
 	/* PDU size > default => try max_pdu_size */
@@ -1413,11 +1413,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int ret = 0;
 
 	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	if (!so->bound)
+	if (!READ_ONCE(so->bound))
 		return -EADDRNOTAVAIL;
 
 	skb = skb_recv_datagram(sk, flags, &ret);
 	if (!skb)
 		return ret;
@@ -1487,15 +1487,15 @@ static int isotp_release(struct socket *sock)
 		spin_lock(&isotp_notifier_lock);
 	}
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister
-	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 * the tracked reference so->dev keeps the device's receive lists
+	 * accessible, even after a namespace change
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
 			can_rx_unregister(net, so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
@@ -1506,15 +1506,13 @@ static int isotp_release(struct socket *sock)
 				  isotp_rcv_echo, sk);
 		netdev_put(so->dev, &so->dev_tracker);
 	}
 
 	so->ifindex = 0;
-	so->bound = 0;
+	WRITE_ONCE(so->bound, 0);
 	so->dev = NULL;
 
-	rtnl_unlock();
-
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
 	 * for in-flight isotp_rcv() callers to finish, so this call must not
 	 * be skipped just because so->bound is already 0 here.
@@ -1577,11 +1575,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with isotp_notify() */
 	lock_sock(sk);
 
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
@@ -1603,23 +1601,28 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
 
-	dev = dev_get_by_index(net, addr->can_ifindex);
-	if (!dev) {
-		err = -ENODEV;
-		goto out;
-	}
-	if (!can_get_ml_priv(dev)) {
+	/* Publish the device inside the RCU section of the lookup: When it
+	 * is unlisted concurrently, either isotp_notify() sees so->dev after
+	 * synchronize_net() or the lookup fails. Check the device before
+	 * publishing it.
+	 */
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
+	if (!dev || !can_get_ml_priv(dev))
 		err = -ENODEV;
-		goto out_put_dev;
-	}
-	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
+	else if (READ_ONCE(dev->mtu) < so->ll.mtu)
 		err = -EINVAL;
-		goto out_put_dev;
+	if (!err) {
+		dev_hold(dev);
+		WRITE_ONCE(so->dev, dev);
 	}
+	rcu_read_unlock();
+	if (err)
+		goto out;
 
 	/* switch to new settings */
 	so->ifindex = dev->ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
@@ -1642,39 +1645,43 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 					  isotp_rcv_echo, sk);
 			goto out_put_dev;
 		}
 	}
 
-	/* report a down device only for a successful bind() */
-	if (!(dev->flags & IFF_UP))
-		notify_enetdown = 1;
-
-	so->bound = 1;
+	WRITE_ONCE(so->bound, 1);
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
-	so->dev = dev;
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
+	/* Either isotp_notify() sees so->dev on NETDEV_DOWN or we see the
+	 * cleared IFF_UP, pairs with isotp_notify()
+	 */
+	smp_mb();
+	if (!(READ_ONCE(dev->flags) & IFF_UP))
+		notify_enetdown = 1;
+
 out_put_dev:
-	if (err)
-		so->ifindex = 0; /* reset on failed bind() */
+	/* revert so->ifindex and so->dev on failed bind() */
+	if (err) {
+		so->ifindex = 0;
+		WRITE_ONCE(so->dev, NULL);
+	}
 
-	/* remove potential reference from dev_get_by_index() */
+	/* remove reference from the device lookup */
 	dev_put(dev);
 out:
-	release_sock(sk);
-	rtnl_unlock();
-
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
+	release_sock(sk);
+
 	return err;
 }
 
 static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 {
@@ -1866,16 +1873,25 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	struct sock *sk = &so->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->dev != dev)
+	if (msg == NETDEV_DOWN)
+		smp_mb(); /* pairs with isotp_bind(), see raw_notify() */
+
+	/* lockless fast path, see raw_notify() */
+	if (READ_ONCE(so->dev) != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
+		if (so->dev != dev) {
+			release_sock(sk);
+			break;
+		}
+
 		/* remove current filters & unregister */
 		if (so->bound) {
 			if (isotp_register_rxid(so))
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
@@ -1886,20 +1902,23 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 					  isotp_rcv_echo, sk);
 			netdev_put(so->dev, &so->dev_tracker);
 		}
 
 		so->ifindex = 0;
-		so->bound  = 0;
-		so->dev = NULL;
-		release_sock(sk);
+		WRITE_ONCE(so->bound, 0);
+		WRITE_ONCE(so->dev, NULL);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
+		release_sock(sk);
 		break;
 
 	case NETDEV_DOWN:
+		if (!READ_ONCE(so->bound))
+			break;
+
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 		break;
 	}
diff --git a/net/can/raw.c b/net/can/raw.c
index e1d741a25be3..d6517f71cade 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,10 +83,11 @@ struct uniqframe {
 
 struct raw_sock {
 	struct sock sk;
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	struct net_device *bind_dev; /* hint for raw_notify(), no reference */
 	struct list_head notifier;
 	int ifindex;
 	unsigned int bound:1;
 	unsigned int loopback:1;
 	unsigned int recv_own_msgs:1;
@@ -222,10 +223,11 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
 {
 	int err = 0;
 	int i;
 
 	for (i = 0; i < count; i++) {
+		cond_resched();
 		err = can_rx_register(net, dev, filter[i].can_id,
 				      filter[i].can_mask,
 				      raw_rcv, sk, "raw", sk);
 		if (err) {
 			/* clean up successfully registered filters */
@@ -256,13 +258,15 @@ static void raw_disable_filters(struct net *net, struct net_device *dev,
 				struct sock *sk, struct can_filter *filter,
 				int count)
 {
 	int i;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count; i++) {
 		can_rx_unregister(net, dev, filter[i].can_id,
 				  filter[i].can_mask, raw_rcv, sk);
+		cond_resched();
+	}
 }
 
 static inline void raw_disable_errfilter(struct net *net,
 					 struct net_device *dev,
 					 struct sock *sk,
@@ -303,20 +307,35 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 
 static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		       struct net_device *dev)
 {
 	struct sock *sk = &ro->sk;
+	struct net_device *bind_dev;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->dev != dev)
+	if (msg == NETDEV_DOWN)
+		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
+
+	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
+	 * Read it before ro->dev, pairs with smp_store_release() in
+	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
+	 */
+	bind_dev = smp_load_acquire(&ro->bind_dev);
+	if (READ_ONCE(ro->dev) != dev &&
+	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
+		if (ro->dev != dev) {
+			release_sock(sk);
+			break;
+		}
+
 		/* remove current filters & unregister */
 		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
 			netdev_put(dev, &ro->dev_tracker);
 		}
@@ -324,17 +343,17 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
 		ro->bound = 0;
-		ro->dev = NULL;
+		WRITE_ONCE(ro->dev, NULL);
 		ro->count = 0;
-		release_sock(sk);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
+		release_sock(sk);
 		break;
 
 	case NETDEV_DOWN:
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
@@ -379,10 +398,11 @@ static int raw_init(struct sock *sk)
 	struct raw_sock *ro = raw_sk(sk);
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
 	ro->dev              = NULL;
+	ro->bind_dev         = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
 	ro->dfilter.can_mask = MASK_ALL;
 	ro->filter           = &ro->dfilter;
@@ -429,17 +449,19 @@ static int raw_release(struct socket *sock)
 		spin_lock(&raw_notifier_lock);
 	}
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
+	/* remove current filters & unregister
+	 * the tracked reference ro->dev keeps the device's receive lists
+	 * accessible, even after a namespace change
+	 */
 	if (ro->bound) {
 		if (ro->dev) {
-			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+			raw_disable_allfilters(net, ro->dev, sk);
 			netdev_put(ro->dev, &ro->dev_tracker);
 		} else {
 			raw_disable_allfilters(net, NULL, sk);
 		}
 	}
@@ -454,11 +476,10 @@ static int raw_release(struct socket *sock)
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
@@ -477,30 +498,38 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 	if (len < RAW_MIN_NAMELEN)
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	rtnl_lock();
+	/* lock_sock() serializes the binding with raw_notify() */
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
-		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
+		/* Publish the device inside the RCU section of the lookup:
+		 * When it is unlisted concurrently, either raw_notify() sees
+		 * ro->bind_dev after synchronize_net() or the lookup fails.
+		 */
+		rcu_read_lock();
+		dev = dev_get_by_index_rcu(sock_net(sk), addr->can_ifindex);
+		if (dev) {
+			dev_hold(dev);
+			/* pairs with smp_load_acquire() in raw_notify() */
+			smp_store_release(&ro->bind_dev, dev);
+		}
+		rcu_read_unlock();
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
 		}
 		if (!can_get_ml_priv(dev)) {
 			err = -ENODEV;
 			goto out_put_dev;
 		}
 
-		if (!(dev->flags & IFF_UP))
-			notify_enetdown = 1;
-
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
 		if (err)
@@ -515,39 +544,47 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
 			if (ro->dev) {
-				raw_disable_allfilters(dev_net(ro->dev),
+				raw_disable_allfilters(sock_net(sk),
 						       ro->dev, sk);
 				/* drop reference to old ro->dev */
 				netdev_put(ro->dev, &ro->dev_tracker);
 			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
 			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
-		ro->dev = dev;
+		WRITE_ONCE(ro->dev, dev);
 		if (ro->dev)
 			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+
+		if (dev) {
+			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
+			 * we see the cleared IFF_UP, pairs with raw_notify()
+			 */
+			smp_mb();
+			if (!(READ_ONCE(dev->flags) & IFF_UP))
+				notify_enetdown = 1;
+		}
 	}
 
 out_put_dev:
-	/* remove potential reference from dev_get_by_index() */
+	/* remove reference from the device lookup */
 	dev_put(dev);
 out:
-	release_sock(sk);
-	rtnl_unlock();
-
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 	}
 
+	release_sock(sk);
+
 	return err;
 }
 
 static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 		       int peer)
@@ -597,12 +634,17 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		} else if (count == 1) {
 			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
 				return -EFAULT;
 		}
 
+		/* The reg_state check is only a shortcut: On a concurrent
+		 * unregistration or namespace change raw_notify() waits for
+		 * lock_sock() and removes the filters set here.
+		 */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED) {
 			if (count > 1)
 				kfree(filter);
 			return -ENODEV;
 		}
 
@@ -646,12 +688,14 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		if (copy_from_sockptr(&err_mask, optval, optlen))
 			return -EFAULT;
 
 		err_mask &= CAN_ERR_MASK;
 
+		/* lockless shortcut, see CAN_RAW_FILTER */
 		dev = ro->dev;
-		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
+		if (ro->bound && dev &&
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
 
 		/* remove current error mask */
 		if (ro->bound) {
 			/* (try to) register the new err_mask */
@@ -754,17 +798,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	int err;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	err = raw_setsockopt_locked(sock, optname, optval, optlen);
 
 	release_sock(sk);
-	rtnl_unlock();
 
 	return err;
 }
 
 static int raw_getsockopt(struct socket *sock, int level, int optname,

-- 
2.53.0

