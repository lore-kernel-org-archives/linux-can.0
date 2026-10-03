Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB337F8DD;
	Sat,  3 Oct 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068028; cv=pass; b=jw8EQUMijQhLm0YawOSG9OfR/5zYEc//RwaDLCtUDjepla+XtR8jGvytj7TzTmADi+5bn5IXAUb2pGp56v+zEVistGUZPijgMQj6Tfj7Su9PZDiDS/IHqyRNQE7vZ32/ktshex4EjyUoUDBCe887ruuM78jRJTYRyZ1CDFuHpAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068028; c=relaxed/simple;
	bh=dAUEjOag55YRGYpffHiw6WsfcMBQaN9R/cdnkzLtA+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psqBu8xfIIwMU+z4uMNaXna1FxbNexejTgG6a7CX4rpgZO8tIr+M0aIXddu7ONpC9mmh9r0k+GCCo1RTRaoYOkcsu90WsIxmhocT2Z51OatrGPsdZEdFpLu93Xg2KWJNWVuVSCPDriGH8YWH+mVilx/O7CNZxItlqGbT2GsZC08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XWBBxxCa; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XWBBxxCa"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1ADD62021F9;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIoXFaj7CalDN7WvVtGy5u2G1Z8ClV6T1Wb2Df9aUtQ=;
	b=XWBBxxCaK/mHHKiIhQM0IdNmbn5cQ2qRgxRzseQPwVUmG9rBgGVfR2eG2gOJsBN0XL6Uhu
	SwLQcBiuJRwzGo//jpskgaVT6I2OXQzEZA2nyE+UH0vTNG/v6Lr6V/bTC+ygh1sXd1xTgp
	XBAEB0V7F/RE8IIbYMjkttWz0/Qv4IgAtr9toz8Lg8dJKY+a3YWsnQz0zTOpNuFwuJpcgZ
	t2d8aXWfMfsrT3V38Labu6O9OpiuBCBqNoOtYY8+HX6XYqPNwXP5Iz/k4804gu90bAz4Av
	TQPnf6LX0ZdobykBlk1ZUtre+wlqRMkrZNhzjnN88e0GZVi6DDp9iFbdOYshzw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=LoPADx8fBmU1lnBzsm2BmI929azi4Xx8+q6pDkmvspOQpPDyX8lFER/sicTyi1u3BmYm+3
	far+3mnX0uUsUdka+Agf/cTO9H+yWaFqxWltnVWtbtRQgP7cVFBsCYoRocffXOubHfKlL8
	426AwfyOrSG6CNF8miaDqDqkMiNDL61bkLLbAXO1c46nj0yjEdoNsKndefkXdy98dY01DQ
	kFhH4rEk3feSy2BFtxYB5OTRR6gRYlfJsvZERBU6oEpzA32G/X/aNPjc/GGZ065VWNsHsI
	qMZkjQREV6uhDsev2Be6mO3OG56aOQKSJiW0W6+LCVMiCbf7nRYS2bGm053RlQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIoXFaj7CalDN7WvVtGy5u2G1Z8ClV6T1Wb2Df9aUtQ=;
	b=FAvtuLpHxNoYsS5FN5d/nNxcr/Pb8wUGsdzpfRqTnXb/Cwtdft+VQI+p6mtXexdvwU+xRg
	HV1HD9EoV6OCqYM2ZvYyD2pY4oo+kVrA0kGeUUs6Nu4dUicTN+ndJIj/ggfERnhoCbD4pL
	MOST/jVLUOWo5JuXp/I8CET1/QCzw2oCj/Jcb0SBpX1WZnL0v+hLQW5j1EATBXVC8XhzjO
	mDKVN/v4+WPJpfa+8eYNyTTxnHUNy/CodsxKEti/dVZFWAWncvIW4aAnBtF+sv8nCsgCpL
	Yrt8oJoWbIoI2zk7DH6bm/CQaXT2i+Rn6wkwWs+9LzIJWvXMyaCitz1rH/5KXg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bv-0047md-2g;
	Sun, 04 Oct 2026 00:53:43 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8EE475B93A3;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:10 +0200
Subject: [PATCH can-next 01/10] can: gs_usb: remove unused define
 GS_CAN_MODE_NORMAL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-1-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dAUEjOag55YRGYpffHiw6WsfcMBQaN9R/cdnkzLtA+s=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62J79mYf7zN8gtVzZ/ua7k9UP31O9osm94krO2mumH
 V7srolTOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRkiSG/6kWNy1PCVTf0Lrx
 eelv9cqq9G0KHCYv9N/d8jZ+UDhpWRLDT8a9bxnY1cO5pS8WHNGwF6qufLB2jwd3x/eCOWtWaK4
 LYQMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The value GS_CAN_MODE_NORMAL was part of the initial commit
d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices") of
the gs_usb driver, but never used. Remove it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..bfb3780e1163 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -127,7 +127,6 @@ struct gs_device_config {
 	__le32 hw_version;
 } __packed;
 
-#define GS_CAN_MODE_NORMAL 0
 #define GS_CAN_MODE_LISTEN_ONLY BIT(0)
 #define GS_CAN_MODE_LOOP_BACK BIT(1)
 #define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)

-- 
2.53.0

