Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47F5392828;
	Fri, 18 Sep 2026 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700228; cv=none; b=J0g3LPnO0IMeklypMG+dnvDda2UpA9ZYqyyNVeUDoQ8GbkA5q7F+3G70qkn+EZyZ2bMEdSfAQz49kduuswTYzSZYOjxBYUXKy61FUhCYXd/TBdFmQmUZrwWxNBHCqxuz5w3lN74GhXd3o/Yhki2uqbhJc/Yy0b59akqTBTHBs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700228; c=relaxed/simple;
	bh=mBRqEP9TJjgmRTXwCpPUVGDXgTHCHpr1a1HFzB8joJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLX/7I2wuMKz+m/MbtItiFeopjul8Fnqn6bRMnJOdjWIzQfUMpFs1XGTgL/s/hr2hEdrh2fct8oILSgVlc96/xINjxuqKg/1CtBMm902div4E/AIlU6dpRwxZ+IC4bBSiqBPo5wE3oja3YNHJxhMZAGAZPhIL7Qe15ROkzytB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KK/OwESd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KK/OwESd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Il
	KVeaotHjF+lLwtJywJovhhhgtimgz6FNhz94t1SkQ=; b=KK/OwESdBlCqqB2tlk
	3czWr1mtqj0vpToCm6yjyCzTGXUO/bH3Rq+f+kVxDSBlc7Ba+ejmnJG9kDUmhlSs
	9bxPV9b6D7nkbEr3+3F0a5BzMz55ZxDF+AxAdjrsfnFgkK6WOl06CK22Q/XrzCYV
	1o7NHvOYEKnhWorBPqD+TdUjI=
Received: from vd-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X+FaqKxqMQl+BQ--.61271S4;
	Fri, 18 Sep 2026 10:56:35 +0800 (CST)
From: Xue Boyang <m18335910246@163.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	kernel@pengutronix.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m18335910246@163.com
Subject: [PATCH net 2/2] can: j1939: validate the DPO packet number
Date: Thu, 17 Sep 2026 21:56:15 -0500
Message-ID: <20260918025622.192582-3-m18335910246@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918025622.192582-1-m18335910246@163.com>
References: <20260918025622.192582-1-m18335910246@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+FaqKxqMQl+BQ--.61271S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45Kw4kAw13Xw18KryfZwb_yoW8CFyxpF
	Wak34UKryxGrsFyr48tFZ5XryI9Fn3J347WF1jy3s3Cwn8AFWrtFn0kFZFgayDGw4fuay3
	u3W2qa9rG34vq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8nY7UUUUU=
X-CM-SenderInfo: zpryjjavzrijiuw6il2tof0z/xtbC8gMItmqsqGMgTwAA3t

j1939_xtp_rx_dpo_one() copies the 18-bit packet number of the ETP.CM_DPO
command into session->pkt.dpo without any sanity check.  The value is
later used as a byte offset (pkt.dpo * 7) by
j1939_session_skb_get_by_offset(), both for TP.DT placement (combined
with dat[0] - 1) and for the final message distribution in
j1939_session_completed().

A DPO pointing past the end of the transfer has no valid meaning:
every legal window rebase satisfies pkt.dpo <= pkt.total.  Reject
out-of-range values and abort the session with J1939_XTP_ABORT_FAULT
instead of carrying them around, mirroring the error handling of
j1939_xtp_rx_dat_one().

Note that pkt.dpo == pkt.total combined with a DT frame of
dat[0] == 0 still encodes the final packet (dat[0] - 1 + pkt.dpo ==
pkt.total - 1) and therefore stays accepted by design; the NULL
handling in j1939_session_completed() from the previous patch covers
this case.  This patch only discards the clearly bogus values, so the
receive path no longer operates on offsets far outside the buffer.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Xue Boyang <m18335910246@163.com>
---
 net/can/j1939/transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ecf7f245f837..b09983d9c19c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1833,6 +1833,11 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 
 	/* transmitted without problems */
 	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	if (session->pkt.dpo > session->pkt.total) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+		return;
+	}
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.53.0

