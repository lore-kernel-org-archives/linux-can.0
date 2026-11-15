Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742542;
	b=2cehpTDeRJWLjfIOqB1WP2kpF5cHrHPlFZv72Sdc8Ot8BL2Aoj9O3QbmiXhjVDBJe9ja
	 4C8zUKleNJFIUCVwzCpq1aP0h7yA5ERCr6r8hSFp0smww7Y3oyiQ95nKdL2Iq/o1fx3B3
	 jCM4iu+xUTGA2BvXD8cVWYhNoNIzMt9hTWxabDtno4dsRogNEIf8CV0cG0fLlmnXizW9b
	 wh6xPw4ARPg+h+5EgFB8DPF+TbbDTIhP9qN88OlZ05mqo1R7uEMtpoAG/M99qWW12njmo
	 P5bhsF1QTc3sVJjJ2PkMRWF3im32JlCf9sCIVG1FfTr/o94OofxkNQPGd5UVgn6S4JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742542;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=PbiNr82TG0uNcSBQKBPE033vWJ/s05j4HCkXNnJ1M8E=;
	b=KkVtTVaS6EFp0FuTuR5rFS1wfhmy+uhHe/y40OxrW5ns0Zqh+aLhP/wzwwCXotk5Fhpi
	 M+3sd11XO5grvn4yaBXvtkGCvmOqXMejSTWZ4Ub85T568yg1Du5vLssmOg1Jg5xH6ucRK
	 Ha74wVqug6Qd3KlYyJF/hY+bWfzRf8V5FLhXsMBobmQYpn5hOqQSF/oSxEDOcwR/DHuUv
	 OTcbn1lZU3h9bdui5EPBYyY8EgH4S/P3dw79xzJtM0evKLHGtSRAy3fkmP+/O8bXeKFMG
	 aXEhTMjrAXcPrGQAjDBo65zVxxDeW+u1BGHlA799c44Im6Z0uqTrYLJB679d3EfUpMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18C606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B18C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBZKGK026653;
	Sun, 15 Nov 2026 20:35:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBZJxq026648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:35:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1d96e742-0479-4c36-ad0a-a0aaeda0a4fc@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:35:20 +0900
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
Subject: [PATCH v14 0/6] can: j1939: make module more robust
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav311.rs.sakura.ne.jp

This series is intended to address the following problems.

## Problem 1: Possible UAF on module unload.

Since module refcount is currently associated with lifecycle of j1939
sockets, we need to make sure that all resources associated with socket
("struct j1939_priv", "struct j1939_ecu", "struct j1939_session") are
synchronously destructed before socket is destructed. Otherwise,
j1939_module_exit() can complete and memory for this module is unmapped
before j1939_ecu_timer_handler() or __j1939_ecu_release() or
j1939_session_destroy() or __j1939_priv_release() completes (i.e.
causing UAF).

Calling module_put(THIS_MODULE) from a module function which is not
possible to wait for completion of that function from that module's exit
function is a source of UAF. But calling module_put(THIS_MODULE) from a WQ
function which is possible to wait for completion from that module's exit
function using flush_workqueue() etc. is fine.

Fix problem 1 by deferring release steps of "struct j1939_priv" to WQ
context where we can call module_put(THIS_MODULE) while allowing
j1939_module_exit() to wait for completion using destroy_workqueue().

By this change, we no longer need to make sure that all resources
associated with socket ("struct j1939_priv", "struct j1939_ecu",
"struct j1939_session") are synchronously destructed before socket is
destructed, simplifying further fixes.

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

## Problem 6: Possible UAF on module unload (part 2).

To close a race window that j1939_module_exit() starts as soon as
j1939_priv_put(session->priv) from j1939_session_destroy() dropped
the module's refcount, defer actual release to WQ context which
j1939_module_exit() can wait for completion.

Also, to make sure that session->txtimer / session->rxtimer are no longer
running when the last user called j1939_session_put(), add a safeguard
that explicitly cancels session->txtimer / session->rxtimer before kfree().

[PATCH v14 1/6] can: j1939: fix possibility of UAF on module unload
[PATCH v14 2/6] can: j1939: add a safeguard to __j1939_priv_release_work()
[PATCH v14 3/6] can: j1939: fix possibility of list corruption in __j1939_ecu_release()
[PATCH v14 4/6] can: j1939: add a safeguard to __j1939_ecu_release_work()
[PATCH v14 5/6] can: j1939: fix "struct j1939_ecu" refcount leak
[PATCH v14 6/6] can: j1939: defer j1939_session_destroy() to WQ context
---
Changes since v13:
- Dropped "can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()" for now.
  Although sashiko will mention that this problem is not addressed, this problem is too complicated
  to handle within this series.
- Added "can: j1939: defer j1939_session_destroy() to WQ context", per findings by sashiko in v13.

Changes since v12:
- Added a cover letter and split the series into 6 logical patches (1 patch per problem).
- Deferred __j1939_priv_release() to WQ context to simplify "struct j1939_ecu" refcount leak fix
- Fixed findings by sashiko in v12.

 net/can/j1939/bus.c        |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 net/can/j1939/j1939-priv.h |    8 ++++++++
 net/can/j1939/main.c       |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 net/can/j1939/socket.c     |   10 +++++++++-
 net/can/j1939/transport.c  |   27 ++++++++++++++++++++++-----
 5 files changed, 168 insertions(+), 37 deletions(-)
