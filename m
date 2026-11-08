Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378614;
	b=C+WplygE5Mhe7lT27BpfWP7LSe8bH/SXdYk1mm30gifvhXPtY6I/9uvfFqYpbZVVGf+d
	 J3qR8yAeGoq7ylTWePi6iMJaodY3TkkXCtGDlAlYlSoEaD/5sj7x6qRo1lZVkMoGa1ZJm
	 bPmndxMWop0Gdz/lOgNrWR1zHl9r0i7SQuPLpEs18/d3VV7KYldPFE0a+TGGfiUYZnUfM
	 KImiX9lUdUFLSBYZ3WarCqi2Uef0E2PO2r2vhHDyY2SqIh0OCO1YgSN015XWnqPNHksiH
	 9aWciUJDcNgO3XjPYgok8D4iQvuOWVtmaHT8XPTF3TVPOAasrf+GUKfY2dFSRyLT40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378614;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=sghuBLzQTWvZcaG2JncQZwaTB18KQtwNU5j9xefbbG8=;
	b=GtQh+lL/f+AYSzWwhbyC4uwblAVE05+vx9NqKuYpxgrLQHWelQ2c0eh3A0rgFxYem5+i
	 yy8TdH/rrhVAmWDIwdXgXoc/WmJ7TBgJWrip93lBiGRFBVtKhr9OR26mgqYHZwBNBYRtU
	 EuDizV/GZVli8NEwO7qvdqLfI1Tm2hMwUG7XK5tR0CxeXpNSFZ1hsLIAtYwxpkdg0nAhd
	 1lheNtyPbbV4JccCmjCy6lozfkR2+KpSlZgl7QcWpXKNebecwNrq4Dltn5WpuguIjAu54
	 t6ueT6wff9Y79RmbyTys1mw/TMoV/J3JC05HWFqzoHj8hk4RgB7BsVvE8JdB9vNtDjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aEmWBD59;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E1606A31C;
	Wed, 11 Nov 2026 06:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aEmWBD59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=sghuBLzQTWvZcaG2JncQZwaTB18KQtwNU5j9xefbbG8=;
	b=aEmWBD598V7rNfeSDMwf9ZOFRgr5MnqfH5OvC/+M6FCwGC63VYNVeM4oQs8KKx
	SYcPfhH5IoZ4bS79NxQ2wHhJraJLQb8mn3g9eiSUrINej/uS633ZWVHYBAuwLgSU
	6PoGz2Z/IK+7+A694n3PMT8ZlepX/egxrsfDwpd8BSXcw=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v7 0/4] can: j1939: fix the abort timer and bound EDPO
Date: Sun, 08 Nov 2026 09:34:23 +0800
Message-ID: <179410166344.60581.3898011861151549156@163.com>
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
X-CM-TRANSID:_____wDXtBBdC_RqkOP+Gg--.8107S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4DKFyUCw1kCFWkCw13CFg_yoW5Ar4kpF
	Z3KF98Gr1kJ3y7Aw4fKF18XryYvws3XFyrXr12q3s0yay5GF18JF48Kw4Iga9Fk395C342
	vFnIqrn8Gr4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joHq7UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4x6xJ2r0C16XtwAA3A

v7 of the j1939 EDPO fix.  Two findings from the automated review of v6 were
real and both were in the session cancel path, so this is now a series:
patch 1 is the timer fix, patch 2 is the original EDPO bound check.

  [1/4] arms the abort timer under the session list lock.  Fixes two things
        at once: the hrtimer_cancel()/j1939_tp_rxtimer() deadlock, and the
        reference leak when a second unparsable frame re-enters the cancel
        path after the timers were killed.

  [2/4] is the original change: reject an ETP.CM_DPO that names a packet at
        or past pkt.total.  Without it a peer can move pkt.dpo past the end
        of the reassembled buffer, and the local EOMA loopback then hands a
        NULL skb to j1939_sk_recv().

  [3/4] guards j1939_session_completed() against that NULL anyway.  With
        [2/4] in place this should be unreachable; it turns a future
        regression in the offset arithmetic into a dropped datagram instead
        of a kernel panic.

  [4/4] rejects an oversized ETP.CM_CTS at the point where it is parsed,
        instead of letting it travel back as a bad EDPO offset.

Testing:

  - [2/4] alone was verified against a local vcan setup: an ETP session with
    ETP.CM_RTS size 1786 (256 packets) followed by ETP.CM_DPO packet 256 and
    an ETP.DT with sequence 0 gave a NULL dereference in j1939_sk_recv()
    3/3 times before the change and was rejected 3/3 times after it.

  - The T5/T6 hang from the review ([1/4]): two unparsable ETP.DT frames
    followed by "ip link del" left unregister_netdevice() waiting for the
    session reference; with the rearmed timer the session is deactivated
    500 ms after the second frame.

  - Each patch builds standalone; net/can/j1939/ is unchanged in behaviour
    for anything that does not involve an EDPO, a CTS or an abort.

Changes in v7:

  - Split into four patches, as promised in the reply to the v6 review.
  - [1/4] replaces the "waiting" branch with rearming the abort timer under
    the lock.  Re-checked the lock order: none of the callers of
    j1939_tp_set_rxtimeout() hold active_session_list_lock, so taking it for
    the rearm does not introduce a new ordering.
  - [2/4] uses J1939_XTP_ABORT_BAD_EDPO_OFFSET for the receiver, which is
    what the comment next to the definition describes and which had no
    callers; J1939_XTP_ABORT_ECTS_TOO_BIG is left to [4/4].
  - Revision history moved below the --- line, Author and Signed-off-by now
    match, and Closes: replaces Link: after Reported-by:.

Bounding the CTS packet number is [4/4] rather than part of [2/4], because
it addresses a different input and can be reviewed on its own.

Chaosheng Qu (4):
  can: j1939: arm the abort timer under the session list lock
  can: j1939: validate the EDPO packet number
  can: j1939: drop the message when the reassembled skb is gone
  can: j1939: reject a CTS that names more packets than the message has

 net/can/j1939/transport.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

