Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679279;
	b=P4JjYhiFya/FTqUQdkUjuMnJn1kEpmV1YIYmyScT8T2QWeH02l2C7P9zMdK7SzWovToq
	 yieJOSgu9zhE7yL6oMIe3eUL4+o9ld7a6qc8ArQbEBX1lxEn4fsGAOCk9l7+yeachtNCY
	 Id4YkGUdpvqbG8aLDgCNWapZxVhnEGHf4eLnYEjr37zVCLmqcsxmhfCr1qJ95tYIgmlVw
	 3kJXwaIrUT0SXXqA33VIRth5sKhVQH2Q0/DrwnM7WRCJe5402owSo6ZvFFbQK1fiTIbZd
	 slmSc4npsIgHCTJOL9v/4AMrKTB8FwP6FUv815a5nuhOP+Be/ORVBdBoaA2cu/7af3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679279;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FR6NkCzmZATwURLs0dBt6uY/YeQ05Xu0D7btS1Z40KA=;
	b=lboDt7OmJxRL5tYQ3vTk89CceyNi+xdIx51AEtuOLD816iIR/Ur23b+OMUtubsYHZHDR
	 9JhEs2gnqvgFKZRcUskFAV0M4mCtPQQaZwR3V03JwpxIv/3H7540evE7EVsXl+c38itfp
	 yEaAEalWjoUVLsbB7NAxNWVKVpQDoGwtqO1b394CB5sNbxZvwAoeuZixrF5qXFmXpN165
	 z7KsOBaf0BiFFVw4Zr9DQx0nVSmlphf43ccQKU6frlCntNeauT1dUk2u45n/3UH9uuavb
	 nEojlrqwukGEkKWd0sdrSspehUZIDHU9PRrTLiWRTMJhjuW9TqYxlVfr4OM2SljedKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ1N2R2m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288960A2605;
	Thu, 22 Oct 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ1N2R2m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679278;
	b=AjANjPhi9PAJOCRHd5+zmNRgXKQzhyYn2HH1Euah8jKDOfbII3CiZ8PFMNafofA68+y3
	 twrBZZkoEL9z0cLqJ+b9eYO55lSyKE2J5z8skXGhl8Cfk18pNMxZwg58mzzmRw5bHow28
	 2oZwnD1CFY2mRpuTMNG8X0yid8ujcOwdC/C7MfMmeh0xsrASIy5HPdAySc1syPEpDS1F8
	 KMQjGFuZMdaN8UpEzx8vnL3mTgIyG6cRCvUxwTRtsGid8z43PXoKm1b/1OdNZQqYAsdgV
	 /9Liz4fB1HSaghGfdrQrWQ5vihaqugT8OwwbHh0ipb+Jl9/x0yxJ+RSla+WnuVbKmjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679278;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FR6NkCzmZATwURLs0dBt6uY/YeQ05Xu0D7btS1Z40KA=;
	b=uFHujIvPJ/PjTPW/DY0ObE6/RlcCgm/QiLFoS/bIgoMHqTIrzfl4U6z1fHEK2I499nwi
	 z/4qBu3HyCLYKFY877Y4P9Yjac4OyE2MfmAIzA6qEcC3T2d1+gA1M5AoYCMgjHHZblENN
	 ETu5Mr/xzH11BkzXQoAc1/kW4LsKFpah6GKXZj2p2l+1+xGA7Xav3zFfTjsvHpClLc7PU
	 2LosyMV7ntz+sGrzlwcFx6GYsDvgOaZBBsdTV4kuGmmgjIo0SgYfNbL87Cz/ROx1iyR4B
	 /Ka8mFMGos2MfHtODIi8//e21S4teI4z86E8TwofZNkqvbBX7der40r42vHxgOo7OUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1C4171F000CD;
	Thu, 22 Oct 2026 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679278;
	bh=FR6NkCzmZATwURLs0dBt6uY/YeQ05Xu0D7btS1Z40KA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EQ1N2R2mrbegC2j2Z3HPXtdxQLjmraVW/KP/cjKBisK+40PsTGhnPE820S3AIq1d3
	 0tryO8VvzNF5l+J4bf2429ZmAgNXxZmu0RwlgbYNzQc4B3EaijaCXs6jBpQs9Ou6nh
	 9b/lARhN/bjbVs5+uujDyZ5arWClVtM3e2qVSoajuUr0DXAMWtx95W2CWcHj2YRHeb
	 Fu2ZOIq4lAfGFPQ0eWFYp53Ej7lVjM5cYCruiFnyC9TDwdYjSStrp6bo4eBQi6bc4S
	 24opYyc+D9Xp+NHjlPmaEG1T8Pk2R8J60NY3PAKzBA8S5qrUSidvnGef683Cazn8/L
	 hitBUhAb61Qbg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E6DFD435DF;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:57 +0200
Subject: [PATCH v6 12/13] can: peak_usb: dump undecodable URBs once and
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
Message-Id: <20261022-canfd_check_channel_idx-v6-12-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=7765;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=PIkIJvUB7MFWgpDmG9LIWZCMQRaBqM+vEZd+unuigLQ=;
 b=r6npXXE3CI9cW5YooWz5H5KzVNzH2XV5Lz8Bx5B1ODPxl6WPLiVGc+aM5CL4NKRYuRYMIA2V4
 WGjlvf9HtJKAA1Ib/nromQGyh/TMweGxbRHz+Htkyz1uopqF25VO1ux
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
index 8a0a132983c4..04019a9b868e 100644
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
index ea6c28f3ed0b..67457d094b60 100644
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
index eee5b5eaa247..9c34f431f773 100644
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
index b869a20438cf..9fd603a868d6 100644
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
+					   "got unsupported rec in usb msg:\n");
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


