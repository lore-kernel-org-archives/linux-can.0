Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434603C4B8D;
	Mon, 20 Jul 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555314; cv=none; b=iidTcMiYV0c5oXDQOmFz4deqkR2hKJ095+pqDkFl/QXHbepAqs2FAj9mE84n51nDdZKVr03fQZIt34Qdo+pws0+wTu16UJvnvh5DWwG/LjnS2qn2nhuj6X+DpDZJryjK31aS6a3EDXYiUqqNuyr4Mm2DR8IiH01gwl0FFAV2xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555314; c=relaxed/simple;
	bh=678Zr/WIWFbbaCsHD037iimVE7jfgcIpGLsxityWbN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cpy48LMoFw77de9OF8TldFqIMd9ddc4nE2fDkI/Yia0F65yGHESSOrbDD28Fau4+W4Vo1dWM7t+6oV6HrxiF/7S13FnMPt8NpmCpDpZkimuYo5Roh378eKp6XMCm+0WdZH+HkSMUG1WYsv/GDEFHZeVw7ppNnDLOSaZKU6d0baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ADA9E2028C9;
	Mon, 20 Jul 2026 15:48:25 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM5-000PmR-1z;
	Mon, 20 Jul 2026 15:48:25 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1841D56E51D;
	Mon, 20 Jul 2026 13:48:25 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 00/13] can: gs_usb: implement new features
 recently added to candleLight firmware
Date: Mon, 20 Jul 2026 15:48:01 +0200
Message-Id: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswdNLUb9FRFJ0m09H6LkElso/
 XejPg67MyspkkDp3KyU8BaVZ6xgdg2Fu4sTWIbK1LXdobXmyJPeinqOmHmEyyVB2SGYYe+tPZm
 eqvlKGGX5VS8UXKzvJdP1v2jxD4T8jdK2fQDwkAywgQAAAA==
X-Change-ID: 20260718-gs_usb-new-features-aec1d3b77914
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=678Zr/WIWFbbaCsHD037iimVE7jfgcIpGLsxityWbN0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKUxe9s1Mqos7lZt0fbtOGu2FJ33n5ps9ROcM0q3BK+
 YEXC3pzO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjAR4Q5Ghi9qixQc3s07f0Te
 fWvZ98rHqyff6vw2yf3e5byQ6ap6rasZGc5VLd/RM2fnj5iguaYGhg3ngqcs+Ohss7Vh09tty4y
 n3GAHAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The candleLight firmware was updated to include support for Transceiver
Delay Compensation (TDC) configuration and CAN bus off recovery. This
series adds supports for this.

Link: https://github.com/candle-usb/candleLight_fw/pull/317
Link: https://github.com/candle-usb/candleLight_fw/pull/318
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (13):
      can: gs_usb: remove unused define GS_CAN_MODE_NORMAL
      can: gs_usb: replace all GS_CAN_MODE_* by GS_CAN_FEATURE_*
      can: gs_usb: update USB protocol definitions contributed by Elmue firmware
      can: gs_usb: document GS_CAN_FEATURE_FILTER
      can: gs_usb: gs_make_candev(): reduce scope of variable bt_const_extended
      can: gs_usb: gs_make_candev(): sort evaluation of device features
      can: gs_usb: gs_usb_receive_bulk_callback(): reduce scope of several variables
      can: gs_usb: gs_update_state(): convert CAN state handling to can_change_state()
      can: gs_usb: gs_usb_state_get_by_hf(): optionally print recived CAN error frames
      can: gs_usb: gs_update_state(): set CAN_ERR_CNT if device sends CAN error counters
      can: gs_usb: implement CAN_CTRLMODE_BERR_REPORTING for devices without native support
      can: gs_usb: implement Transceiver Delay Compensation
      can: gs_usb: implement CAN bus off recovery

 drivers/net/can/usb/gs_usb.c | 441 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 365 insertions(+), 76 deletions(-)
---
base-commit: 298bb2b8903323f6ef2eab4819a2e477765f0ff1
change-id: 20260718-gs_usb-new-features-aec1d3b77914

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

