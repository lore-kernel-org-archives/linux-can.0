Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503055;
	b=vqzHrHP2sSFL3hw4wGxgEiozUiUkQiwgaeYbdiNDt5bjhqgSIf1ghMI/Dw9CiPz25frt
	 NE8gUzb/Q70R6C4OiNH98e5Urppx8RzFGJQTgvrcBPH53eEXCsZlCpUkb/RZOgwJz6SBw
	 gHH1J5+lawEeiRsscjokB5bwoAV8ie4nGASTS2m1Q9evDWYRAGitbpdgJM7nJ4yO/MJpx
	 z0JDzNT5L7Lv40ZPmOI3hfqc4iHsf/teIGyuvRXgpKXbW1qhlpPX2JkeAV/+bzMwWBf7Q
	 1kPCXDALBtBgmYeE8iAkEhFHvGmEvJOMli4vfW9CKhl8MDkCkt0d++1Zdp22KLZsV3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rn0dq4OJUF72hs3oASM40y1l4mpnOUy/FQ6ig0nlSQ0=;
	b=DKt7h2FT4lgC/fleODGgtbxSNGpHBzjnxMrK8k6ea2mCPOLt4rDCi/ZbRssKJbjHguU/
	 Oge2tvOP3YOU2eyyjbCgA7dwCfC8AooPSLHlTvMT+NLiN2oolJL3cndmQj9yAmFhmILQY
	 Ql+bx8jMxq3rD8YSPTteRG/2XxSW9DibNs/8WFCYETT+8Tpef34dw96Lkns2qaQZnwfDV
	 eu8KS3XoHP2FeBHT40uC9lrfCmTV6ldOoIzk2/kJkTw1GvmOeYF1EGPzNSvltqkSrk6a0
	 VQXLui/eyiE2FNFZ6w3D1Ow6uYuELR0sY3WvPwSXnZE+OshVtN73MY9Kb8A8AjotBZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=as+6eKuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DD60A2615;
	Tue, 20 Oct 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=as+6eKuu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503055;
	b=xXRIcatyHWfKilIfgRPau029CboU7WK1r6vegGXxszna7oPSp7PXaeo01Lzrokn2svAA
	 KeUDKPPTk7Ykgr80UtO5pCKhylk1ooj8E192VITnOht39tZqRXn1K7Xp1Gj61usdTE7g4
	 5LWeDBFsSAJtNaSCVDda8uVjvhCV2+OjNUHK/uQqOTQtAgfwtO3RX5s87OfoY4fFx9SjM
	 XvXipvh9XyyIktL52Ha8o4IGABfFUfjbkgW4ZrrTYxiQ5EBw4E5beoRC64xEEMPDUbASY
	 tva9vm3324kY21d/gfKzqnCSOMlTfZdvff4QDwEznGVcx1d+MuXLhLmcsWpGdQEzZcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503055;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rn0dq4OJUF72hs3oASM40y1l4mpnOUy/FQ6ig0nlSQ0=;
	b=KJ/HnBgY55ozbS1GjJMPnBJusSFHtR6eI0RznaMja5oqAjk0/OVmFwodG2+MhjaWshdV
	 sMRQtHH958wH2x/cc6gtAar+XzxiKFJW4Q7ZjGMn5NBJ3y0KLdELLyaZDktvH7R2fCH7v
	 Oa2HCGTJ/m2armQX0zwJZTe8vJXsgr5BPWE1K6l8pjyg/lWopW/6hnw2sLW30zyk8NIbk
	 BHBPoNN313LpcEhcEGZk34c+xIs5tmemma1SGIeC8DCiNE2CsLWff7Js6g/fkSxKZjQxY
	 9u8KFVfCbt88VZwnD5owjEw47c/BR+yTMbaa53NikWVrx4Pl0DZUC/4fTY1+FOuYd+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC2181F000CE;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503055;
	bh=rn0dq4OJUF72hs3oASM40y1l4mpnOUy/FQ6ig0nlSQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=as+6eKuuR8lU3rZakD+tHHrDaFgLGniVgJOobKCG2zK3XlYSVA8GQXUHCqkHSzu3l
	 y0qaEleL9ARnB3f6bc9mCCH4ENnvEhWYfG+OLhrC2ecET4MXJPJsZXGhmGsLGY5Uuk
	 Ik+2BWdZYIk3iMWCuZ9yh91eEGX+61hhjKiP5E3v6ubRogYFdv+4kWvqrrZxEF5LtJ
	 Vk9ppYoHJ1IN96P1BU5M6GCFdgnPL5SejUPtDIe/+EckWsOa7/pRKnsF2RgwZ6Al1v
	 4/Wx3ZQ4IlF+HKnupOiJRGg8gJIULAh1cyadtZA7TZcDo7Uhmhi620FpxQft4JUPta
	 FFIQu4u9Q2+ZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C6729431A1;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:49 +0200
Subject: [PATCH v5 10/10] can: peak_usb: only dump received bytes on decode
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
Message-Id: <20261020-canfd_check_channel_idx-v5-10-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=1495;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=5+0H6CLieTlayDGYhAUlDGDlsepQcLlbBR3MY1jBvZg=;
 b=uOlX9dpcdBnK33o4ofdC7Y7lbHSDP8dAz+yVgPG1zkLWP3YEX+yccOEgkCfhl2GqqU56gHRDw
 ZDvHHGb9/UqB5OMwdyDh4+ena56mweuFSdT6A7r4eoscMU52+p+ZVCF
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

Dump only the urb->actual_length bytes received from the device. Since a
faulty or malicious device can make every transfer fail to decode, also
rate limit the dump.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index a12ee6ec71e6..e146c8940420 100644
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


