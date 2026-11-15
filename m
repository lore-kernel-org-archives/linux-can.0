Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794720887;
	b=4sGP/GO6cqdq43TNbjriPfHqa0gl6CXV2Xq2qrSFFNK/DEV3kjSftKXpf1+J1OEvAvXt
	 y91z1R87lJWgZwKCfFPJUmAtaiZ27DXwoqZoImVlu+CyzJyABpgD4tNarqVeKxsQ6Uynl
	 N/cA4srg3dqNQVQ97DsSpfP2kG24Zz57BbqQNqDxN70R3+f1hbaU0T2BlGiWE0aCkG9/d
	 BrSwQkMxjtY7JYZzaIbMdm2XGqnAJeZ/6D9tIQb/tJxhf0vtbDOpaDjzz7oicsyPGvLFN
	 BeG6mXjvCkN/qoFtDG47YI1pI4oinzgMguNKROEcMGHZfXfQ9oDijdrwMgxmChPwKSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794720887;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=lC8Ly5Yf68Gh9Nv0+H1j0F1P8fYy4GEWYx2PHOC4+0E=;
	b=xxFw+LPIrccI9NT1JQ3BsUbDwRaB9jpaMIt3YEZ8OTeC6UExM7MzP7AcJtTrqJoz0R/Q
	 rhcZ9r6J7K5aUR/cffrMaRUGR3FsCpJ4q+4aBxaIK8zqGOxRC+vv1RP/zz6Qj36qmzege
	 HPV+n0AgbnDBZN+DEyPJA3Me3i1cnGCEmw6/zu/9PK2ZO7Vj7ksPW4oONmMPWI7zyCGW3
	 f/4XGIWbksJ8mjNiNKiMFftXshGbGTE+eDpgaRmspbuIR0lvotcXGGAIfEG7sxSFZhIS0
	 WPLktwkn7JYYhzA/WbAa/5PgyEPXuJyCecBZzhRlV92OnO9S7fHu4withgawoswii7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006F606A327
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 05:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B006F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AF5YEUJ071933;
	Sun, 15 Nov 2026 14:34:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AF5YEO3071930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 14:34:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 14:34:15 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v13 0/6] can: j1939: make module more robust
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp

This series is intended to address the following problems.

## Problem 1: Possible UAF on module unload.

Since module refcount is currently associated with lifecycle of j1939
sockets, we need to make sure that all resources associated with socket
("struct j1939_priv" and "struct j1939_ecu") are synchronously destructed
before socket is destructed. Otherwise, j1939_module_exit() can complete
and memory for this module is unmapped before j1939_ecu_timer_handler() or
__j1939_ecu_release() or __j1939_priv_release() completes (i.e. causing
UAF).

Calling module_put(THIS_MODULE) from a module function which is not
possible to wait for completion of that function from that module's exit
function is a source of UAF. But calling module_put(THIS_MODULE) from a WQ
function which is possible to wait for completion from that module's exit
function using flush_workqueue() etc. is fine.

Fix problem 1 by deferring release steps of "struct j1939_priv" to WQ
context where we can call module_put(THIS_MODULE) while allowing
j1939_module_exit() to wait for completion using destroy_workqueue().

By this change, we no longer need to make sure that all resources
associated with socket ("struct j1939_priv" and "struct j1939_ecu") are
synchronously destructed before socket is destructed, simplifying
further fixes.

## Problem 2: Possible UAF in __j1939_priv_release().

If a user calls j1939_ecu_put(ecu) with priv->lock held but without knowing
that this "struct j1939_ecu" is the last user of a "struct j1939_priv",
__j1939_priv_release_work() via __j1939_priv_release() from
j1939_priv_put() from __j1939_ecu_release() might call kfree(priv)
before priv->lock is released (i.e. causing UAF).

Fix problem 2 by adding a safeguard that delays kfree() in
__j1939_priv_release_work() until there is no priv->lock holder.

## Problem 3: Possible list corruption in __j1939_ecu_release().

Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
without priv->lock held for write, list corruption might happen if the
last user called j1939_ecu_put() without priv->lock held for write.

Instead of requiring all j1939_ecu_put() callers to hold priv->lock for
write, fix problem 3 by deferring release steps of "struct j1939_ecu"
to WQ context where we can unconditionally hold priv->lock for write.

By deferring to WQ context, readers might find ECUs which have already
reached __j1939_ecu_release(). Therefore, allow using an ECU only when
__j1939_ecu_release() is not yet called (indicated by ecu->kref > 0).

## Problem 4: Possible UAF in j1939_ecu_timer_handler().

Since pending ecu->ac_timer is not canceled during j1939_ecu_unmap_all()
or __j1939_rx_release(), ecu->ac_timer can call j1939_ecu_timer_handler()
after __j1939_ecu_release() or j1939_module_exit() (i.e. causing UAF).

Fix problem 4 by adding a safeguard that explicitly cancels ecu->ac_timer
before kfree(). The fix for problem 3 makes it possible to call
hrtimer_cancel() from __j1939_ecu_release_work().

## Problem 5: Possible "struct j1939_ecu" refcount leak.

Since

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed,
"struct j1939_ecu" refcount leaks.

Fix problem 5 by

  (1) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
  (2) making j1939_ecu_map_locked() no-op

when a netdev which is associated with j1939_priv is no longer registered
(indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
__j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

## Problem 6: Possible hard-lockup/deadlock in j1939_ecu_timer_cancel().

Since j1939_ecu_timer_cancel() is calling hrtimer_cancel() with priv->lock
held for write while j1939_ecu_timer_handler() takes priv->lock, a hard-
lockup (if CONFIG_PREEMPT_RT=n && CONFIG_SMP=y) or a deadlock between
priv->lock and cpu_base->softirq_expiry_lock (if CONFIG_PREEMPT_RT=y) will
happen when hrtimer_cancel() calls hrtimer_cancel_wait_running().

The comment for "struct j1939_priv"->lock says that priv->lock is used for
protecting "struct list_head ecus" and "struct j1939_addr_ent ents[256]".
But j1939_ac_process() is using priv->lock for also serializing timer
management across multiple frames. This makes it impossible to temporarily
drop priv->lock in order to safely call hrtimer_cancel().

Therefore, fix problem 6 by introducing two bool flags that implement
logical cancellation (negotiate hrtimer_try_to_cancel() == -1 condition)
and dropping address claim frames during logical cancellation.



[PATCH v13 1/6] can: j1939: fix possibility of UAF on module unload
[PATCH v13 2/6] can: j1939: add a safeguard to __j1939_priv_release_work()
[PATCH v13 3/6] can: j1939: fix possibility of list corruption in __j1939_ecu_release()
[PATCH v13 4/6] can: j1939: add a safeguard to __j1939_ecu_release_work()
[PATCH v13 5/6] can: j1939: fix "struct j1939_ecu" refcount leak
[PATCH v13 6/6] can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()
---
Changes since v12:
- Added a cover letter and split the series into 6 logical patches (1 patch per problem).
- Deferred __j1939_priv_release() to WQ context to simplify "struct j1939_ecu" refcount leak fix
- Fixed findings by sashiko in v12.

 net/can/j1939/address-claim.c |    7 +++-
 net/can/j1939/bus.c           |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 net/can/j1939/j1939-priv.h    |   12 +++++++-
 net/can/j1939/main.c          |   75 ++++++++++++++++++++++++++++++++++++++++++++------
 net/can/j1939/socket.c        |   10 ++++++
 5 files changed, 189 insertions(+), 36 deletions(-)
