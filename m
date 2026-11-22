Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=aZZBf1HBlUaZ5lMlNFmq8KGR5PFBzzdQ41+i68GfHvkDzUlnQuz8i0tzZ6TI5PnRNuG4
	 NchoRBx+8pHuUcIb8/F1VqPinU2EACEKRgZOkOd287cd86qGat3Hi0kLQij6ZEXXF4xkX
	 9CV/qeKzgJgvGXHn5czcr97L06+tqE4MFQbxxQ2mSxBJn2ieKnmYdJH2FuJ349/C3Lr5u
	 jzmfbWV4Ry3Fy/W8jFer2DcYmaAIyGDV8eL0/ytCp1rhkziKP/EFGK6QvRRZSGqY+cFe8
	 cEUMCR+qUagUomf0zCJSe024iuozBpjN7jPsXRL52DLYaEdxJGW1r7m4hpNJNOF2h6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=y+uLnV5NBOug/An70r9Mzj2OQyga6lymM3wHnbHy/Xk=;
	b=fsa4Hc4A5gs7s/20+ci3CtoufK9USwpQcBdQLGfY2cyxtE/W9+LzgBRGiGtAZBs1e4EI
	 MCmtCiH52VsIJkK4zSBcLYZGGMwmGIIfmnQlFNSxkH3cvtJqZEWdtyxGoHWQOu2mpVvKd
	 I/r2rqxHbNQn4iRASjwE6pmZ3AJNlT1GibPbBcPmZZEdobw31NVFfHokTgZnXKCGlP45r
	 J5N8hSG1NhstQL29iUnc7toNCzRqw5UZflVy6eRx/GwvrrCHs2sYRMvSHTZrDa3l5lE2u
	 6RyOTeVQJBZLPw0XSqNXJ6aCrWoT1nZSqJitb5Ywvdsy+Y/eJ/IBUxaFfDIrGWxmbLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RRoxhJfo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7208606A68C
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7208606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RRoxhJfo
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 81EA7205B4D;
	Sun, 22 Nov 2026 19:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+uLnV5NBOug/An70r9Mzj2OQyga6lymM3wHnbHy/Xk=;
	b=RRoxhJfoyeIT0zF0/4zffjoUU7Mviok3wBnVAoCKJ9WZLY3TzRzePuGobzvCZ650j7E/3S
	m8EDFMp8rUsDSkYpG9Vepp6V7OKUX0yn4MgdyGzYV5T3OnW9giGrSRabBMbKExd+rIQJxc
	g9yp1Am4Rn2MnVRa+5Q4Qiu4gkVv9aAledqIM6FqrAST1fkkR88yUFKmY3qNLRhuMqI4p7
	CB0nBskOa+sO0BaDHj/CGaxv7FQPp+eVj8NqpeIkjmJh5Le/3rF9uc67eKboKPP2RG6Yok
	qhH3zYu4/7eWo53J9MKoD/qYthE9juExg9fnt2gK29KONzxbeDWdJHrvQ4QK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+uLnV5NBOug/An70r9Mzj2OQyga6lymM3wHnbHy/Xk=;
	b=aDVAsmiWtWXvKVPGiNUOCpFIjsKX96/a94HLQjtWvqHuP4GD0uRt+Bhkqx6PxHt/7wXMxx
	YRK34Dll9MgLdpfJqGQ7dYdlf8EAkEyQEHQauTC1y59burHqlVy8TZELNmIxrZzNUjtXAE
	YXzhIy7vVzGGX4iGrVQifH5IkLJSTElq/23AxkJwhLw01WMQ08ffaB8XZ/aMAk+u6wtuVf
	hzHvs8zVgTIID+wdpkcZ0bwYaCc8TYgabPZqFmeQSv3ixsUa0BlTO6peP2zavYDRw82DB1
	FPpIr6lVxH6vwGgjFmh7wpZsk7Zdp2bPKEzyz5jWp+MH2SE1LEuy9MmaBu/c4g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373331; a=rsa-sha256;
	cv=none;
	b=UI8bmb5TOUDlUMFL5uzZRBqediL3tuzxl94yDizL1GBc+PgMYDVcEohIeoM4o04YgPey6f
	j294cz/gM4otBKSji+5PTRGBiLYfiemO+qDJFygQbgeBj9bbjR1yYOjlSIeyw1n4VnlBrz
	IUZDYKY/MGGUIIItkWEYRAUw+uUAsj0gZICBKoj3qE4RTSAxe59hAILrAGuvMgTfLKkYaa
	/yZWTG7FzWrS4AIwm2SKoNdCrg0f/FeEn/OnlkqmdWpBRhtrOHaCQgCFHHIfENJKNS1qqy
	s3d3sMTsA2XZi1Ehzld3vx0hC9vVbU6MYhfbrWk/iV+jfdpp0NvOY2wAVGG7QA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:38 +0100
Subject: [PATCH can-next v10 14/14] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC
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
Message-Id: <20261122-gs_usb-fixes-v10-14-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=oAGzbCJ31WlXU3PQUBLfgAGGcbMUIEwRRQLZuUxgprc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuRb/WjlpU11Fz6f/n3rsNTHXTuCTZ+q7t7Rvo1RR
 nL/1+6s1R2lLAxiXAyyYoosS3+cUBQIdCjtfZkwCWYOKxPIEAYuTgGYyHczRoZDfuuudmwNrPKf
 sWG3erVpK1eX/K8XQW/Fig91b71mcnoBw1/R5YYy6UZ25Zaxe9v3HBESPaLeo9J69/KE6ot7Tzj
 8vsUKAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

According to the respective CAN standards, the maximum DLC length for
CAN-CC and CAN-FD frames is 0xf. The code in driver assumes that this limit
has been verified.

Drop CAN frames with DLC > 0xf, print a error message and resubmit the URB.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7229d002b938..5e8ea308fabf 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -668,6 +668,20 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
 		}
 	}
 
+	/* we can check for max CAN-CC and CAN-FD DLC at the same time, they are both 0xf */
+	BUILD_BUG_ON(CAN_MAX_RAW_DLC != CANFD_MAX_DLC);
+	if (header->can_dlc > CAN_MAX_RAW_DLC) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "out of range DLC (can_dlc=%u, max_can_dlc=%u)\n",
+				   header->can_dlc, CAN_MAX_RAW_DLC);
+
+		valid = false;
+	}
+
 	return valid;
 }
 

-- 
2.53.0

