Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727155;
	b=26ILTjHFTjlbaGhNBV9Ttz1KFoAg1oAUy5a+EqBFzQJlTEZVtw/zqC6hyFx58poJqshp
	 fqztBTZYAymHmIp5KDjYfGxmobf2rWBxUflf/sAd8FnZkrcpYTDKpS2yt55qEP0JxL6w+
	 PLbUnO0rXXlEzLnEGxLapSahcDALHsIMnJ7EQAVVXNXRXjQ+xUdiwoUVxjEBpQ/QojQnk
	 PVoaVvB8k/gouQhKECb0mYnxpGNPiKypQjYLphjCRnYZ+kXAcJ/xOCV2iHrZWVU7r6YGW
	 4pqoy0W6hUI8TFhZa+SChsCAY91wh0sJsUpPjfD/lswh+6Uz1W8NN5JWltT+afIygdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727155;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Nx2Hhs9mruqSuMkQYjMKpBZSEj1H5uCSUvdXBTQnimM=;
	b=a+uWg+4e7lcLterzaCyweSzX2lsbT6uIEOCjMB/ZubmGPdKLWWddsMgyyYkp0aXnY/0P
	 z2aCrE0idg5Tz7CrLwsvbpKFY7KUWkspqbbTA0nMq+g/RWVqrbPb8EqM/wYWLxQPEukGP
	 UnKbC7KYqmRAxGSa4KZheA8AqrWZoz0AQVsPPeCNecam+0BlifaLXTC3WbEeaIbpr4FP9
	 ngS+yHtAjy86BxuF5E3c6RwGyJQv8AAIVCfhDINKnUSLBZnqHwqBqu79WOrk/RaSPTtb9
	 vrLiXfzD6ZaIzOIpeqOIvmzX5zbNxx9D8SqxPmy9B0JyrstJVSR/PyKgWpX85ELbzXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MtQRZpxc;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VU5Qbnx7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D71606A31E
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D71606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MtQRZpxc;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VU5Qbnx7
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CSh6iRDWWZiYzqQfokGY8g13NqTek+r+3XLpDRYP+ZM8pc5dQIzfWGoZnnjsuZuXCu
    X5kJEc9P8yCoVYzy54lZjj1cSqjFMJ332Fxr6Win2zG7hYUeVnbv9rQSqRbH3j+k2pjt
    0guViU8UuVl/CbrotD7SyQac0IuqF9bFil3m72v1KktDkI09/bFGqDLpwz7mdFTk5vvB
    bIjKv2CZ/wOPLn6XOS1cMivfKI7scfE0JSnkeQBfEwJ3Hki49pHM0Z6PMJDR9t2Zwzy5
    E8gQU5DpZB/tUys+U8DgznQ1U4Oa3DBCFSLIPKib1XoezuU7fLhHlFo+Q1Y1UxjcOdEn
    RqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nx2Hhs9mruqSuMkQYjMKpBZSEj1H5uCSUvdXBTQnimM=;
    b=QCatekVYOW7h2zrnLYjXt4U+t59S92qYWqsoWQ1Nxbjw+33wnJFDA5jDWhf6vtyDHJ
    6mRYOyq5PBRE21kQv9tGRP5TJb90CtzPYaRETf7uXpkhkIO3hdM7JuIW2zhIkdm7aMfh
    FAAyJCmaVcW5PTjkAs2vZDiqCJkK/PVTxse19HSTlHj/tqryt/pw8q0WqKz+WVBs+iMW
    k/qF5TgvKm3ZQwotTxBhU1nHxDxvlkWWdCxKRBpTe/AmtrP9oY+xqrlY2bxX43OSyFWI
    Tu9XFD38HoHI5lhkSLdCvEH9+Cp/AOHxKvkL+fGFo6ys8P4eC/AwgJQtLtG2toEqN5Jy
    56Aw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nx2Hhs9mruqSuMkQYjMKpBZSEj1H5uCSUvdXBTQnimM=;
    b=MtQRZpxcIuQoTMy+tROs1M4u7mETXDiQXRrXMGgkSb+vcz+7nglw6z7nilRq123qHo
    OgKCyQAJ8vWOJkcbiMdukOVBt0Fwxkv9c2oTCC/apDP3nZnbl99gyRKsYFxATUYw849y
    JaiWLB65Tu+rSQhArr3eWdHR4Ptp8BZ7zarGI60yxYJuoqZH4hCg4Kjvh9TrHdncmVzw
    l2lj+MlMuhE/Zp5wslA1B8wh/3yRadnh8i3WjtImJdzdIC+E7w8hvCqkQN0k5hdATGtb
    YujYFVo62TC+PREE2iwKfKN6dfmih0aO7ZmFkk6AZZAieC2YUzcmjsNTr9yXeay8L6Sd
    uxzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Nx2Hhs9mruqSuMkQYjMKpBZSEj1H5uCSUvdXBTQnimM=;
    b=VU5Qbnx7aMGVEglAcICei+biY7U2UcvJODvYar9OyeyAP8/pctFILoSiItX3N3d8c5
    znZdw3atBl20qyPioMCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:49 +0100
Subject: [PATCH can-next 07/22] can: isotp: reject reserved STmin values in
 CAN_ISOTP_RECV_FC
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-7-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1339;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=qm+fixOxLGNH7t4M0zegX/j1G0X7xwIvcmJmrgPkzPk=;
 b=kp0agU7hX9kLzweJoPoOHrtcDcHPTszW72Uot4ajuCqwxP7j+riFSzEmtwPZYVglRX6GnDgHD
 SEa+UnPJ3MGB5dYXzubRwrr9q5Xh4I+ndzFp/Fvv3I7mTTnzKku//9p
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The STmin value of struct can_isotp_fc_options is sent in the flow
control frames of the receiver. ISO 15765-2 reserves the values 0x80 -
0xF0 and 0xFA - 0xFF, but CAN_ISOTP_RECV_FC accepted any value and the
reserved values were sent on the bus. The sender side replaces received
reserved values with 0x7F already.

Reject the reserved STmin values with -EINVAL before the options are
applied.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6ec7b10d7136..6471c0ef319a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1772,13 +1772,21 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 				so->frame_txtime = so->opt.frame_txtime;
 		}
 		break;
 	}
 
-	case CAN_ISOTP_RECV_FC:
-		memcpy(&so->rxfc, val, sizeof(so->rxfc));
+	case CAN_ISOTP_RECV_FC: {
+		const struct can_isotp_fc_options *fc = val;
+
+		/* reject the reserved STmin values 0x80 - 0xF0, 0xFA - 0xFF */
+		if (fc->stmin > 0x7F &&
+		    (fc->stmin < 0xF1 || fc->stmin > 0xF9))
+			return -EINVAL;
+
+		memcpy(&so->rxfc, fc, sizeof(*fc));
 		break;
+	}
 
 	case CAN_ISOTP_TX_STMIN:
 		so->force_tx_stmin = *(const u32 *)val;
 		break;
 

-- 
2.53.0

