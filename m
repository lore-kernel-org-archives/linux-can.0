Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CC455175;
	Sun, 11 Oct 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731548; cv=none; b=Mp6nibId+TTREyESXcPlDVlwvUWTFkciuF8zArb/GcAxBrqIjiyiplsHb8l9r7D5xSTyNoTPYDK93/cXVgnJPc1B7ZzVI1DTz/F7QM/Sd7ZzNcok+NgvYSbJAoUA71q3reNwJYS7VxhPmDCIeRd0KIskUsMmbGvWwxoMcsaFyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731548; c=relaxed/simple;
	bh=0bNWprz8EiqmcoOJXg+FddnkOyH/Bpq5MZuMSKUjtA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oN8REoMUL5Gm8F8Q2UGLeWHsNYousw5J1KVRHJmPuiDBPuAzevnj58xa1U6ipAsWK5jK9sfW3pFNvtw3nxYEQkuzf79dDIPiIKmDQaEkVKQ0dodKM/iEePtHAMVq4ex28N3hKN+0WBZX3Tx0AChKmWOdLpePGL8cGiT4ZOZPmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=p+pxHXXL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="p+pxHXXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791731543; x=1792336343;
	i=alexander.hoelzl@gmx.net;
	bh=v6vO6WCS+FkUmVpxNuPm+Zek9AeWwwRc5lbFFoG7oS0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p+pxHXXL0cfQUR0KwhX+Aae8tmleC+n2/+j6StLMOsvS+GzPL7l8HTbfMIl25+xo
	 gTKHBzxwFuGCh0VleawXp//rXEB1H6Fu8oDT0JwlI/Fcf18jlTGTYEspeESrTJBW9
	 yl/3nUbnfOqPY7bVGi4k1fiz3hvUrRg2M8NEKNLKc4jDcCkB9XJTXBwdsaacRvrfa
	 WTy/lLyJDFm8gv3jcGq7/GDkUOLKdQlIiRVo12wXFA54PTOxQT+tzLpgVZeD1a/dd
	 sjvNjrdHhlzDtT7Wm1d93Ft50c5Pd7oJY0p1quF+zSu8VHq8aW9Y/F4zQpRe0lvSO
	 d272xcx4z4ugGh9iSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1wcEsB38OO-00ysJi; Sun, 11
 Oct 2026 17:12:23 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v2] can: j1939: fix potential race condition in BAM segmentation
Date: Sun, 11 Oct 2026 17:11:52 +0200
Message-ID: <20261011151216.118932-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3OFHm3DbpC3aO7LfSNwOVWcSZFnzjhfR949ubYxvUC4+awLq9Nu
 gjA80AYbJtnUAuc40D6ztd93cTYNtdScjgKOs2OM84Fp0u3pTxV+C+sq4/c/hvYHKzkmkQt
 nNfSTdQtZz+ylQgoMaQDkMRrnbBEAPq/X7WR+IZPGcZlORXAHddTkjRll4nD8mP5zlbOfYe
 N3r4bOR81Cnx5uoUjyiMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P18uZo4EQLg=;rvEYk73Xb6O5DKZd5D/FousaF6n
 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

There is a potential race condition in segmented messages using
the BAM protocol. When initiating a tx BAM session, first
the BAM itself is sent and then the txtimer is scheduled.
The tx timeout for BAM is currently hardcoded to 50ms.
As soon as the loopbacked BAM frame, acting as a tx
acknowledgment is received, the session->last_cmd field
is set to J1939_TP_CMD_BAM.
When the txtimer elapses the function j1939_xtp_txnext_transmiter
is called, which checks session->last_cmd and continues with
sending a data frame only if session->last_cmd is set to J1939_TP_CMD_BAM.
If there is a high busload and the BAM frame is stuck in the controller
for some time, the txtimer might elapse before the looped back frame is
received and the session will stall.
This problem becomes very obvious when changing the tx timeout
for BAMs to the lowest value allowed by the specification of 10ms.
This patch fixes the problem by moving the tx timer scheduling for
BAM transmissions such that the timer is scheduled when the tx ack
is received. This also fixes the problem that when consecutive
data frames are stuck in the controller they will be sent
without any delay.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/transport.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..ec0679aded09 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -7,7 +7,6 @@
 //                         Marc Kleine-Budde <kernel@pengutronix.de>
 // Copyright (c) 2017-2019 Pengutronix,
 //                         Oleksij Rempel <kernel@pengutronix.de>
-
 #include <linux/can/skb.h>
 #include <net/can.h>
=20
@@ -26,6 +25,9 @@
 #define J1939_TP_CMD_BAM 0x20
 #define J1939_TP_CMD_ABORT 0xff
=20
+#define J1939_TP_BAM_FRAME_SPACING_MS 50
+#define J1939_TP_BAM_ECHO_TIMEOUT_MS 250
+
 #define J1939_ETP_CMD_RTS 0x14
 #define J1939_ETP_CMD_CTS 0x15
 #define J1939_ETP_CMD_DPO 0x16
@@ -766,7 +768,6 @@ static int j1939_session_tx_rts(struct j1939_session *=
session)
=20
 	session->last_txcmd =3D dat[0];
 	if (dat[0] =3D=3D J1939_TP_CMD_BAM) {
-		j1939_tp_schedule_txtimer(session, 50);
 		j1939_tp_set_rxtimeout(session, 250);
 	} else {
 		j1939_tp_set_rxtimeout(session, 1250);
@@ -866,12 +867,19 @@ static int j1939_session_tx_dat(struct j1939_session=
 *session)
 		session->last_txcmd =3D 0xff;
 		pkt_done++;
 		session->pkt.tx++;
-		pdelay =3D j1939_cb_is_broadcast(&session->skcb) ? 50 :
-			j1939_tp_packet_delay;
=20
-		if (session->pkt.tx < session->pkt.total && pdelay) {
-			j1939_tp_schedule_txtimer(session, pdelay);
+		/* For BAM transfer the tx timer is scheduled after receiving
+		 * the looped back frame as a tx ack. This means that here the
+		 * timer is only scheduled for directed transfers.
+		 */
+		pdelay =3D j1939_tp_packet_delay;
+		if (j1939_cb_is_broadcast(&session->skcb)) {
 			break;
+		} else {
+			if (session->pkt.tx < session->pkt.total && pdelay) {
+				j1939_tp_schedule_txtimer(session, j1939_tp_packet_delay);
+				break;
+			}
 		}
 	}
=20
@@ -1806,8 +1814,12 @@ static void j1939_xtp_rx_rts(struct j1939_priv *pri=
v, struct sk_buff *skb,
 	session->last_cmd =3D cmd;
=20
 	if (cmd =3D=3D J1939_TP_CMD_BAM) {
-		if (!session->transmission)
+		if (!session->transmission) {
 			j1939_tp_set_rxtimeout(session, 750);
+		} else {
+			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
+			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
+		}
 	} else {
 		if (!session->transmission) {
 			j1939_session_txtimer_cancel(session);
@@ -1961,6 +1973,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_sessi=
on *session,
 	} else if (remain) {
 		if (!session->transmission)
 			j1939_tp_set_rxtimeout(session, 750);
+		else if (j1939_cb_is_broadcast(&session->skcb)) {
+			/* cancel the txtimer to avoid leaking session references */
+			j1939_session_txtimer_cancel(session);
+			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
+			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
+		}
 	} else if (do_cts_eoma) {
 		j1939_tp_set_rxtimeout(session, 1250);
 		if (!session->transmission)
=2D-=20
2.56.0

