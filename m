Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CE3C553C;
	Mon, 20 Jul 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555324; cv=none; b=UGPy6gRXWG/+BZmR0nelJtifMYUT/RizDQk8nxZvOZghJ0ylFpM2xDa62EFZXbBY9tOjnPUb38q18i5dHEHnt7p+sIgAP4UrQGubkTwvsT9gu+l5UkhVEsV9G2ijiXgsowxdXv1wFBL5Je3nVLodrjp/YO10c1Cc67yLoO3R2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555324; c=relaxed/simple;
	bh=Txe5O5T5elBjcyJRedXKsdRrhV72hIsg2q3KQM0yjfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2M1Mxgluc7yu2PlgTkc5YJLuSXrnzVIg4Hms5VdPFpBNkQDPoaWR5wK3dx1EJAiTlUVS6XUf7tg9/nNZTt7Rpkz2hw4RNha/OYIiIsmI9ohbXJEdz2X+cQFFlP5BRwJRqmbbCfM4TYyDcaPKDQYSUi4zxBp57Bwb9o/0hAaSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CC6DD2028DE;
	Mon, 20 Jul 2026 15:48:28 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM8-000Pmx-2O;
	Mon, 20 Jul 2026 15:48:28 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B07656E525;
	Mon, 20 Jul 2026 13:48:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:09 +0200
Subject: [PATCH can-next 08/13] can: gs_usb: gs_update_state(): convert CAN
 state handling to can_change_state()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-8-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6845; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Txe5O5T5elBjcyJRedXKsdRrhV72hIsg2q3KQM0yjfY=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5evM2D+7bP3/K1Fa3dtF7v15yJH4FKTqKvZnUXnG
 013PxH62lHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJcBQx/E+bsu/EXetNb2q6
 1yduj5vuuiqokbug8251zuVdx0x+dlxlZFgTIvxa7oqYgoXUiXdbY9nvfLDL/+9XUOdd3m7ycla
 iFxsA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The gs_usb compatible firmware signals CAN state changes via CAN error
frames to the kernel. As the kernel tracks the state of the CAN device, the
driver has to parse the CAN state from these CAN error frames.

Since the driver has been written, the can_change_state() helper was
introduced to the kernel, in order to send more uniform CAN state error
frames to the user space. Convert the driver to make use of the
can_change_state() helper.

Implement gs_usb_state_get_by_hf() to figure TX and RX state by parsing the
received struct gs_host_frame.

If the CAN error counters are not 0, some firmware repeatedly send CAN
state error frames, even if the CAN state does not change. Implement
gs_usb_should_handle_can_error() to drop these, but keep other CAN error
frames.

Update gs_update_state() to make use of can_change_state(), clear all CAN
state information from the CAN frame (which will be send to user space) and
let can_change_state() populate it consistently from the previously parsed
CAN TX and RX state information.

Some firmware does automatically CAN bus off recovery, without signaling
this via CAN_ERR_RESTARTED. If the CAN state changes from Bus Off to Error
Active, Warning or Passive, treat this also as a restart of the CAN
controller.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 114 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 473f125e20d8..e41f91b56ab8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -529,29 +529,31 @@ static void gs_usb_timestamp_stop(struct gs_usb *parent)
 	cancel_delayed_work_sync(&parent->timestamp);
 }
 
-static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
+static void gs_update_state(struct gs_can *dev, struct can_frame *cf,
+			    enum can_state tx_state, enum can_state rx_state)
 {
 	struct can_device_stats *can_stats = &dev->can.can_stats;
 
-	if (cf->can_id & CAN_ERR_RESTARTED) {
-		dev->can.state = CAN_STATE_ERROR_ACTIVE;
+	/* clear CAN state information, will be set consistently by can_change_state() below */
+	cf->can_id &= ~(CAN_ERR_CRTL | CAN_ERR_BUSOFF | CAN_ERR_RESTARTED);
+	cf->data[1] &= ~(CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING |
+			 CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE |
+			 CAN_ERR_CRTL_ACTIVE);
+
+	const enum can_state new_state = max(rx_state, tx_state);
+
+	if (new_state == dev->can.state)
+		return;
+
+	/* some firmware does automatically CAN bus off recovery, account for this */
+	if (cf->can_id & CAN_ERR_RESTARTED ||
+	    (dev->can.state == CAN_STATE_BUS_OFF && new_state < CAN_STATE_BUS_OFF)) {
 		can_stats->restarts++;
-	} else if (cf->can_id & CAN_ERR_BUSOFF) {
-		dev->can.state = CAN_STATE_BUS_OFF;
-		can_stats->bus_off++;
-	} else if (cf->can_id & CAN_ERR_CRTL) {
-		if ((cf->data[1] & CAN_ERR_CRTL_TX_WARNING) ||
-		    (cf->data[1] & CAN_ERR_CRTL_RX_WARNING)) {
-			dev->can.state = CAN_STATE_ERROR_WARNING;
-			can_stats->error_warning++;
-		} else if ((cf->data[1] & CAN_ERR_CRTL_TX_PASSIVE) ||
-			   (cf->data[1] & CAN_ERR_CRTL_RX_PASSIVE)) {
-			dev->can.state = CAN_STATE_ERROR_PASSIVE;
-			can_stats->error_passive++;
-		} else {
-			dev->can.state = CAN_STATE_ERROR_ACTIVE;
-		}
+		/* some firmware doesn't set CAN_ERR_RESTARTED, fixup */
+		cf->can_id |= CAN_ERR_RESTARTED;
 	}
+
+	can_change_state(dev->can.dev, cf, tx_state, rx_state);
 }
 
 static u32 gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
@@ -640,6 +642,75 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
 	return minimum_length;
 }
 
+static void
+gs_usb_state_get_by_hf(const struct gs_can *dev, const struct gs_host_frame *hf,
+		       enum can_state *tx_state_p, enum can_state *rx_state_p)
+{
+	enum can_state tx_state, rx_state;
+
+	/* extract CAN state from frame */
+	if (hf->can_id & cpu_to_le32(CAN_ERR_CRTL | CAN_ERR_BUSOFF)) {
+		const u8 err_crtl = hf->classic_can->data[1];
+
+		if (hf->can_id & cpu_to_le32(CAN_ERR_BUSOFF)) {
+			tx_state = CAN_STATE_BUS_OFF;
+			rx_state = CAN_STATE_BUS_OFF;
+		} else {
+			if (err_crtl & CAN_ERR_CRTL_RX_PASSIVE)
+				rx_state = CAN_STATE_ERROR_PASSIVE;
+			else if (err_crtl & CAN_ERR_CRTL_RX_WARNING)
+				rx_state = CAN_STATE_ERROR_WARNING;
+			else
+				rx_state = CAN_STATE_ERROR_ACTIVE;
+
+			if (err_crtl & CAN_ERR_CRTL_TX_PASSIVE)
+				tx_state = CAN_STATE_ERROR_PASSIVE;
+			else if (err_crtl & CAN_ERR_CRTL_TX_WARNING)
+				tx_state = CAN_STATE_ERROR_WARNING;
+			else
+				tx_state = CAN_STATE_ERROR_ACTIVE;
+		}
+	} else {
+		tx_state = dev->can.state;
+		rx_state = dev->can.state;
+	}
+
+	*tx_state_p = tx_state;
+	*rx_state_p = rx_state;
+}
+
+static bool
+gs_usb_should_handle_can_error(const struct gs_can *dev, const struct gs_host_frame *hf,
+			       enum can_state *tx_state_p, enum can_state *rx_state_p)
+{
+	gs_usb_state_get_by_hf(dev, hf, tx_state_p, rx_state_p);
+
+	/* If the CAN error counters are not 0, some firmware repeatedly send CAN state error
+	 * frames, even if the CAN state does not change. Handle changed CAN states.
+	 */
+	const enum can_state new_state = max(*tx_state_p, *rx_state_p);
+
+	if (new_state != dev->can.state)
+		return true;
+
+	/* handle RX and TX overflow */
+	const u8 err_crtl = hf->classic_can->data[1];
+
+	if ((hf->can_id & cpu_to_le32(CAN_ERR_CRTL)) &&
+	    err_crtl & (CAN_ERR_CRTL_RX_OVERFLOW | CAN_ERR_CRTL_TX_OVERFLOW))
+		return true;
+
+	/* handle TX timeout */
+	if (hf->can_id & cpu_to_le32(CAN_ERR_TX_TIMEOUT))
+		return true;
+
+	/* handle CAN bus errors */
+	if (hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK))
+		return true;
+
+	return false;
+}
+
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
@@ -719,8 +790,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
+			enum can_state tx_state, rx_state;
 			struct can_frame *cf;
 
+			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG) &&
+			    !gs_usb_should_handle_can_error(dev, hf, &tx_state, &rx_state))
+				goto resubmit_urb;
+
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
 				return;
@@ -732,7 +808,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
-				gs_update_state(dev, cf);
+				gs_update_state(dev, cf, tx_state, rx_state);
 		}
 
 		gs_usb_rx_offload(dev, skb, hf);

-- 
2.53.0

