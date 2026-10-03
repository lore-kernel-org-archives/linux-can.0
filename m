Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB03B14D9;
	Sat,  3 Oct 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068036; cv=pass; b=dgzvX8fee/lE75Auxb361lwy+9x2sciMM3YWDmwuU8ZqJPxkLbE9Dr+Jg6pk3O2qDcJPAuHgarYRnXkQ1XQ/zvV1HXg6fAMzd+RjuGP6H96DM9MocBR/s0NExHoYOyizX7NniSmKULUysgZWvYA+fR8wTulTVtpbJF/tFLvZ3t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068036; c=relaxed/simple;
	bh=rtyG7JQ9kY244DflWLLJeoaVdKaEyj8XGNyH+04iHI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trhEorIA1jrYb4g0R5wjewHGyUPV/LM5EoiKHH1K8ucEgyyUY02yWKMcq6whpcVJm/jBTs8dX4u38CiXvKvWvBV5RMWVJOlULkHz36UgRkE2qfMUTbv7p/YOD3CRXys+9E7/SlvX3wnv4mxAzIA9toxoax8lu7Iq2z4n9zl+TXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NCy8kWjj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NCy8kWjj"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 49843202342;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7AAsI+Qjq1ZgXd2okcE5XF/btwVs8BIURQBQGJxyPo=;
	b=NCy8kWjjSYbEhfhbYiFCuTB64cyRng0hONgeBKXALLU3og8nuu2L/awUPq73E7/cV/Xlb4
	LUgZXtwEawAvrgdE3xGW+SS1saCfV0h94ttSV3jobQOjfRQJ4GQ2D/tAOHxmbWLmGQoO/g
	HT0y+jGD/dv5x+fx5WU06g842KZd3gCgKn0IaDffa6mK/46PHh0uippm/JvEkD7i9tEPvJ
	F6BlHYL50RfEdJsTA/5Z/qBm1mz/tLuy6BXNerWIEQv885OejjL2KMDpTH765wxfGgRexo
	ImZOk+cANL0GPz9swjDUQanxYHKviZ+6401kVRPT5m6fb4GjH0SXNzGPBTPMww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=a3mliV2Lmws6NCvWN+ypKaF2ssbyhuK01+bx61H74eIkWtGFw3LoWSn+GXl/dVkwuGfk9D
	cWFlHQXEv1BuR1mAAleqIoumny/urKNdAo0IbC6gqrZotzHSI/3ILEQF2eIK7AxyFU+OpD
	+mkU60PpfOx2Fq4Lu9spmasAvE0G1zX85dfxMtX2iYOgXu+45UxhudIW3Ju8dbGOWWUsx/
	D/brF57f3Cd8Tx+cwXMBeqrANHAlNdSzz3mVl/BB37Xsx500eklQNWv/+FMQ6PFS8n5x5Z
	KXIfXRQnSv5H5asJw3VEuEoolp+h1YqTo9vBjpD+UrLfnVWKekmJ2DwkxWmVow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7AAsI+Qjq1ZgXd2okcE5XF/btwVs8BIURQBQGJxyPo=;
	b=E36CQMxnMxH6y3XzNIcElXzioiQISRHxDtULV003rlHb36fVSs8FGwpt3JO4IuVwBNGXLI
	u7i/SKQ1brP+11CLYUpwxIRLIVlVUs8RTcaeq6LtgKbqhEj6URzRidVukIWbH/zgl+0cO9
	9nu5mS6l1fNCclvbwh3rzpWjqvAJdxrowbyU8OEH2Mpmn6ztD/GbN9jlDTkNOXz8fQ3yr5
	Uu0FWr904hTSh0+pxvO+Eo922cwX017n26WzW/TV+IeFIfymcMmnvdMKMmKu5gKILAWODc
	SfIiCkLdvsez5vo089KU3dsAH1BVnre1OYilOGSbKmgy/VnMe0iN174HEDebKw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mm-0H;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B44585B93A8;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:15 +0200
Subject: [PATCH can-next 06/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): add missing call to
 can_rx_offload_irq_finish
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-6-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rtyG7JQ9kY244DflWLLJeoaVdKaEyj8XGNyH+04iHI4=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F4ouPz5y53Ws8zFHktsldfYW8F40ldSwUn41e64H
 1qvJx+16yhlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEfvkx/BU90HjMo5fxdFMM
 z9KmsE8yV4WtPdVf/7/D3r71uveWX90M/4sm17ofeldqFHTqFpe2tqGHUEfSphNdsTKSAbsD3ns
 vZwMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the overflow flag is set for a host frame and the allocation of the
error SKB fails, the URB should not be resubmitted immediately; instead,
can_rx_offload_irq_finish() should be called, since an SKB may have been
added to rx-offload.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 01b4b6c980c9..848a84a05fd6 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -719,7 +719,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
-			goto resubmit_urb;
+			goto can_rx_offload_irq_finish;
 
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
@@ -728,6 +728,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		gs_usb_rx_offload(dev, skb, hf);
 	}
 
+can_rx_offload_irq_finish:
 	can_rx_offload_irq_finish(&dev->offload);
 
 resubmit_urb:

-- 
2.53.0

