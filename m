Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709030;
	b=1mi0iVXAX9lxKKGnoGC0FignB2WB/dFb5E3pohtbURhOdwQPAlL5RIqNDynKnk1ZO18r
	 nKWM2iU8oKXMIvG28jM9WJrkUrzzGXklyN+pbo4K6oswSGGPPdLISFgYfmqqGfvcgO+8B
	 8S9+g98R0LjkPxv7L2RwOE56k9ggEuTPfehfn25qAsZnbFOHBaxaKJ3r/JIdwiPhxjvJJ
	 WV677KuZ7QZINPVlVYmDcCudht+PGvmm97sbrFi+e3DjxVonWWbb1+mfj2yiMpltgwLI2
	 qUgcasFujvztmYMRz+mjQUBYLtZlncM/cgmQncyHv6V76Amv8oNyutOyQUGqVua/jXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709030;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yzeyKJEvScW4ElzQC7+EqIjda3VMnu0vxJu1YSg6J4s=;
	b=RRfU+F0naUjs2jkEjfVYzVbXoo17Kh3RPi7d3NL83T3PkiFUKoCxw/GDBa1tqV8Q3ppG
	 4zncWr179pi/hj7aGnpjqKhqG2mc4lbS4GH9tbOrEDApCAt8Z0wOLZEXe6W4CrmdWLynO
	 5QBDrISJoPZxiff/qt46IabBHsStPv8B9IE8Pc6JtS0tsUvzZAM2L0GRW642qge4TlOHB
	 sFfPjcARwP13PLPxu/MJo7V4SVpyM6DcoyZkxw0RIR01lJJR+a6pqKigENY4pTABMqnCQ
	 sraiJ5AEeIBQFMPPehi59ZXqOSWjvNsazbEBglj2rFNDWSLzoNazNA/jL5jktu1/TVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYY0zahh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B151606A330;
	Tue,  3 Nov 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYY0zahh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=y4T4AdhDCu6iiQv7tdc8wFaAN0H8FN0Bes6vIBi6w5mi0KxVrCDeARzHVP1UYz6DOVWx
	 VmleRMgmo/lBAl7helPwJzZuL4Koi/S00hfhdl5RhmBQ2lCXHG40+JK/VodabGupzi0IK
	 CW4jqQqxMjn0VHmJhzxmppwRx1Gs+BHo4xS5JOI3+9SdNol3foHurLJ/7ZeRvrfUFlbkZ
	 uECbcUnAUNWZHIOOL90VQxfnlMUs3ogPU5Ok2yfRO6DLel7wBwfrlAD9ByDha8sHG48/6
	 wFidle50x9F4vopA6/q9VVdB5OETPsmq0qSVCVq2tBGo23vwmAsHMzUvoHQ+SOfJfKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yzeyKJEvScW4ElzQC7+EqIjda3VMnu0vxJu1YSg6J4s=;
	b=oCt8qFFnJs5Xm/PRq4HTR/HCHUHrO+/CQXVkdcIvi6F1TIlWIva3Hi/ISkDwCIN8u1Y4
	 wTDlEtC85j6hGQynDEz1cwhKwdHCSA/r8aYdkLP712NY/5ZjabLfyxqGi6pYK73zVUMXL
	 HFGXFYW5sJG4jcg+TPm0TIxzcMLK+O1zARShU+dFsqjC4qsJsl6FMO3gUOwlOsPKJoeE1
	 53ZU7UO/AMUkrkXMpOwLQw5p29Tcsjt7ORgAb1H/rPUuK/KvFRiuUw9qKfSpyqD8lTqjZ
	 vQZ1CMZhHzpDCkPujkYH9AYA8P7XsV/OlTbL0RkRsnG8FtIMQfOi6yQy06avP1uYnnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 732AB1F00A1B;
	Tue,  3 Nov 2026 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=yzeyKJEvScW4ElzQC7+EqIjda3VMnu0vxJu1YSg6J4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dYY0zahhVevs4afUB5p5L3mr2pSp4QKnvMcb0BjxCv3+x9l5jxFErzSL/+AEUSSix
	 IJXxZ42tlvJ0KkPD240d6fB75znw9DiHJIJMDdDncb0qEEsMG2QpNOgEjpFtxNjKsU
	 Xy57oVPoXY6t3tiB+mszFf+I+fB2Jl65rH0iUMJI7ndzkwLrvpLID8uHeDXeAuOAWy
	 FwffrTbP8/Mqb7squ0kDGaM6ISzUpfc+aLYaxFBpQNyb+u63JOKoOXT/vafUAGjeqo
	 98og9NLYpoFt5gVSSjbl3qgoCLA7ho1wtBIfJ9xBzTuI1tbhNluahuUU35a4QObG40
	 unFf3pj4UwCyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA1BB46948;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:26 +0100
Subject: [PATCH v8 10/14] can: peak_usb: dump undecodable URBs once and
 rate limit decode errors
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
Message-Id: <20261103-canfd_check_channel_idx-v8-10-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=8030;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=Y9OLOJORiCyS6rJxBFXyhFDzhdH7ugYnKhRkwMDPtvM=;
 b=rxwBWpot0zA6HNdasofO0PDg8Ff/a35IbQ1cKXtsE/xDJZRoXwlsamVE4tJnuU1/oG0785iWL
 cNmO5qsYnO1ANlX/ZrA+vE2+3XQ0RozjeQkpZMzupY1FP6zQv45TMPL
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

When the decoding of a received URB fails, peak_usb_read_bulk_callback()
dumps the whole RX buffer to the kernel log. The buffer is allocated with
kmalloc() and its size is the adapter RX buffer size (up to 2048 bytes),
so the bytes beyond urb->actual_length are uninitialized memory or
leftovers from previous transfers.

Moreover, the PCAN-USB Pro and PCAN-USB FD decoders already dump the
received bytes themselves before returning the error, so the same URB is
dumped twice. Neither these dumps nor the error messages printed by the
decoders are rate limited, while a faulty or malicious device can make
every transfer fail to decode, or carry unknown records.

Dump only the urb->actual_length bytes received, from
peak_usb_read_bulk_callback() only, and rate limit this dump as well as
the error messages the decoders print about the received data.

The dump and these messages are rate limited separately, so during a
burst one of them may be printed without the other. Drop the trailing
colon of the PCAN-USB Pro "got unsupported rec in usb msg" message,
which announced a dump that may no longer follow it.

The dumps and messages of the adapter decoders were pointed out by
Sashiko AI review.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  8 +++++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 27 ++++++++++++-------------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 30 ++++++++++++++--------------
 4 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 451d08421504..ff1921779065 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -637,7 +637,8 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 			return err;
 		break;
 	default:
-		netdev_err(mc->netdev, "unexpected function %u\n", f);
+		if (net_ratelimit())
+			netdev_err(mc->netdev, "unexpected function %u\n", f);
 		break;
 	}
 
@@ -776,8 +777,9 @@ static int pcan_usb_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 			urb->actual_length);
 
 	} else if (urb->actual_length > 0) {
-		netdev_err(dev->netdev, "usb message length error (%u)\n",
-			urb->actual_length);
+		if (net_ratelimit())
+			netdev_err(dev->netdev, "usb message length error (%u)\n",
+				   urb->actual_length);
 		err = -EINVAL;
 	}
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index e5198ec5c760..1d306160fa35 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -266,10 +266,10 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
 		/* handle these kinds of msgs only if _start callback called */
 		if (test_bit(PCAN_USB_STATE_STARTED, &dev->state)) {
 			err = dev->adapter->dev_decode_buf(dev, urb);
-			if (err)
+			if (err && net_ratelimit())
 				pcan_dump_mem("received usb message",
 					      urb->transfer_buffer,
-					      urb->transfer_buffer_length);
+					      urb->actual_length);
 		}
 	}
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index a9f81fb12738..b9bf2fefbaff 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -796,15 +796,17 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 
 		/* check if the record goes out of current packet */
 		if (rx_msg_size > msg_end - msg_ptr) {
-			netdev_err(netdev,
-				   "got frag rec: should inc usb rx buf sze\n");
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "got frag rec: should inc usb rx buf sze\n");
 			err = -EBADMSG;
 			break;
 		}
 
 		rx_msg_min_size = pcan_usb_fd_rx_msg_min_size(rx_msg_type);
 		if (rx_msg_size < rx_msg_min_size) {
-			netdev_err(netdev, "got short rec\n");
+			if (net_ratelimit())
+				netdev_err(netdev, "got short rec\n");
 			err = -EBADMSG;
 			break;
 		}
@@ -813,7 +815,7 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		case PUCAN_MSG_CAN_RX:
 			err = pcan_usb_fd_decode_canmsg(usb_if, rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PCAN_UFD_MSG_CALIBRATION:
@@ -823,35 +825,32 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		case PUCAN_MSG_ERROR:
 			err = pcan_usb_fd_decode_error(usb_if, rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PUCAN_MSG_STATUS:
 			err = pcan_usb_fd_decode_status(usb_if, rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PCAN_UFD_MSG_OVERRUN:
 			err = pcan_usb_fd_decode_overrun(usb_if, rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		default:
-			netdev_err(netdev,
-				   "unhandled msg type 0x%02x (%d): ignored\n",
-				   rx_msg_type, rx_msg_type);
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "unhandled msg type 0x%02x (%d): ignored\n",
+					   rx_msg_type, rx_msg_type);
 			break;
 		}
 
 		msg_ptr += rx_msg_size;
 	}
 
-fail:
-	if (err)
-		pcan_dump_mem("received msg",
-			      urb->transfer_buffer, urb->actual_length);
 	return err;
 }
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 88d21806207b..840658723648 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -741,7 +741,9 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	rec_ptr = pcan_msg_init(&usb_msg, urb->transfer_buffer,
 					urb->actual_length);
 	if (!rec_ptr) {
-		netdev_err(netdev, "bad msg hdr len %d\n", urb->actual_length);
+		if (net_ratelimit())
+			netdev_err(netdev, "bad msg hdr len %d\n",
+				   urb->actual_length);
 		return -EINVAL;
 	}
 
@@ -760,16 +762,18 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 
 		sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
 		if (!sizeof_rec) {
-			netdev_err(netdev,
-				   "got unsupported rec in usb msg:\n");
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "got unsupported rec in usb msg\n");
 			err = -ENOTSUPP;
 			break;
 		}
 
 		/* check if the record goes out of current packet */
 		if (rec_ptr + sizeof_rec > msg_end) {
-			netdev_err(netdev,
-				"got frag rec: should inc usb rx buf size\n");
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "got frag rec: should inc usb rx buf size\n");
 			err = -EBADMSG;
 			break;
 		}
@@ -781,13 +785,13 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		case PCAN_USBPRO_RXRTR:
 			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PCAN_USBPRO_RXSTATUS:
 			err = pcan_usb_pro_handle_error(usb_if, &pr->rx_status);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PCAN_USBPRO_RXTS:
@@ -795,20 +799,16 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 			break;
 
 		default:
-			netdev_err(netdev,
-				   "unhandled rec type 0x%02x (%d): ignored\n",
-				   pr->data_type, pr->data_type);
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "unhandled rec type 0x%02x (%d): ignored\n",
+					   pr->data_type, pr->data_type);
 			break;
 		}
 
 		rec_ptr += sizeof_rec;
 	}
 
-fail:
-	if (err)
-		pcan_dump_mem("received msg",
-			      urb->transfer_buffer, urb->actual_length);
-
 	return err;
 }
 

-- 
2.53.0


