Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683711;
	b=ykEmK7ND6mRpyv9w3KdRK4P8mP499+NlIQ1ismUqHk1iIuB6RvTmdyxqcPoO+0wsoGeq
	 +NoRbfTUPB+mwgvsbzzotayLSMmW85mP/gG9ZyaWKwolEsxnMcYYu87SmAkE/BcQtVlek
	 00wPRoKMQbDAAGATJBO+ztiX6Bqr1adaMF8Q4h9DD0tOI6KiZigsj2EIMyz68Jc4orXzB
	 yGG52Z72V6XgdT3qjLTm3H//xs5/Zfr2UTkG+xBplBcfB60zsfqOnD5JjNd0602CJTluj
	 MaU3iTn5uBgeEaH7f1BNpjcrl8W5OweK+qNYRjM5x0ldMfjbNvPH70RmoMFzkB6fjQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yc8u6ZTBSOQUjnITtacxK4ET7XDv/dt+TXiUIwB4yUo=;
	b=zylTQgq30LTqbt3FxddF37EGHOXMlNw9+tRlTJteNJysAtCRZGGAD6FQNFirl9YRmmQs
	 vYgdlePo2wFFyu3j4m+infL2rzviZazUETOqT4Mzc3U6UsA/J9YNnMpcnjjBl0cD7ryiO
	 LSGEGjEyoX3JqL2zAusN0qatPXtOpipf9OshkNi2HJ/9VQF5TVcWWP+DlfbdRxfbK+dru
	 WUk+a+HfI5zXBTQCzCKAPcoD3h58GWgSfdjvNJ0Fc3eEra4Tbph7jmoEjJqnGaSVl6V3O
	 KU7z2rLXrY4Wb+qVZsfOlnU9aUMtHnonuwuxINsd8Rm43ch+m5j5mqAsBYF8aX8JJ6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFbSWACR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13557606A32E;
	Thu, 26 Nov 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFbSWACR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683710;
	b=RgXUrK36GI1T5xwaCePWSLGF3DSin58hnW4cmPOY7z2GJXDbSJAQcWDGB6G3jAq32KLd
	 mBOTdPbZMPArdrbGWZJyuQqVwWqcwdqiHzS6qW1yQoPK7G+M8Bq1VLPU6ri8mi5V26VLm
	 CohV9eQBL2Lrb87IeN+24RztS0D0JVmIQyn8wn2733+RGPPq8pwQCQdfX3rxf+ca91U/8
	 8MPcSsJJCbG3YcR+vn9IOavyK6NccQ8v+E0Lzm11uwxpTq23EeJ0pSVtGkURE0KXXhKH+
	 hQQJ3Jt0jS5F6kOOvcRaJJmVqxnW1AOO1DRmSYLjT27r/IBKz5fMYgO1MfIZCXaiKIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yc8u6ZTBSOQUjnITtacxK4ET7XDv/dt+TXiUIwB4yUo=;
	b=BEs0KdUQ7IGn/PFSOGoTBiYD8dFOBV/9yX4xLtsYQVT/9E7jwIo+96GEqM5P0Qkbz4vz
	 m0HMeQiR+c4E8AIfVmL2xn1k7cSK5MyVfTndr6CmnfIO2UQCiaoybhrcAJ/31cJRu0yDH
	 PZqTIkv0JsSNSdR6YHmZ+SHJb0UJPCyqdgoXiOuIRyQYecSlXPAneAr5mD9oJSZ4MKQEn
	 aqpRMrANg2OF2+jP9VadIgHnSuEucI94D0YY7Nn/w/Ncn63NJGqIBM+0P+I+XNh2dh0vQ
	 pOuDKxtBqWiY8ThyV5tRSiO+ET7DS5pHkIuqzUW2KRMuyJ2lL76EaRpuIkwgSPZ36ag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5DBE41F000F2;
	Thu, 26 Nov 2026 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683710;
	bh=yc8u6ZTBSOQUjnITtacxK4ET7XDv/dt+TXiUIwB4yUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IFbSWACRg+ImwUPS1Z+wX0weCv4/8d14B/1E06pPOYm0hJSf26pICbKtNaikU5DFA
	 U/S6nh+N2DQXivdMIPPGodBLlMvtBrC8HQmLlt+ULI9AvjLpqil8V/rQJy2UnChTi6
	 ftHfm1WeXqb5CE0QN4p2iD88Ul3pfM14hgXwsT1IFq35HiYLop9oKXxrTe5GYRpXi/
	 I/Sp7dhmr/nzp30NBDpI30+t5oG0FrIeTIbbJRmSIA0V9OFq2zYjalzQ9hj+sojHap
	 Qa8PTdLL94UralP6excRizZNT2fDcMDT5zI8y4jtv4tRG9vPRkFT454HYmr09AAcxD
	 LXC7L3oEF6WBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0481E4D336;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:11 +0100
Subject: [PATCH v9 10/14] can: peak_usb: dump undecodable URBs once and
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
Message-Id: <20261126-canfd_check_channel_idx-v9-10-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=8012;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=9RVfvtPUX/zbiMGyl4FdNFk0kkdcNyBPtcH4qmjLdh4=;
 b=LN2dmVxab73fGsyA3uSKM6IJQOk4UYLIpI7wBu2bQAJNTC7PhHtHIY0EJnvHqoNAWWtgms1vD
 KkqG05VqzCABg5c57OI3XpNoRZDGbwYmUY6jxyBxBses6mXq9H1a+rf
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
index 43c16e743c15..cb5c457756da 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -801,15 +801,17 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 
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
@@ -818,7 +820,7 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		case PUCAN_MSG_CAN_RX:
 			err = pcan_usb_fd_decode_canmsg(usb_if, rx_msg);
 			if (err < 0)
-				goto fail;
+				return err;
 			break;
 
 		case PCAN_UFD_MSG_CALIBRATION:
@@ -828,35 +830,32 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
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


