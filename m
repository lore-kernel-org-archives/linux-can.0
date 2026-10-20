Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492919;
	b=SBA4qVlJZwobFoeJAvwRoMg+nE/tWYP+AYD8lNehHUkNOdk3AoT6M7kvkDUH0I0MAhQ7
	 ieYuoXOGm9gV7VhUXn+26Gai/Bo/9rw9NpB8elpRh+pZhIFFwsJopveVm3wbNaHtIeftE
	 3xxujRbApwOoKCr0oBInAwi8W5QMaBINl2gnmTsiVdDm0gNm5Lg3jC+4lacEHLMIfurhb
	 CPCox1r+ZL6YGqNNnkjq3qiLcpw+JKj9Qb2Bq01iWCeu9pgIBDt1pzKF1pkYP6uy00tmK
	 VazY3XlQHLnQsTjH9fkvoQ+5NZUrSFWXilygMdqqDTxkIKSClkv2vVviI2jmOXxPapw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492919;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ycon7CQwLLFl8oMFCR4ymMMnCGOcGaVBYeAI27pirwE=;
	b=ckFx2udghIVG46uRFTlqwLWOvNMSYQFlT9qJJAV6BbX0CPWU/yj/gzi0oQPk8n56ff+6
	 3JGQFatnw/4VVReNeZ1k5uL+Gk6rzKnQ5SFb8pJ3ATBlMDdvWpm/puJD56dH8gIhctvGN
	 Haqiz20eGzMMp1rkbILXJXMebeuH195zHoBwbsosMxiZlck4NH/VCvqnWlwng6ColpU28
	 CN3CVsy0yeqgGPKuzrP52y8iBIgl5kBNDTq4rvVko34CoV0pcY80QdWlNWouSUlKrFEb4
	 Fzwfo3egujKBvXhCzvn6DKUp8DkKl+5nCNr3Eesyq/fZ4exEv3MO7n5HoA2j67Mhm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=UUCHsjV1;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D29606A31D;
	Tue, 20 Oct 2026 10:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D29606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=UUCHsjV1
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 58298780316;
	Tue, 20 Oct 2026 12:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492917;
	bh=Fi+sa1aTAgGacOIH9BQbg+Czkp0d/1+UXr9XgBcYHZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UUCHsjV17fairorXE+P91nk0OuQSNKSmSIW8uWECTpXU8IrRAIRhAw47eA38lgzJJ
	 xx7H+xmuRaGHBl69YKp7+UZkg48b1Wh55+HtcYG9wewCxj9Epv/3/uxKk0FyGSYkf+
	 Xte8GCHwbck+IX4qcihSt2lYcR+gLTu+/GgXgeNTr1eqkeB9Q1l7CcGjcvkG0AUI7b
	 FFk+lmDeaNEDa1wus+CfoMQ/ODfCBeg6G2AAEM0uqG408UNgpJZJBS0RFlmlmITInL
	 maduZyjqBWKiM/XVwejRZhKVdZ5COQ82zajvmfGpnkI5CqQsqeutD6WK2S47Rxvqfk
	 q2I/j2m4hGMfQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:24 +0200
Subject: [PATCH v4 09/10] can: peak_usb: register the netdev only once the
 channel is set up
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
Message-Id: <20261020-canfd_check_channel_idx-v4-9-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

peak_usb_create_dev() registers the netdev before calling dev_init(),
dev_set_bus() and dev_get_can_channel_id(). Userspace can therefore
open or configure the netdev while the channel is still being
initialized, outside of rtnl_lock():

- peak_usb_ndo_open() may run before dev_init() has set up the adapter
  private data, e.g. pdev->usb_if, which is then dereferenced while
  still NULL by pcan_usb_pro_start() or pcan_usb_fd_start();
- the commands sent by the open or bittiming callbacks may race with
  the ones sent by dev_init() on the same command buffer;
- dev_set_bus(dev, 0) may switch the controller off right after
  peak_usb_ndo_open() has started it.

Moreover, if dev_init() or dev_set_bus() fails, the adapter private
data is released before unregister_candev(), which closes the netdev
if it has been opened in the meantime, and then accesses the released
data (interface object and, on PCAN-USB FD, command buffer).

Register the netdev only once the channel has been fully initialized.
The error paths then no longer need to unregister it. Since the channel id
may now be read before the netdev is registered, PCAN-USB reports a
failure to read it with dev_err() instead of netdev_err().

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  7 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 26 +++++++++++++-------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c8cfed31634..c7246465dcc7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -390,9 +390,12 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
 	int err;
 
 	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
+	/* explicit use of dev_xxx() instead of netdev_xxx() here: this is
+	 * also called during probe, before the netdev is registered.
+	 */
 	if (err)
-		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
-
+		dev_err(dev->netdev->dev.parent,
+			"getting can channel id failure: %d\n", err);
 	else
 		*can_ch_id = args[0];
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 4c08656e7768..ccfc26d3e5a6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -998,15 +998,6 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	netdev->dev_id = ctrl_idx;
 
-	err = register_candev(netdev);
-	if (err) {
-		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
-		goto lbl_restore_intf_data;
-	}
-
-	if (dev->prev_siblings)
-		(dev->prev_siblings)->next_siblings = dev;
-
 	/* keep hw revision into the netdevice */
 	tmp16 = le16_to_cpu(usb_dev->descriptor.bcdDevice);
 	dev->device_rev = tmp16 >> 8;
@@ -1014,7 +1005,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_init) {
 		err = dev->adapter->dev_init(dev);
 		if (err)
-			goto lbl_unregister_candev;
+			goto lbl_restore_intf_data;
 	}
 
 	/* set bus off */
@@ -1027,6 +1018,18 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get CAN channel id early */
 	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
+	/* register the netdev only once the channel is fully set up, so that
+	 * it can't be opened or configured while being initialized.
+	 */
+	err = register_candev(netdev);
+	if (err) {
+		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
+		goto adap_dev_free;
+	}
+
+	if (dev->prev_siblings)
+		(dev->prev_siblings)->next_siblings = dev;
+
 	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
 		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
 
@@ -1042,9 +1045,6 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
 
-lbl_unregister_candev:
-	unregister_candev(netdev);
-
 lbl_restore_intf_data:
 	usb_set_intfdata(intf, dev->prev_siblings);
 	kfree(dev->cmd_buf);

-- 
2.53.0

