Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655304;
	b=zY5hK9FWfsWXl46LhGdLCL26QWexiWpl8DrGViltQPBZLfyI+CWJmNq1+51VZXOHY0Jz
	 whjXSXYypeWADxhZHBBT+Tefziegt8drewe5MUI+ylI3vjwqFw5wZqZO6cRVcRu8UgLyR
	 3/gUqYEPUOYkP4Kytl59454GAi/BbQ7vd/ZoZgmlKAfRZmRhUkjWjFbiywvlZw5V2Rnhv
	 KPCrRhxXkuN1cRIGs/oT4594XEAFDI/ISCPcnvIo91IGOwrVpseh7FAOTUgBqNHojxx11
	 pGnXm6bUjmwy3KgpRZ0y2PtT8cnkpG3Xg1YIjNhowGBkqxjrlcNPpPeXF2PVO3yJbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655304;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=X1wKvtC7kKFokkEkFL8BTC6HA5jeLIJj7teLcMrhAXo=;
	b=mcxZFnJxhTSe44m+vqWFx6uO7+t9P508/u/V4oqO04lSLsal9VQtVe4BnE/Qx1CcNLhx
	 hwQMN3BQ4yK+5BYHSaWLV4y4JSAg6v0eC6fvNLlvk620BbLIU4xzEFpt9mFZkOCDLHc+C
	 SbqMvHOqilL6kxJ7HnuNo/POCJ3EkUhFyHf0NswY3oBpeLnVnOPs9PovDcz2hmDDnkmi1
	 71ERGnG2BB7L2pKjHFhtWpldgF3Uoel8DySaB9PMAVQGb+KdZ8q+9gFU8ZYN0k1jzVVkq
	 Tme4xjkGqzEcDNv2ntw2WFNbkJWr1Za8DCuFkl1wq9cUzpyFCPmKT7griFtX3kev9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=okn0yEtx;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868E606A319;
	Thu, 22 Oct 2026 07:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D868E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=okn0yEtx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=X1wKvtC7kKFokkEkFL8BTC6HA5jeLIJj7teLcMrhAXo=;
	b=okn0yEtxzHV+UXRsC4KIDO/T9jorqzGGeq+yvifPhT66Y4qougEnVNiz+rZ9Tu
	Z/9XKHze/llvilZD2+t8YDAD+3yv+MoHQVCV0alnoujSZG/QvA35eP/KfDjICgUt
	pnZ2sgwawsg30B3wB7Mw7eh5RnQmBHiPBISat1qNLHjU0=
From: Quchaosheng <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v5] can: j1939: validate the EDPO packet number
Date: Thu, 22 Oct 2026 15:47:45 +0800
Message-Id: <179265526538.315101.6846048415570762476@163.com>
In-Reply-To: <20261020032219.80117-1-quchaosheng000406@163.com>
References: <20261020032219.80117-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:_____wD3_6+hv9lqtqyBBg--.62602S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1fur48tryxJF15Cr13XFb_yoWrurW7pr
	ZxKFy3KrWDGrs3Zrn3tF4DXFyFvrs3JF43WF17K34fA3Z8Cr4SyFWUKr1FgayDtwn2k3y2
	vF43WwnxGr1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvks9UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AIpnmrZv6IcigAA3p

v6 addresses both High findings, the Medium, and the two Low comments.

> [High] can j1939_session_cancel() deadlock against the rxtimer callback?

Yes, and j1939_tp_txtimer()'s -EOVERFLOW and default branches reach it
without cancelling the rxtimer first.  The fix is in the helper:

  j1939_session_cancel()
    j1939_session_list_lock()
    j1939_tp_set_rxtimeout()
      j1939_session_rxtimer_cancel()
        hrtimer_cancel()      <- waits for a callback that wants our lock

v6 cancels the rxtimer before taking the lock, then arms the abort timer
with hrtimer_start() under the lock.  hrtimer_start() does not wait for the
callback, so the cancel/arm ordering the callers rely on is preserved
without the synchronous cancel inside the critical section.

> [High] What happens if the next bad frame is an ETP.DT or an ETP.CM_CTS?

The session is stranded.  The timers are cancelled, j1939_session_cancel()
sees WAITING_ABORT and does nothing, and nothing is left to deactivate it.

v6 handles that in the helper: a session already in WAITING_ABORT is
deactivated there instead of being left for a timer the caller has just
cancelled.  That covers ETP.DT, ETP.CM_CTS and second-RTS without touching
any of them.  In j1939_xtp_rx_rts_session_active() the receiver branch then
does what the transmitter branch already did, so both become one
unconditional deactivation.

Measured on v7.3-rc7 under QEMU/KVM on vcan, one tree and one config
(defconfig + CONFIG_CAN_J1939=3Dy, CONFIG_CAN_VCAN=3Dy, CONFIG_LOCKDEP=3Dy,
CONFIG_DEBUG_SPINLOCK=3Dy), three kernels differing only in this hunk.  Each
case is a standalone guest.

             A           B             C           D
  stock      SLOT-STUCK  REF-DROPPED*  SLOT-STUCK  never returns
  v5         SLOT-STUCK  never returns SLOT-STUCK  never returns
  v6         SLOT-FREE   returns       SLOT-FREE   returns

  A  out-of-range EDPO, then an unparsable DT; is a second ETP.CM_RTS from
     the same SA/DA answered with a CTS?
  B  same as A, last socket closed, does `ip link del vcan0` return?
  C  two unparsable DTs, no EDPO; second RTS answered?
  D  two unparsable DTs; does `ip link del vcan0` return?

* B on stock aborts with code 6, UNEXPECTED_DATA, which leaves the session
  to the abort timer, and the timer deactivates it as the device goes down.
  A is still stuck on stock.

C and D are the case you described.  On stock the second unparsable DT
cancels the abort timer the first one armed, so the session stays on
active_session_list; D prints "unregister_netdevice: waiting for vcan0 to
become free. Usage count =3D 7" until the guest is killed.  Pre-existing, as
you said.  v5 fixed only the caller it added, so A through D are unchanged
from stock.

> [Medium] The transmitter role sends BAD_EDPO_OFFSET, and the commit
> message does not match the code

Both correct.  v6 sends J1939_XTP_ABORT_ECTS_TOO_BIG for a transmission
session and J1939_XTP_ABORT_BAD_EDPO_OFFSET for a receiver.  With a real
J1939 sender and an injected oversized CTS, v5 puts 12 on the wire and v6
puts 15.

The commit message now says what the code does:

  - tx_acked is pkt - 1 and is not truncated when written to dat[2..4];
    only dat[1] wraps.  "An offset that cannot be encoded" was wrong.
  - the check runs on the echo, after j1939_session_tx_dpo() has put the
    EDPO on the bus.  Before the patch the transmitter did not run with
    that offset either: j1939_session_tx_dat() failed with -ENOBUFS and the
    session ended in -ENETUNREACH.
  - the force-deactivation paragraph now describes the helper.

> [Low] The j1939_session_completed() comment

The example cannot happen with the range check in place, so the comment now
describes the guard as defense in depth.

> [Low] The comment says pkt.dpo "has to stay inside the message", but
> j1939_session_tx_dpo() has another, unbounded writer

The comment now says it bounds the receiver-side writer, names
j1939_session_tx_dpo() and the unchecked ETP.CM_CTS packet number, and
says that is a separate change.

The single-EDPO case and a legal 1786-byte transfer were run on all three
kernels as well: stock panics with "BUG: kernel NULL pointer dereference,
address: 0x18" in j1939_sk_recv(), and v6 delivers all 256 packets intact.

Not reproduced: the lockdep race the rxtimer change fixes.  It needs a timer
callback racing a caller and none of these sequences schedules one at the
right moment.  No lockdep report or call trace appeared in any run.

pw-bot: cr

  net/can/j1939/transport.c | 81 ++++++++++++++++++++++++++++++++++++++++++--=
-------
  1 file changed, 66 insertions(+), 15 deletions(-)

