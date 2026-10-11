Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735123E334;
	Sun, 11 Oct 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732701; cv=none; b=GZ87nGJR2hGMHKprkPI08RcdDBncYVceQZ76YNPU1Ln+lINL36VMPGAi05sNMAhksMaJtmToYsCt8/+7ieatLgS5GgOcX5vxBNDH3Tl/7Ny+nCPZQVLn6DLA0DAtrHDEKA6iVUWFHgcP/L3uDlSpKzowSi9F4+dVkipVSaMvdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732701; c=relaxed/simple;
	bh=rjnn43cnTiGkjwVs51LgZ4fKxwUDFTjGC5Lwlq+8xXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H20EEnbAesXs1t0dZPnIq+tPXF1G+sGhzZAAsVuY23aTNGrffw6aQCRrXu+X0FIEu9+1Eh088O7UQt+zEtO+orOEmFeU6sTIZ/iSMMw86puYPXBIVuTUbdqoHooxmx609etm3WnltSZ5ZzYXOdkR+IJFb7H+z3lCysxzAh6/bBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=eWqGuQW7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="eWqGuQW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791732694; x=1792337494;
	i=alexander.hoelzl@gmx.net;
	bh=jklATDAxxn9i+/A+pZu4uX373T+RKpBAVGHvkmSpGHs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eWqGuQW7UghOTLP8Crjy7mOafhBYtyPQPfw3aRFuIYXGXtflNGBuI1Zz7hBGVnCB
	 oCd9YLKTJ1mFGXR0T7+9iqUrLCpjeqXk7L7JA4ReU+ydDK//I9p7ampw/BTssd4Dc
	 k8ngH8GAD02mlQOdS5T1sMLM0QvP7qZdfWEOjhVrqd4hSc4TJBXjXiGAH6T93QV+w
	 b5dTpssNIxpvbNSlKxyvjJXOwgbLTpVnNCUZuawM7+ucZL94Gdueu6R6Q8lkivlZr
	 q/SYL57lKSC9FP5GBSH/f8PlCt/4Rpb/NxPbgWAUOaYbmPgAaecnlXtb/duT7V/lg
	 6YyKL9HW31ZBwMwR5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1wUJ0d0UQH-00sTIL; Sun, 11
 Oct 2026 17:31:34 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH v3] can: j1939: fix potential race condition in BAM segmentation
Date: Sun, 11 Oct 2026 17:31:16 +0200
Message-ID: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:68wLWFklqbp77/uTVRzCvTivVScTIx7TVkvZNfz8YFLfOfVA4VG
 tlg0G6n9hsQ2JfIpeRVh9e9d7vGT2qqO/Tj1mYmQgHPuZY/jKkpc9NaDG9DOw9ggA9J+Llc
 /UnUfpTboIDAhx5gctQsPT9yzle5wa8WSbiUDb8E22P6OCUE6jnctH608rvuJUfapWrV3LL
 Z1ZpOJvTbJHWBK+BZ2yHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1CGGRp0/ps=;jo5SsDAmhZ0lGxlVhCq3XE2YhPX
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
 net/can/j1939/transport.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..c61a021880c0 100644
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
@@ -1806,8 +1814,13 @@ static void j1939_xtp_rx_rts(struct j1939_priv *pri=
v, struct sk_buff *skb,
 	session->last_cmd =3D cmd;
=20
 	if (cmd =3D=3D J1939_TP_CMD_BAM) {
-		if (!session->transmission)
+		if (!session->transmission) {
 			j1939_tp_set_rxtimeout(session, 750);
+		} else {
+			j1939_session_txtimer_cancel(session);
+			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
+			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
+		}
 	} else {
 		if (!session->transmission) {
 			j1939_session_txtimer_cancel(session);
@@ -1961,6 +1974,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_sessi=
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

