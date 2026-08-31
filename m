Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515403D5244
	for <linux-can@vger.kernel.org>; Mon, 31 Aug 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165021; cv=none; b=Hb7TcUmZWWDjwDJya/sWZ0VynaSVHep0xTfFxAWrh5/0NBhi8f/IhsLEDcx0tZDoNpeq2a7zHuppYfi4ZaLb43yG8JLAb5k0dQd4O2b5ewdgC+O9FFE+NWd+IwCuQypQwFjlRhg1yoI+HpBIRDUVr7BAA3/i2YttVA1iTdFTz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165021; c=relaxed/simple;
	bh=xXuiXykzbiX2ZCjda/3ugCHu8+1Zib/04d77OyEGtjA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Y/DGE9OhSrpMQ4vtSTcHOnrx5qHUrCnsq5nsmiirrf6LSpiBHI7BBELPpNRhtA1gO5d4sKnNtPjCpZc39KVsXjxR29kch21ucBs+2Kqtdme9/EOyxdTrYhkzYBZDG5MAh/5eFGf31XkzJPT2PezQdw6Bpj7rqPZ/tgswwHjtnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=LkD1Z5Vs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="LkD1Z5Vs"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a63667b78aso2317802a12.3
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2026 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788165017; x=1788769817; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+LA2dlyJszs30Yo28AUl/hqCeTsIfAPbCfIyYRq1U0=;
        b=LkD1Z5Vs+6w970hihIZZCEXdn/lX1aiVxhm4ejS7lP8IPd1n1eTXWXRdztP47VtktV
         7E4TpHh+5yhxPwpUYZ1zzF1Rn8w3ARZ7lK2ctjuO3pCVLBOjjVkhFIPX47QArmgHK6ux
         k85QFbZADbsMaDUoNYIadwwPRRT/WAO6cnoVUCEtk+pegbsTz87djgRrQt9ukjS0gjnW
         42fTyCWXAZ2mqUSBCBGkVV0ngCBUkZGJ++pswBMERkrcTGEcV9Rqomd5zTDPFx27THtW
         YIETeP2fxmLznifPxFPum1kalOVhS/1yHjFIv+OEwfAKn2D5DeR4Lfn2eR/vXIFAgOQ5
         S04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165017; x=1788769817;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+LA2dlyJszs30Yo28AUl/hqCeTsIfAPbCfIyYRq1U0=;
        b=OVDMjlqQh3iTNwg24xviI12oB/MfY6FU4W8iGem8zny216hR+SulTBgdRenZmwXiu5
         gH/jsw3g0XxLngqCInbM2feU9tdzH5TW7/cVCnvuXHrPj+CK+Yb7MSyBV6ayyqBURws+
         YOwYSLV77+pNcudGWG/eylbiOmMfTuGPnXbmzpOEGgIqJGG8BAzfzmXIQ1eq6fZnwqp5
         zIwY5mkZE9qJZ+uGKWDM6Pw4R3z69n9zHaEBzsHqFS+D5TPryZDEaHd9x7Db2DrnX72e
         zw9822WS+3SDGdLSEf2p+MBOl9T0cPLqCauzxWeHke9vhsXKbRcAx7bg/MOeUJCAPWAQ
         9YXQ==
X-Gm-Message-State: AFuF++noDdYBRkRmHmD2gXzGCfjZTc+L+I6i1P8MRl81LaXs5+lRkvef
	i0m0cKFyj6wp1f/SGMNWu8vjL2ep0W+ydPkcfHdtHctz4OURO/sx1tVwtBWFOgPjv9+vsQAIXBo
	5Du4PeiRqhw==
X-Gm-Gg: AR+sD11EakJaCNZRAEVxDQSn/d2p99wXZS2yNcHMp81Sde7fNiSnNOaWx5Xu+FZ6oM2
	h/DS0FUQ3DhTfFxY6WYml2fRSOKLMUqoQOZ++FeX26Z7A/OCQOUhn3HLMtsvgyCFbR9rV8Bv7lb
	kYgLBMxkKZfgfMJR9rDCPhXay/E192p1BrfW1TDPYRSBYy5dBSOxq7r+QEu61/5jcFQYD1mOD5D
	i6Ni6+6gxNdGA6GbXBLIUS6blVsmj72wdXAXQSHYgYNrfkUFUYDfBEiwqC9B6DY10mWJDN3A43I
	ct7ISElro2rBm4Wy6jV9gcVhJiq5YmKOalj8lypcpLoFfy8MuDsXtvMXC4Ivfy/1z5GRDDhUfeN
	VxWUG74KhIXW8qZgyDNfDs0i8UGyWWQNcEPrHM1cCzOk3U7o95xl22Wr/4bciU7dG/yvL2y+Q2D
	26z+KCe5FcuzPCarp/XWXsx32BAQ8BpPrFWyam/mH2sbdZtvpyopRNIm0qB0h5zABVxSRstMl7M
	F6z0jrAsgJatrmiMcnWR5lbr9dfTiMiggYahEJBlOc=
X-Received: by 2002:a17:907:728b:b0:c24:680b:3944 with SMTP id a640c23a62f3a-c2557169784mr1500824566b.13.1788165017052;
        Mon, 31 Aug 2026 01:30:17 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee27b19sm390365766b.19.2026.08.31.01.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2026 01:30:16 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] can: isotp: take rtnl_lock() before leaving the notifier
 list 
Message-Id: <CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com>
Date: Mon, 31 Aug 2026 10:30:05 +0200
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-kernel@vger.kernel.org
To: linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

isotp_release() removes the socket from isotp_notifier_list before it
takes rtnl_lock(). The netdev notifier chain runs under RTNL, so a
socket that leaves the list in that window is skipped by isotp_notify()
and has to unregister its own CAN filters.

It cannot always do that. isotp_release() passes sock_net(sk) to
can_rx_unregister(), which returns early when that netns no longer
matches dev_net(dev), before the receiver list is searched and before
the "receive list entry not found" warning. Once the bound device has
been moved to another netns the filters are removed zero times, and
can_rx_register() stores rcv->sk without taking a reference, so the
receivers left in the device's dev_rcv_lists point at the freed socket
and travel with the device into the new netns.

  BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
  Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
   can_rcv_filter+0x4af/0x8c0
   can_receive+0x28d/0x3c0
   can_rcv+0x2a9/0x310
   __netif_receive_skb_one_core+0x21a/0x260
   process_backlog+0x210/0x760

Take rtnl_lock() before removing the socket from the notifier list, so
that isotp_release() and isotp_notify() cannot both skip the removal.

Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with =
concurrent NETDEV_UNREGISTER")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Reproducer available on request.

 net/can/isotp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..8ca75d30360c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1475,6 +1475,8 @@ static int isotp_release(struct socket *sock)
 	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) =
*/
 	wake_up_interruptible(&so->wait);
=20
+	rtnl_lock();
+
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier =3D=3D so) {
 		spin_unlock(&isotp_notifier_lock);
@@ -1484,7 +1486,6 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
=20
-	rtnl_lock();
 	lock_sock(sk);
=20
 	/* remove current filters & unregister
--=20
2.55.0

