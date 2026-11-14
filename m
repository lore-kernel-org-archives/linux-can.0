Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669479;
	b=a4EY8ADGkOvPOXCKpLEfiFX+oRSX+xy62LGTouCUL2QxRczfyqsKFCmXkbdXBL25Kyer
	 xN1GoVB83LbxlDcJqb/aR7uIhlZuhvryNjmYgqTmjamnXXNz4ScuLeCd+vfHenR8Bivuz
	 J7q5fozhPZSmmDXy0dAKrKOYce398MFolUueBp9C3AQxKY8M6M0ogA6/3zIws5L+rzMRS
	 coYFvQso7uthqBXmShekkxW1N48fRizCmb9vYAUeDrRp9C+zPMN3RJ2+sfMN/tDZbTEpP
	 U9xuk63yN+wD98CJi+jCDDaNRtOU9wL9F5Gi9rQO01UdY8XM70qn6qpRlm1hjq1Ndug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=wgeaGrU+ZGDk4S//HXjn30WSGfpEfeyqo7oacq3/Mh0=;
	b=p31sfYxwsNOMm/KEwymBByX64w2F7MoPSu+N6526Lw6mwYA4uxnlZw4M3A6BSFAbnsM8
	 JdkKyJ/hYGEtcjZRUnROxm/guvl7xwuTDjyUP3KG8EFr2j1zFs61jwkvNUxj7J7WMcx3L
	 oc3aZAwWP204nODNtQvt1F/5p0qNaK7RymqjHzXRvm57dEaWHwIHduWhHX/OanGy56mEF
	 KNpCrJIba2uqv5XPJPaitq56JS4FT6RG9gOXSBoRJt0oCkrpW6BAYjYKNgHbLT+OvqSKe
	 TCU5YDydJ47wzmSB0qkYzHLuQD6k09sY2Myl3F9Paq/tn/F4KZSatKqrs2aT2CCKdGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SEbbv6j3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C15606A8B6;
	Sat, 14 Nov 2026 15:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C15606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SEbbv6j3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7F4F220233F;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgeaGrU+ZGDk4S//HXjn30WSGfpEfeyqo7oacq3/Mh0=;
	b=SEbbv6j3iGPozC4HRz64Aped8SY7ZGdtVIg7G4MTgKdzugJPuHceymfGlyG8lzyKdzMc49
	AJLcdU91ECMmit+qX3333J/2t74IwWaw8bwbYT6QK2zdksDIBrHX/Y0HNeVsbpKFsgDkhO
	PFSOA+EcjguuJHx7/KRmndSFCdaMUcLcM0pozjp/batHmQOyNztU4DEN2WP3a5+6humqE6
	M8c6W33rqRfOQhLOnGTjfmug879R3wGzOG6sPdxyDu06C5+enel7Up2ALRy2FzE7ZCH6RB
	Pt4veV5/TJVuz37cAt5V/BoimeQpiPclV5Yu/5+KSRHBdN/vJleY6ISAc6mvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgeaGrU+ZGDk4S//HXjn30WSGfpEfeyqo7oacq3/Mh0=;
	b=UOekJHrLW6B72ssgoytknhVa8HCPi51Hi33MYZyj8UtN0zieK5T3ebt+LMIDJRfJlWhA3X
	/SmMdF+9jweOtd5Xzr+VfQLNe4nnEyxvauPxd2+2eP+5Lj8LVNjdMu5Ac2ER539kGcWwaP
	1y/fiCgHGUqc9YLx0ke6++qikQbN01kaqyFOqzI4hSYqRfsS38pWkZ8XgD8xosO5AnSVco
	eJ1qq8hUWRHl18bDxIuA+qeRFB1emD1FrHjq7U3QV/YTMDkHIE5Lhz8f+frlNfoXQU1Kim
	PZVXgDFtVqu6XeR5f3lt5gQS1Ls987PyajWgvlmrSSldtcM1SCaTGsgXIQW+PA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=W2e33z5/7r+KyPpYSolnjFfzfYqIhh8Yx+8rpSa7YQjjlqFbw47MfBphUY/GJ4hRC+HdGv
	/o9dcY+hy6n7OQI+Mzs8oGSpDgDpWMtVG0QTcBzgp3cu16sk/6AFejT5/WQniTZLv+/emb
	fXCehqcO53u+rtMsAmpnMnpIjj2o1Wd65so4Bj/NZO9zx3fwSYoLN1PD6saJT8mhy2LogL
	sO25OMPYTtslW1cAx8AdkhAVLu9MLsC4SLgO6dKyh2Ac/O9nQG+edMYojiUPsyPx74QclZ
	3egQ8JmRQvkxKe4Fu6xw9r2AbH3vJf7KIysprFj5A55wwx402msGwtY6uYTQ4w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oK-1K;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C3235EBB34;
	Sat, 14 Nov 2026 15:17:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:45 +0100
Subject: [PATCH can-next v7 6/6] can: gs_usb: properly shut down timestamp
 worker
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
Message-Id: <20261114-gs_usb-fixes-v7-6-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=anPjuxBHNcORebB8pE24VubButBEpq0cJkL7dw5r2Q8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6Ub3g1L3K/Wd/8mZwuNlGWp5eoGnmH+tdIbqgOn2Xv
 vGFG1fiOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjAR7R0M/4uZN7bwXauJ/TO/
 d7Hk/sd85sZtplZttdMPBKadnv1jVxDDP8vdz9U73kbe9Ny35OzpvW5Tf171ODAl3mBK9CxnN33
 rHlYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To avoid self-rescheduling of the timestamp worker, shut it down using
disable_delayed_work_sync() instead of cancel_delayed_work_sync().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b7780a23eff3..b9ba3775eb60 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -498,6 +498,7 @@ static void gs_usb_timestamp_init(struct gs_usb *parent)
 	spin_lock_init(&parent->tc_lock);
 
 	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	disable_delayed_work(&parent->timestamp);
 
 	parent->flags |= GS_USB_PARENT_FLAGS_HW_TIMESTAMP;
 }
@@ -525,6 +526,7 @@ static int gs_usb_timestamp_start(struct gs_usb *parent)
 		cc->read = gs_usb_timestamp_read;
 	}
 
+	enable_delayed_work(&parent->timestamp);
 	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 
@@ -533,7 +535,7 @@ static int gs_usb_timestamp_start(struct gs_usb *parent)
 
 static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&parent->timestamp);
+	disable_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)

-- 
2.53.0

