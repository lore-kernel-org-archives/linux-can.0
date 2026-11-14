Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794689418;
	b=QJJHFLsHekXhLJIaj06i8qRggQFjpKyu6k9Iv0NlYrIV6f8LzpMoHiuorV3ebfp3d12p
	 ro/dyIqB5MpjP0b5k1+7OtJNbzarlElBDKO6GqcG8hDMH5EFhh3YHUezlTbp88jkYr9Ts
	 lPUWgox6MFGf/kstaqM6CnL3N4ZP5+MB8IdRER+1Eg/QzgaZ9aJhULzQR/a4ckkh5U7y2
	 LVOnil4EtY2+IX8RX5D4fykHcjHyk50wFifNQ9qOir78OwaT2ehSVjn7/jhYg6bMsE6Mu
	 EoTGoOX64q8aqEHXoKxLQodPRs9z2UmCTCWEMZNNhjWgpdlqEzqcZ/Gcj0SdCc3E+bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=rMjld6G0sjvFZvH5i6ElmdG5KAln3gEdheTvcCZcB17pW/XDHkRj/0cTOeMySUrt94KH
	 9zA4BiP8LDl8JBmrD2uTS2oq5AQCiHBFTi/rFhkSmrwQ1AGwV+Owr878KzQQtg5YsKyu4
	 NF+FwMIfJpiDzYzLUr1LAwrOMMJrCmubTGie+FRS7jpaRr/LtJlIdGRlIHyXdOBl4Q+BN
	 JFpgSzX7ZnDZQfV1rBiKgbAR/JXMY6O0Dg9OqMJ5uZk3pjW7b1N9kWH/pdbAAWxdAXSrH
	 q/5kI0C++MwbwvsDC0P6hIS2paiEsQhGiwWsWR8lkQmrT7/hgUNzxnMkjXiOnFuGuhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Q7wWKJ51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C80606A323
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C80606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Q7wWKJ51
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 65217201E6B;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=Q7wWKJ51yWYORXfHn4QgPjTKWxp1ODbgQPY0DvA6RzZZ1kzXFRU5BvUN52OIdPHRzr1AM8
	K8OsB3XcXuIBwDTOKNcKTwvTdMwazz+CGLhBL8gtMb4+1oSJEzZQMPwZqegu61RLPZfBPs
	QAL/Ukg7tCsKivRMvQdg+LHDEcKxSfKZSFXntlvV40DGVJYQU3lQbP6QCQinWdd4+/Ma8h
	sMhuHiryZxlP2OZujfWk9US05L8urOd1YwFuyE6Oqxaj2JNLwqu1GRN1yuhvXCcbLIMLkl
	mIGQRBMYQvTtA1iLUvN1UKZL8tfkJkVdEglLFtDJZKOCfq0gb3o7rXFOSFDgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=HxXH05IE0u37O1jy7zsx6uqGtG54d4izY9FeKWvcZcfo4XM0UssXiAEfcPHtTRoR9wtUFI
	BvH55v+9SkLG0MD9UwIUA0IpGlaJCqgdJiSuehy1YF3/zdh/aL0Gn0g9sh+xxkCC7uX0wJ
	ExUuJnLLRhhkj4A3dI2eRSy6oQb8hhZS0B5+H05/glNClxBeOMjX8agZAKOpGQSsHs0YY6
	AeAHNcbD6e+fB7KNewpalmNXZZxMQhlndEswSgxKo+AJZGB1t/erTN9IBMn2vHqOvcUCq0
	QWjLhcGx9kV9noA6oS0U7AYNXqzBOtHKoT5HH3dTyn6LReZsoFfEFObyWdIBsg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=Iz6kemAXFjP082GxYTU94uFaOYpWr9IlCWYWePUMOfVZQUuxcNduGW8Vz3/gLmKzmuZUrm
	rG+jU5SYsa5eVlqxkxFNmqGQUHj1j7Dl/cBJlWrv1lvRrsCnc7dPqvgv2bpeMZ9G8OheOj
	9ZOvBYpeR58BsuhGYFVQQPif0XUXxPQpZ6fJh61diUaRdwkm6M80VcrATo3dgstlXuZ+NQ
	dsJQMkPCBIrCJjLhsAXgTuPrdI2R0gZX55Wm0REJsrBoD208g3n712ijNdJZbMLBLfJS+C
	si2k2RsGER3BpOBTSLfiXufVZKG0Qs35Has7zMB2qvj9Yd7u2fY/1eun8Vfi8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfJ-0m;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F28515EBD6F;
	Sat, 14 Nov 2026 20:50:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:49:55 +0100
Subject: [PATCH can-next v8 1/7] can: gs_usb: gs_make_candev(): check
 can_rx_offload_add_manual() return value
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
Message-Id: <20261114-gs_usb-fixes-v8-1-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HrJ42yGVaRq800QIonNvQZfBfXcR2a54KKUkfxyenH8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbJO7OzSCUd/rkg4q+fsp7v0Xv3r6lbVy9VsK3J/C
 Z4QScp06ShlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEWEIZGXbG7PMN+rHptVbg
 lc2M663vK7te+vI8cFF4rf7dieLdnVsYGb6W/rqScSnq70KzzDUxvYVFbZp77n0XOiPSUddapOm
 dxg8A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

gs_make_candev() ignores the return value of can_rx_offload_add_manual().
In an upcoming series can_rx_offload will be improved and
can_rx_offload_add_manual() can fail.

Check the return value and exit via the existing free_candev() on error
path.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Link: https://patch.msgid.link/20260907104942.17089-4-ciprianmarian.costea@oss.nxp.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..cac4ce323a1d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1487,7 +1487,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	if (rc)
+		goto out_free_candev;
+
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	rc = register_candev(dev->netdev);

-- 
2.53.0

