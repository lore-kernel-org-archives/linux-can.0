Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503054;
	b=zjQC8stjm+n5gCetvcV+Om1Bxrxo9hIbqXI6TG+p01fR6m2MPXEc+Ge6gDmO7fHLpnYL
	 HRpsIjJRqgMFLp4YxEl+mZ78LLXjxYsgyTea+37uqI0F/EMDYbix14YhgHaZT3ZiFGPDI
	 uAnXtz4f3Rkfj1f+26uVksWczD5UJrpTfVAj7YzEhjmf6nxneO0oJgsLfLkh/bjkiMhx0
	 ACgQj00Utg+Q3oQ/1s9Y9GgubfqC6gBzltO25atL+TmVQKcoCcati0bbi6BzybS9USp7E
	 08EvtXlJ3NV2j6QhYPRaEo1IIDpNabPdGfTeq3BBlMPjmrCWsuPJEVesuTP6rc010kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503054;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	b=X3ClgR97bsGxtOswNfsEDdg/50d+g2qMCpEMaZJIDrFSV2mLX24Ddspk3pJ2iHltIPuo
	 W1KsOaaAYNLMrwDPzLSn52jIgyn5Mo6hsga3dDoXg6SMUTkN22UWLsT+UfwYC4qhiYVyU
	 pezj8BSrADZwC4S0pGSYlzG+bscZRVwD69hvXUjEj5s/gBKW5kL6ehScN6tymgzyeejyN
	 P+4CHk7oFr/oMG5CVYh/+yBjr+CWrHCNwIRw7ECtKaRQc7zsqysnlSe/3e6ZH8ft1uoQ8
	 0FSlAwRZuLrTEgW7lbqSv441dRBtnPYu4xjqxV5uMoiFSuWEvLsiLHItR5NrsLj3j3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhzqFlHE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B979606A33D;
	Tue, 20 Oct 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhzqFlHE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503054;
	b=ZvsJRr48eMsjysmZyIKk+oNkVNfgDRrzixuOz8ACRiBLdzHSr/0GeK9mszBRm1UQzyp/
	 XmLmhMAcmPYyLZpDj6TphnvqBJRxPrq9AO8jBMQ/x6zoD2P22n1Jo6JgFEequB0d+KxfK
	 /zcCNQ3TnY48ySYXCHuXaQcF1tL9PGPZsEFrJ41QkheqxJRLmtS00f8dod2l7aA/BQcCp
	 Hl44v6zcFS3pf6V17XVNQEbXK4eAK+NLt7JMLbvkDMiGA12qCVNA2O2mYDwTinGzPXE14
	 JbslXTul8nCMGsx7WJ6FWANWw6e3Y1orTJtvn4abjc9RZJROq8QDDQhd0kT9v6n1ldA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503054;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	b=RoUk0pMMO7WlhavPjJATSIRoIjCZa5lDK9FMeATuSTZPphhxu8CftBB7dsllvvy0XcTL
	 yOs5jEqTSoZ9BdpBpk/Oi8DyfxBvjd9nwoWBhS+kB8WJ8VFGgyrRDzJZrYDiSiKRqHZDc
	 deIdCx3wXMbKcUJQImANQuqD1A3e4k64Iq9WhN+8RbZKlPahuQlCXIxvugVf+A3EbQRJB
	 XzsVGGqL+LuYMwujTNgeIj/6yftAuYfxJPfjMpwCK89hZx50vLB7ORhb64P+TSEjBH9b2
	 9TyMRGE6GDJjY6NSTLS3mxeCy9hmpufHjLsAUx5U0t8WOszgH0KvoOSVUAYwHrtrXmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4355E1F000C4;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503054;
	bh=1Melciw7ehwXTAwTcKOQZ4sgd9JcwdjHYlQFpqkIAx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GhzqFlHEdrt4e8vS2/ggXB9Zz6ZILfWoIKB3vahXU/EmjFht+PDxCvzz+c7EJEuw5
	 2klvdyelAaMDYKwcQa8hSx+vw3qTu0cWmnzYsw4oabUg5PTdysyuEQxxmcXGPPNUGV
	 zHueTMHTk4loud9z9VYwbidhDE39lUvA6nyoGkdTwGkde6fDkSm/77xkcmyWpk1d5a
	 0Bs4WftBk1SiEM7mcAbQbRwU0W5Z739+3Tnw+UUd0fK9eRTV5EDJHI5vyd8in0Zpv3
	 It2TBKyjbxxaFrHeiYMVf756jKihG1IMPB8cnUeaX+tNVJUQe2Nzs9RA6E35npQn9U
	 cgYcht+G5R/+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A33C44318B;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:44 +0200
Subject: [PATCH v5 05/10] can: peak_usb: replace open-coded bitmask
 operations with bitops
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
Message-Id: <20261020-canfd_check_channel_idx-v5-5-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=6592;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=nQyQ44v+InsbZVERsOlgObbCokwsrHOkh2r9DVOCK+4=;
 b=oskgEEZBfAkDRzcqvFhanKj3YUeOmOg3YhUHcMbBTmr1OdnGf8oW8pqyiHepTCpfIfUWqTc4g
 Ahe0bm1O3+SDufQvAI4EW48odfUEBDfcKbxtajuYyZz91QdxWqMOYLO
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PCAN_USB_STATE_* flags of struct peak_usb_device are set, cleared
and tested from different contexts (ndo_open/ndo_stop, USB disconnect,
URB completion) with non-atomic open-coded bitmask operations.

Turn these flags into bit numbers, make the state field an unsigned
long and use set_bit(), clear_bit() and test_bit() instead, so that
updating one flag can no longer overwrite a concurrent update of
another one. The next patch relies on this to clear CONNECTED while a
channel may be opened.

dev->state is zeroed by alloc_candev(), so setting CONNECTED with
set_bit() at creation is equivalent to the former assignment.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 10 +++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  9 ++++++---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  6 +++---
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 5da91d5dc67a..93da0fd4f10e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -158,7 +158,7 @@ static int pcan_usb_send_cmd(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
 	int actual_length;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	dev->cmd_buf[PCAN_USB_CMD_FUNC] = f;
@@ -188,7 +188,7 @@ static int pcan_usb_wait_rsp(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
 	int actual_length;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	/* first, send command */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 55aad01cd8ca..a1b17e1e6fea 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -263,7 +263,7 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
 	/* protect from any incoming empty msgs */
 	if ((urb->actual_length > 0) && (dev->adapter->dev_decode_buf)) {
 		/* handle these kinds of msgs only if _start callback called */
-		if (dev->state & PCAN_USB_STATE_STARTED) {
+		if (test_bit(PCAN_USB_STATE_STARTED, &dev->state)) {
 			err = dev->adapter->dev_decode_buf(dev, urb);
 			if (err)
 				pcan_dump_mem("received usb message",
@@ -537,7 +537,7 @@ static int peak_usb_start(struct peak_usb_device *dev)
 			goto err_adapter;
 	}
 
-	dev->state |= PCAN_USB_STATE_STARTED;
+	set_bit(PCAN_USB_STATE_STARTED, &dev->state);
 
 	/* can set bus on now */
 	if (dev->adapter->dev_set_bus) {
@@ -631,7 +631,7 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 {
 	struct peak_usb_device *dev = netdev_priv(netdev);
 
-	dev->state &= ~PCAN_USB_STATE_STARTED;
+	clear_bit(PCAN_USB_STATE_STARTED, &dev->state);
 	netif_stop_queue(netdev);
 
 	close_candev(netdev);
@@ -941,7 +941,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->netdev = netdev;
 	dev->adapter = peak_usb_adapter;
 	dev->ctrl_idx = ctrl_idx;
-	dev->state = PCAN_USB_STATE_CONNECTED;
+	set_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
 
 	dev->ep_msg_in = peak_usb_adapter->ep_msg_in;
 	dev->ep_msg_out = peak_usb_adapter->ep_msg_out[ctrl_idx];
@@ -1044,7 +1044,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		char name[IFNAMSIZ];
 
 		dev_prev_siblings = dev->prev_siblings;
-		dev->state &= ~PCAN_USB_STATE_CONNECTED;
+		clear_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
 		strscpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_candev(netdev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 9ad7d31d2720..cb8777c3e08e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -109,15 +109,18 @@ struct peak_tx_urb_context {
 	struct urb *urb;
 };
 
-#define PCAN_USB_STATE_CONNECTED	0x00000001
-#define PCAN_USB_STATE_STARTED		0x00000002
+/* bit numbers for struct peak_usb_device::state (used with set_bit()/
+ * clear_bit()/test_bit() for atomic read-modify-write across contexts)
+ */
+#define PCAN_USB_STATE_CONNECTED	0
+#define PCAN_USB_STATE_STARTED		1
 
 /* PEAK-System USB device */
 struct peak_usb_device {
 	struct can_priv can;
 	const struct peak_usb_adapter *adapter;
 	unsigned int ctrl_idx;
-	u32 state;
+	unsigned long state;
 
 	struct usb_device *udev;
 	struct net_device *netdev;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 82502594a409..15d275d6a127 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -202,7 +202,7 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	ptrdiff_t cmd_len;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	/* if a packet is not filled completely by commands, the command list
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4c3d89a160af..cbc23953ce61 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -210,7 +210,7 @@ static int pcan_usb_pro_send_cmd(struct peak_usb_device *dev,
 	int err;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	err = usb_bulk_msg(dev->udev,
@@ -234,7 +234,7 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	int i, err = 0;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	req_data_type = pum->u.rec_buffer[4];
@@ -318,7 +318,7 @@ int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	unsigned int p;
 
 	/* usb device unregistered? */
-	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
+	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
 		return 0;
 
 	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;

-- 
2.53.0


