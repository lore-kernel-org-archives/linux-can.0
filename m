Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C548428859;
	Mon, 20 Jul 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555325; cv=none; b=bPir542rAKqHKl+bKorNf/6drdRsDQD130EMkwIGzb8QY9c2Ic0TCETu4iONCkzrHBeA8vZcuSO0tv+3RJMVlj3+hN33HBEut8btkFxjUcDNBVuIElIfaeOy6mTMgPMcdVIROpMKk+q0iZvAg0GMeRJPa420FRiJffgivvhaagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555325; c=relaxed/simple;
	bh=MqHYo++apWD+T6h1LHWkcPl3hZ3jJu5XwcSk9HXDZjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tf6aED8cVijcgoB8eSMg8RYIkbqk4JQaU8ulq4loBd0vJd0/JJqulFCul6u2jwZOnGjF8YKTfPV+OKaiiY4LtoNkqVgax3pffd6vm6kU/ynkG9SH6myWA4aqYrF5sTJkYXGg/6MicL2RQCsh7o/HqqTR+96POOs350JdhjXgfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 412DD2028DF;
	Mon, 20 Jul 2026 15:48:29 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM9-000Pn1-0Y;
	Mon, 20 Jul 2026 15:48:29 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A480956E526;
	Mon, 20 Jul 2026 13:48:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:10 +0200
Subject: [PATCH can-next 09/13] can: gs_usb: gs_usb_state_get_by_hf():
 optionally print recived CAN error frames
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-9-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=MqHYo++apWD+T6h1LHWkcPl3hZ3jJu5XwcSk9HXDZjQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU1dIWHWlyrpPYDfzwpB52u1RMdXLpj/899CvMXrx7
 JM6th+OdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiHgcZGY40S5w4IzS1ZMq5
 TDORp4ytirZZP6fP+lZ1tU5A1mUd80NGhvmvA6SUJW7scXjreXZDa3HwlFr5FXuOb7nREytXfqC
 YnRkA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The previous commit introduced gs_usb_state_get_by_hf() to parse the
current CAN error state from the received CAN error frame.

As there are several gs_usb compatible implementations which slightly
differ in their CAN state and CAN error frame handling add a netdev_dbg()
that prints the received CAN error frame for easier future debugging.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e41f91b56ab8..2848cb1a75f0 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -670,6 +670,21 @@ gs_usb_state_get_by_hf(const struct gs_can *dev, const struct gs_host_frame *hf,
 			else
 				tx_state = CAN_STATE_ERROR_ACTIVE;
 		}
+
+		const u8 tx_err = hf->classic_can->data[6];
+		const u8 rx_err = hf->classic_can->data[7];
+
+		netdev_dbg(dev->netdev, "host_frame: TX-state='%s/%u' RX-state='%s/%u' %s%s%s%s%s%s%s",
+			   can_get_state_str(tx_state), tx_err,
+			   can_get_state_str(rx_state), rx_err,
+			   hf->can_id & cpu_to_le32(CAN_ERR_BUSOFF) ? "bus-off " : "",
+			   hf->can_id & cpu_to_le32(CAN_ERR_RESTARTED) ?
+			   "restarted-after-bus-off " : "",
+			   err_crtl & CAN_ERR_CRTL_RX_PASSIVE ? "rx-error-passive " : "",
+			   err_crtl & CAN_ERR_CRTL_RX_WARNING ? "rx-error-warning " : "",
+			   err_crtl & CAN_ERR_CRTL_TX_PASSIVE ? "tx-error-passive " : "",
+			   err_crtl & CAN_ERR_CRTL_TX_WARNING ? "tx-error-warning " : "",
+			   err_crtl & CAN_ERR_CRTL_ACTIVE ? "back-to-error-active " : "");
 	} else {
 		tx_state = dev->can.state;
 		rx_state = dev->can.state;

-- 
2.53.0

