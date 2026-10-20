Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492927;
	b=EyTybm+zhWYbY4gI5fkFQVFhsGr9AuP+HkByfb/kxxOvIklrHUB8IAdGOfqPvkxnY6xJ
	 QUoJjNfhQsNPIoOZHC2E+VVxbWqEiQJxnzj+85VwxAPzyfLVnjbZYqLzb5SaztCE7CZ/T
	 8wyR1VX+IKBElqQON35/ibh/gHmFcnk0/gSZL95Tgy42mzt9Y2r5fuWyD3fXCnz0tVOZO
	 GwbfBFzfVYKAoQMzoGnErd1mY6b63vd2qFMDViQp03cEBV6/3Dl6A4mv9wnri1wD46YsC
	 2VhdiLdWc++KomMqApkRcX0DHZqzNtelz0CVa5jEEw2XYd7DIyBxNohNa4i1rCz7avQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492927;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=SzS1WZkbMVxMj9MfBsNaLXiCQUGMSdIL3Mh0PMncUuY=;
	b=TIyQGoVEaEkd/JLLh7dV3Q0joLJdBjAW2E4QeuAbkBVXYWZz53v+BecdSTXBFu5LAbk+
	 WfVb/KvKb7RmtJMO0+X3xlNi2EEeCHYc07Lxc9RwByHoDyroR/2+sRhJWS7Uuh8UtuM4u
	 6rPM9WwdOSI/AFwWEp0djjK8pOcrGguFAy5MJiDc+gy5GNZzFB5myJ1t4OyLoq7Gl4g5w
	 DRoznTwr3SvEE9WWRNctSug448hMgrPhQj+zrCBDj7HtBr3j992v4LkjUGVH1hAmCvboZ
	 qGUfpNoHom1UlRviRKZ5YOFekDVEkouYDCOiw3XevXPdYJG5N1uAljQGMOuQQTNUW4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cMtEmoig;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E599606A319;
	Tue, 20 Oct 2026 10:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E599606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cMtEmoig
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 45636780331;
	Tue, 20 Oct 2026 12:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492925;
	bh=SuLF+hZJLx1ZNzgNEWt/n8SV2wSInY8IHJ4CaCAP+Tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cMtEmoigRlFFWd0pGbgdOyf3/HMj8IPcM4WH3MiliKmqGIP3gXX8x4vMQcP7EN89Q
	 cw6ApaEsvXj6wxm1jfgmz7US5si8syupI8cKaGAd7TgUDX4Ei/0vXZcCHpKz/hLchN
	 RqMlNq+WQNMPWs+Nw6eT8ujhYF3EwHfImR1xYCvRdEVI93OVQVfickOi4tBcvjzq4J
	 t+IHec8VMol9XxQiqXBRipvdk235Q8UX9yfYQiPR5YC3F5QZSSSMbB9KIIQg7rqKlE
	 JnsUZWne33+GWfDQ69baYpTCeE9HfABUA9sYp7vqa+b0IHY/zPgj5wVNWP22D3nsJt
	 6LXYKC/FF+Utg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:25 +0200
Subject: [PATCH v4 10/10] can: peak_usb: only dump received bytes on decode
 error
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
Message-Id: <20261020-canfd_check_channel_idx-v4-10-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

When the decoding of a received URB fails, peak_usb_read_bulk_callback()
dumps the whole RX buffer to the kernel log. The buffer is allocated with
kmalloc() and its size is the adapter RX buffer size (up to 2048 bytes),
so the bytes beyond urb->actual_length are uninitialized memory or
leftovers from previous transfers.

Dump only the urb->actual_length bytes received from the device. Since a
faulty or malicious device can make every transfer fail to decode, also
rate limit the dump.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index ccfc26d3e5a6..b86ea6f6b07c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -265,10 +265,10 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
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
 

-- 
2.53.0

