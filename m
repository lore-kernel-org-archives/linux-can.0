Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FC3C9EF3;
	Fri,  2 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928916; cv=pass; b=qJpqWGI/h32KL8sWTimq91HlheDGSdqmSihS//C2qs54ebIW5CMH/U7oJQ6OMoXbIRncu2kVTUalLFe1xg2GhMlcFB7pd40bEI8UUYUFbWfzEIG2gmfCOI/lAAYeAzhb9IVOv33ybzbmkyL/M/S4ciU/5kpK1aSzw7rmA8yaP38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928916; c=relaxed/simple;
	bh=LBaKp4LrKWOQAv8zXqxrkHCc6v1nHryD0F9W73LBzDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZS8LxnrrjiDKgZfyU0NyTsgVxd5VG9qvwcl6BWRaHiCE5NVf9cJqGSo+JULmfaRuu8LKcadn6rha88FfvyZVJjy7anfSfZVpQ0OpRJfsrS8e0kpdFDmlv3QvS2siQLavfnY1WL8zVMKkBHP1TtQQocMav9Fmkcb5Fwj7ndqjYxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=e0hW4/gj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="e0hW4/gj"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CBBC12009BC;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7Ocfqf7HJ/mh9Isb0LideGmwUtfGe14wQxaYAhaWNU=;
	b=e0hW4/gjR0gkDhkyatOwkOTRNq2fcBJsfXBjdL3Ai+hNbhxwFMgKfjNEZdtoP+I4IDDAJ+
	zWA/M+ijlGaCxy0OAboSrtT2d+RlMyEm9UitoCMIwL+Tu2IFdf6xlEsJ/ZKN7JUk2WiUQ0
	BDLZ4xlJ5PAa6yWFRB+tzaf27dSXU9ZCdGe5QWO1c68oKaF2AUpOD5Dgi7svvJNJafP1kp
	bcwiQiDp0WPChgfOSwXanu4bGeuM2aRGGTSPEJCBhMpMmSh4RDO9DjiJWNNe71ACzkdiXg
	OcmcwgZawfXl/8s+CXBaTou4ryyZU/r4tpy5XgoqLsiivzLuxTWzc93IPE5c1A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=euWgTakOEd2TPqySDl/RMcKJpEFnykxg9kYo72ox7q8xlDvD4JT4/ZVSfwUjbyw1HO66Bt
	PWAqqUAnVfUPrPx5JOFke1Fij2qNly59GTSyANS0NzLvRNZxo2CoY/Eo/B5bGgMjdZr6Oh
	H6OSYEBs2+ibor2pw6VmsL0OLK7YEG4DWrmfFIZ7njDW9oeesIV5fmUMM1f+XC2fgrJLDU
	V5FKGZY1M88C8YYh71EuBxTIO2wPK4VsIM8v6troDQfucMf5G/CEsq4psMb6mQVKaMAWLR
	E3qoYuVhqum0FMk6f3v5yAsBAatjGa56zeUE0ENjvLYJxQNFl/B4kIg23DhcGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7Ocfqf7HJ/mh9Isb0LideGmwUtfGe14wQxaYAhaWNU=;
	b=IznTDMz6OjVhgK3JwZKfHlIbXVLVcOXrozwAGWmYbZpHUZwvkOtIdRrYsA6c281H7oKGnq
	V2GSDvVEeQvgcbuVqAg6pR+WxLFXBlAaJNEc4DKj3eHzROu7m4hMQipdylvWSexNnxz2BI
	UEM05y62Wc4eNdOEvE/Cp5AiLvNlw706fqADkUHrlG5p9vTqlRimYzMAUQDFUQMH6RoZoE
	dIN+Kd/f80+X2KMoyCrXze1YY4lwXTB1u7/8qr/JCGztkfSBLs96j3vNsX39+n0+zQY4XV
	OApZ74Z6GOvUdGTtP34LY+CaRHG1HRzIpNjJqtDwqGFXYFV1nuwh94dauCA2Dw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVJ-2J;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5A8AB5B8287;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:10 +0200
Subject: [PATCH can-next 3/7] can: peak_usb: sort struct
 peak_usb_adapter::ctrlmode_supported by value
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-peak_usb_enhancements-v1-3-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LBaKp4LrKWOQAv8zXqxrkHCc6v1nHryD0F9W73LBzDk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan5zP1ODgUnhm9dTXaTOst30InJY/p+mN+CSjlSIvT
 Eu38kz92FHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJGLgy/Hd7ECEtH7vsZdOJ
 hg6frQmWQn4zeo1KfB7kRmv7SaicFWRkON6TfN/KZdZ7E6n5avfXKZsWVnS9s579dktKbtkpTx4
 lLgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To support readability and maintainability sort the struct
peak_usb_adapter::ctrlmode_supported by their value.

No functional change intended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 785224e00c4e..169c00d93463 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -1016,7 +1016,8 @@ const struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
-	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2,

-- 
2.53.0

