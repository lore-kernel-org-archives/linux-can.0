Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9B41D21F
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576044; cv=none; b=f+CREDASrUuFwYCMK68W4RuY2yh81Y92zJKtlVoYoYO6ItyAZqjTi7vJ4dTonMCdFEQkcioLTrRLw0RFyx3UyOZugt/c9o806uDnoEF7b5RSef31gMV/EDJGQWb7SYmGzt6FFvJgQFw2NbFd8lui4wo7yFMsI2R4EFve2lZse10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576044; c=relaxed/simple;
	bh=g5Gjw3IzAe7/knSsX/zuM7s6pCoTujnIsNbK8G68sFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfdEPijuBmiyAkl2E0+cVymLCuF5CxstM+uzLi7Eg9lJ1DeYHLwH+AiFk1aOITEZyod3So3cdmGPl055xkxeNS3OwDkY9TRd3vvDYAdhrCYM0dor74sj6Cu6nlDi4rB0/7fEPyNsq93+IYeKIDrdJI79tp98nEJjmNd8ERNg5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgagS3YX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgagS3YX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedda4c154so2047542a12.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576040; x=1788180840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8/sUQGbhm0rzxqY2kDdfzdZpT2sKv66wG53evR61DI=;
        b=EgagS3YX2esp64X56Rf7Pg7U5Z/m0Z3qQFiGAzWd+d78Eu5p1neqFuqPm4tZU1Nsh8
         MDZPKVmoIY9YLTofbe4pFDVRSI7NsujplQE5lQjqdE9tKLcgQ23tZ9Ck5KWkAvU7zgRD
         TEf1cmL7/wy1G5jZhdDJb2+Ak7VhpFSaKc7WBCwHTggYHvhSXpKCcZ0a3oS1gLRvdEX8
         hYy6VkgAUh5lr1m8afcnmSBQNVzvaqtokZ/gqsl27SIFA8fZ18TRS8XxTOkzMUuLtI0w
         /p18cI4cV2GPJmrFUVg7yeLUR1xSRFmMAa3Dx/ebwSvfOF4QDL+dHnH5YPStypYIuYEq
         VCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576040; x=1788180840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8/sUQGbhm0rzxqY2kDdfzdZpT2sKv66wG53evR61DI=;
        b=TplkPf5n2Zl9xqeYyEdEPcKQ5AnDwPcGM6LJR8KMFPBwxFMyvV5oQc4WTDmJYuJxXw
         wgyup4uL8oe++wEhx1C0rBb10OFolcdeanK0wtJNeeoIi6G7HlsA8v4Z1k2HbmZmsrWW
         QK2ZzcX4XYv7oIzJ2kgC+QIVScjDYbpWrx0125SDS8kZpfHHQWfao+3+sSXzfCpN9aJZ
         wlzQDJfEIPtHcpn94lpfPdzuvF8dhHOiLus/NIp6bdIsap6SIkCyrrETITI4nXgEqsHG
         iJMAi8woAY4vQ12HqyseuS8TUkVL5K/FlNvj2zCzc5qUAfChZ1Va6KCDzXOhYPr+5Dul
         GtHg==
X-Gm-Message-State: AFuF++nsmWalJeExu/li5aChNeHsx4cuFyR7jUYelQnUWrVxXd2I9uWU
	zx9SOxZhYJ5wKle4C+ENCmXEnZdA/zqoeWBMsf3LH1AbzgpH3ZwVA4OC4/oayhMx
X-Gm-Gg: AR+sD12paXjOyXNoJsOVRyPLncp1BEcECEGImLozPhAfuw/Xsdte29R7qmo3t/vYtoo
	AF6p+8GE79VhTCgqmet88+IbV8H1cFAeCw4uHTkqm/njQaponEUJL6CybgWn2c264gQCIPfk7Pk
	8nF7LzRQGA7hLLs6L2rJsC5FtqHHhV0ZHO+qatPE0ZbviYObJhc6wzw0UPljDDKj6anNpp7yDnb
	YjUm8g7xAGZC6dp22HaKMc1fTywkGEqMfr3Dvixjn8LZYAsqsBwYVU5ZBvJODIZ9uAJJX08bOrJ
	dovlbu3iTXGKyClQ9L3xFmskc/xVX7Zwb+WEV1UQuOljyM1q6p7ho6zuQQrnDWbm8Q9Mmk5sTMD
	8umIk5He8uzu4pm/LrNQOHl2JCBF7JFWyl0/oV89HFA7PFDDzj1tcfI5pj7iVmG2Ms6/h0/6jP5
	HWpxKVzvLZR0+ct3lP8wGJse4zL1ZpWYdqtcjKabd7e9pKeonLGOYzWuklvoc8Pwin/YRwZ3gQi
	s1bCQ3IndG8BT1+AvetE0OktA==
X-Received: by 2002:a17:90a:c88b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-395c2f4b17emr51268255a91.0.1787576040330;
        Mon, 24 Aug 2026 05:54:00 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8e0ebbfsm4179719a91.0.2026.08.24.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:53:59 -0700 (PDT)
From: yewentian395 <yewentian395@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yewentian395 <yewentian395@gmail.com>
Subject: [PATCH] qcan: isotp: implement N_Ar timeout handling for FC transmission
Date: Mon, 24 Aug 2026 20:53:43 +0800
Message-Id: <20260824125343.2700828-1-yewentian395@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add N_Ar (ISO 15765-2) timeout logic to detect FC frame transmission
failures on the receiver side. Previously, isotp_send_fc() fired the
FC and immediately started the N_Cr timer (rxtimer) without confirming
that the FC was actually transmitted onto the CAN bus.

Introduce ISOTP_WAIT_FC_TX_CONFIRM state and fc_artimer to implement
a two-phase approach:

  1. N_Ar phase: after can_send(FC), wait for local echo confirmation
  2. N_Cr phase: after echo arrives, start rxtimer to wait for next CF

Key design points:

- fc_artimer and rxtimer are mutually exclusive (never both active)
- Timer handler uses guard condition (no spinlock) to avoid deadlock
  with hrtimer_cancel() callers, following isotp_rx_timer_handler pattern
- CF arrival during WAIT_FC_TX_CONFIRM acts as implicit FC confirmation
  (CF from remote proves FC was transmitted successfully)
- New FF/SF arrival during WAIT_FC_TX_CONFIRM cancels fc_artimer
- ISOTP_FC_OVFLW does not enter N_Ar phase (fire-and-forget)
- can_send() failure triggers immediate rollback

State machine extension (RX path only):

  WAIT_DATA -> isotp_send_fc(CTS) -> WAIT_FC_TX_CONFIRM
  WAIT_FC_TX_CONFIRM -> FC echo / CF arrival -> WAIT_DATA
  WAIT_FC_TX_CONFIRM -> fc_artimer timeout -> IDLE (ECOMM)
  WAIT_FC_TX_CONFIRM -> new FF/SF -> IDLE (reset)

Signed-off-by: yewentian395 <yewentian395@gmail.com>
---
 net/can/isotp.c | 93 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1efa377f002e..2bdedfc1d1f8 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -125,12 +125,14 @@ MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
 
 #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
 #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+#define ISOTP_FC_AR_TIMEOUT 1	/* 1 sec - N_Ar timeout for FC tx confirm */
 
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
 	ISOTP_WAIT_FC,
 	ISOTP_WAIT_DATA,
+	ISOTP_WAIT_FC_TX_CONFIRM,	/* RX: waiting for local FC echo */
 	ISOTP_SENDING,
 	ISOTP_SHUTDOWN,
 };
@@ -155,7 +157,7 @@ struct isotp_sock {
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer, txfrtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer, fc_artimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
@@ -210,6 +212,25 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static enum hrtimer_restart isotp_fc_ar_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     fc_artimer);
+	struct sock *sk = &so->sk;
+
+	if (so->rx.state != ISOTP_WAIT_FC_TX_CONFIRM)
+		return HRTIMER_NORESTART;
+
+	so->rx.state = ISOTP_IDLE;
+	so->rx.len = 0;
+
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
+
+	return HRTIMER_NORESTART;
+}
+
 static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 {
 	struct net_device *dev;
@@ -256,22 +277,37 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	ncf->flags = so->ll.tx_flags;
 
-	can_send_ret = can_send(nskb, 1);
-	if (can_send_ret)
-		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
-			       __func__, ERR_PTR(can_send_ret));
-
-	dev_put(dev);
-
 	/* reset blocksize counter */
 	so->rx.bs = 0;
 
 	/* reset last CF frame rx timestamp for rx stmin enforcement */
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
-	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
-		      HRTIMER_MODE_REL_SOFT);
+	if (flowstatus == ISOTP_FC_CTS) {
+		/* cancel rxtimer before entering N_Ar phase */
+		hrtimer_cancel(&so->rxtimer);
+
+		/* enter N_Ar confirmation phase */
+		so->rx.state = ISOTP_WAIT_FC_TX_CONFIRM;
+		hrtimer_start(&so->fc_artimer,
+			      ktime_set(ISOTP_FC_AR_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+	}
+
+	can_send_ret = can_send(nskb, 1);
+	if (can_send_ret) {
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
+		if (flowstatus == ISOTP_FC_CTS) {
+			hrtimer_cancel(&so->fc_artimer);
+			so->rx.state = ISOTP_IDLE;
+			so->rx.len = 0;
+		}
+		dev_put(dev);
+		return 1;
+	}
+
+	dev_put(dev);
 	return 0;
 }
 
@@ -447,6 +483,9 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 
+	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM)
+		hrtimer_cancel(&so->fc_artimer);
+
 	hrtimer_cancel(&so->rxtimer);
 	so->rx.state = ISOTP_IDLE;
 
@@ -481,6 +520,9 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	int off;
 	int ff_pci_sz;
 
+	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM)
+		hrtimer_cancel(&so->fc_artimer);
+
 	hrtimer_cancel(&so->rxtimer);
 	so->rx.state = ISOTP_IDLE;
 
@@ -554,6 +596,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	struct sk_buff *nskb;
 	int i;
 
+	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM) {
+		hrtimer_cancel(&so->fc_artimer);
+		so->rx.state = ISOTP_WAIT_DATA;
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+	}
+
 	if (so->rx.state != ISOTP_WAIT_DATA)
 		return 0;
 
@@ -855,9 +904,22 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 
-	/* only handle my own local echo CF/SF skb's (no FF!) */
-	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+	if (skb->sk != sk)
+		return;
+
+	/* FC echo handling: confirm FC was transmitted (N_Ar) */
+	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM &&
+	    (cf->data[ae] & 0xF0) == N_PCI_FC) {
+		hrtimer_cancel(&so->fc_artimer);
+		so->rx.state = ISOTP_WAIT_DATA;
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
+
+	if (so->cfecho != *(u32 *)cf->data)
 		return;
 
 	/* cancel local echo timeout */
@@ -1225,6 +1287,7 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
+	hrtimer_cancel(&so->fc_artimer);
 
 	so->ifindex = 0;
 	so->bound = 0;
@@ -1563,6 +1626,8 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 					  isotp_rcv_echo, sk);
 		}
 
+		hrtimer_cancel(&so->fc_artimer);
+		so->rx.state = ISOTP_IDLE;
 		so->ifindex = 0;
 		so->bound  = 0;
 		release_sock(sk);
@@ -1639,6 +1704,8 @@ static int isotp_init(struct sock *sk)
 	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->fc_artimer, isotp_fc_ar_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
-- 
2.43.0

