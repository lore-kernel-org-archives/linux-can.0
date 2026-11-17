Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931033;
	b=qKtSD3cENyOdA28CkdGClLNYytk8J9VJ6+nLb8K/aZSKIY3l2cNBAbKOHkZflmk0/6oU
	 eTAIk11m0hzYzxb3a8owjRnhIr9zj7ywCbppIuT7vWPLUz4IXhswDZZ+YLOvJTM0HpMo+
	 7XDyfGpYB/ZE3Lh1y8JqIdMt19O3v0Aj8UhMZhlTR/olZU8+ci1Rn/ANQiOFDCUszfhzO
	 YiyDgt+njmPLMGXYxiSlaRPHG+1l0HEK7QEy4u4iioayGJkb32p3/pQaVYSH0V6M+77of
	 lblWb8gTHL5Z1VQ5T+igLtHgWzfreNpuiOtKp0/ohowQzwbe9mBMnndffn5DHP+10sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931033;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Status:X-Anti-Virus-Server;
	bh=y/JUGppThD4MI7kd8qOG2Phy4Jw0eDsJ1f0wf5H/AQU=;
	b=ZYNGVsKDbbOmVja/zl6p2OOJZ9iqAuu5NYTJtNHgCfdf8Vo6oJhTjbZ05nNkarUfBR+G
	 aBFlB8QYXE0ljdZIjTBj8fTkvk9WMV1+qB0IsmD8lQd9Z2InaJenaLmwsYflZ6mh+DWum
	 GvnmLFA6mUUxOs/wFRHQO0dteG8g9PM+CsRFpbITk7DTzlr3rRPT5/IPp10566FK9uQT5
	 DPxa302D37c9FWljiN8WXhl6zXYHOmTRKeRsEzTW0OMh/i2ZrwLXPkQKi0wYX0lr/DCdw
	 KorYHurdERZuOCO65YUB2mBSHG25Wz9w4GXKzmAipZucuylZaKllL0zIxTDretSC5FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB7606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 15:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AHFudHD029826;
	Wed, 18 Nov 2026 00:56:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AHFuXZs029802
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 00:56:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Date: Wed, 18 Nov 2026 00:56:32 +0900
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
Subject: [PATCH v15 0/3] can: j1939: make module more robust
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp

This series is intended to address the following problems.

# Problem 1

Since module refcount is currently associated with lifecycle of j1939
sockets, we need to make sure that all resources associated with socket
("struct j1939_priv", "struct j1939_ecu", "struct j1939_session") are
synchronously destructed before socket is destructed. Otherwise,
j1939_module_exit() can complete and memory for this module is unmapped
and cause UAF.

# Problem 2

This module takes a refcount upon arming a hrtimer and drops that refcount
when the hrtimer is fired or canceled, but nothing guarantees that the
callback is no longer running when the last refcount is dropped. We need
to make sure that hrtimer callbacks are no longer running before calling
kfree(). But we can't use hrtimer_cancel() from atomic context.

# Problem 3

Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
without priv->lock held for write, list corruption might happen if the
last user called j1939_ecu_put() without priv->lock held for write. But
requiring all j1939_ecu_put() callers to hold priv->lock for write might
be a difficult change.

# Problem 4

Since

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

# Problem 5

Since j1939_ecu_timer_cancel() is calling hrtimer_cancel() with priv->lock
held for write while j1939_ecu_timer_handler() takes priv->lock, a hard-
lockup (if CONFIG_PREEMPT_RT=n && CONFIG_SMP=y) or a deadlock between
priv->lock and cpu_base->softirq_expiry_lock (if CONFIG_PREEMPT_RT=y) will
happen when hrtimer_cancel() calls hrtimer_cancel_wait_running().


[PATCH v15 1/3] can: j1939: fix possibility of UAF
[PATCH v15 2/3] can: j1939: fix "struct j1939_ecu" refcount leak
[PATCH v15 3/3] can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()
---
Changes since v14:
- Reorganized series, based on review comments by netdev-bot+sashiko in v14.
- Re-added "can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()"
  using a different approach.

Changes since v13:
- Dropped "can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()" for now.
  Although sashiko will mention that this problem is not addressed, this problem is too complicated
  to handle within this series.
- Added "can: j1939: defer j1939_session_destroy() to WQ context", per findings by sashiko in v13.

Changes since v12:
- Added a cover letter and split the series into 6 logical patches (1 patch per problem).
- Deferred __j1939_priv_release() to WQ context to simplify "struct j1939_ecu" refcount leak fix
- Fixed findings by sashiko in v12.

 net/can/j1939/address-claim.c |    4 +++
 net/can/j1939/bus.c           |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 net/can/j1939/j1939-priv.h    |   11 ++++++++++
 net/can/j1939/main.c          |   48 ++++++++++++++++++++++++++++++++++++++++-------
 net/can/j1939/transport.c     |   23 +++++++++++++++++++---
 5 files changed, 137 insertions(+), 30 deletions(-)
