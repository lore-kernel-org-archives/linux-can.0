Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487426;
	b=I6v0g92yaIk5W+WMAU/ZFXh0G5oKErJNzj2VNA7jp/VrKkZdqwtjwjbFEfpom2qQYn8W
	 wXjpgLcOUl0QFqyvXK1Aji6NQc+6zT9zGkX9WD8XthX5mCxwLS+La1wRW1N2rhQXqlMFq
	 Z5DJNaJi6vrpiU2pVdqjgFdEd0gWtPODVHQv3QXdi+bdv36XOzTmPYK4wxB/9s8Plb5nd
	 ZRl5WLL1CZzAqmb4Pup8WOAUWJ4Hj4lGGmtcElSHwxHvvgC4A117x4n7E7EFNIePqmAsb
	 0FTyW7UNJOFH0tNdIeiEKc2wuwfJdZULttRROm8+wzXAcoqmM6ntaM7YUu38BPojlyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487426;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=AkyypTmvPkPUmubX3/0gDGnoh656aQxePoJteu5PJcw=;
	b=Ed/hpoMh4Ra4r9a1q05Jf2UY2yheLbjx73yh1ipkVGUad7oZ2J8AGbnnTIHpt1IAaBHE
	 8h1D1QufiZlGVLHXXyMp9RWKkQq3X2WRKIgm8oRxI8g4yugWm/4Dt+qlTUcIW4a0R/fVc
	 SlbcxBqvwW2KSNuPIGD0+tT6b/xvp+L/tUjBfS6ZNe6fLnaSgzLV8Mb0y1Gq9lXfYiQfv
	 aJegwlCrSQ0M+wxeM2TL8jxEKIbFvEC66sRnT7MoyXDMqdup4Rw6Z1cEkcdU24mLpg1uQ
	 +9tnDrdG+Om2WlAjCE+0/XLWK5v+QslJ8vQEUqRlmWBQ3vhDCNSVKES3kU8P4sXeAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=bKdWjY8G;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AB606A320;
	Tue, 20 Oct 2026 09:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5AB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=bKdWjY8G
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 032C678034D;
	Tue, 20 Oct 2026 11:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487424;
	bh=175YASg7NE5RkH1KogVDWnvba034y7MXNXUHYyoe8To=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bKdWjY8GtP3y/vxjFmhvhOfE17q3SPhtLmBs3pOEdUz72X1s8hzb3F8r+Vi0Szuc5
	 Go96GJX4flqYuXWLYTrXrG/wbMUtVTXRMvcdVftwL8B47sKXRdJOmrvqKIVEjVmnim
	 XEYwm+Sa6AR+LrV8deZSeI/nuFx0FTpZfW5/QuIndtuQv9WonG7oOmBiPMzMdD8yyk
	 O49lIfdAFopDRa8MrGQ6F2dXVr45XPaYxkrCTSB6FcnFHKKQx0Te4FPztWGXAEuinj
	 pOnCXqGwSkRVPa2l52Y+z9O992S/ufpL5Mo11r/3jzJAZYbm1eNrTx1R1gcRvIF12c
	 TqByBtnIIBeHQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:15 +0200
Subject: [PATCH v3 10/10] can: peak_usb: only dump received bytes on decode
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
Message-Id: <20261020-canfd_check_channel_idx-v3-10-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
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
index 981168fead92..a58317cdde4e 100644
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

