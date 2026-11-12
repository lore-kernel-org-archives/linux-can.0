Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794479739;
	b=fx/l2T0+wuDLb4/Jj3/5rbsZ8uTO2b3O30t462YEGTDSXvN7ntXqm7/cV7KLRB811NTH
	 x8gxBNFTbeFF1EW8nLhrfsYOVQTzISghnCPwSu3cdi+vvNUXhqDy0nHatzLKzD3f7Yqw0
	 oChZ+FDMiO6nb77WFcbEJPgkyLwA4qcDEIBaEkeI5FutxmP6u/Z22xv7+FV07wdirI5so
	 5lTc/sMKPglIb+hf5dUTXT4F7O6+e0aVIKmDWIZXkE2t5skpD+ryBHIC7TRoOVwiik/Ax
	 lyIO0BZUn+tXgvCppnXtY/JceVGJPO58qY7D1AIww0jJYxnCH6C0I0ZLt16NRmeLeIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479739;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4b/d/p5+8S+zw10BLN9f4DH7QKGMtbL57MwIFawiGoI=;
	b=z+bEf1h2SjBjbdlp8h7pOZhFvjDF3zbbKbirdzGuDWrquRol/TqPSGqK//XYtvXezXAj
	 6c5lcEyjhIAWS1gCU+yxIAaTNYOF076y5B9Y2fwOobKTtsFp+6n9eCUJXXZhXK38uFlEZ
	 7HP8VjYJWd7rFYTdQu1snTMSgebsmbjATN9OwsndwvD1qx0/INLh2pvAcZWXdOMQtopXK
	 1jgJvn/LyIY+zyMbMKM0VxHVXwqM2EVM0cVDHBziGORwheegf5mVbrKfV6ghvd4MpxteN
	 bYLtARIY1i/R5zBHwWHjpDtReoSmC15Ip3XZHRymKpk+WzuXkMkzQ1UOM7fEiLAubGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4LirJRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9988606A32A;
	Thu, 12 Nov 2026 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4LirJRi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794479739;
	b=eFZBF1tGHMIKTMiUdnmRAfhUYxTih+hm/lJnSOoIT+0tJ05sCw223y01YM2Sdk61nwt8
	 2LKIuu7wHNCf05fPi2Tjx7lS4WM03IK5u2BLuA/po380ZLrIVFpZm5a1viEr3QaGoV1Il
	 fOJqZZ827xEQGCsx7e1UWa5AMMr1T7Qroswu6UDCHeHq69xGITjvKHZb4Vx4I843VNM1x
	 RfSGq0y8xIW+H1SH1rMN7B0dacmch73jhxzEZsmu2bQOH0/Ac1gSJs8twuiKNHGWWM0UH
	 N2gYCW3C+UpQxBr5vW/EygmjTIBdihiFJ8azOQQLb9122PnB3UM5e4slbjv12fpqdeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794479739;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4b/d/p5+8S+zw10BLN9f4DH7QKGMtbL57MwIFawiGoI=;
	b=YqaDEUQRwUOWzyWCxodF71ShCAARNGUYi1Ea47Ad/rwJvLw09dUS327U9yp7Ub3YfW73
	 55H+H/s+SO5FoQMLW7dOEMgW3aqZNL7xEjce0faOrbYdS5n65olGbKUKWHfj3DJm/aVok
	 r7QVgCRVLTlFwJ9wgweWPc5vr7bpCBW2Os0VD0tWqh43nU/pmv9ze27U3gkopLmSq0dy2
	 iboDXA9As/GtU2OtzLhX0/QfyOnEzguoN4C6N1x5VFh/t0wGvfOIvTNKWqF4F9AE3yP0Y
	 7ly/gT5msYe3wmEM2QMpGICg+toQusVwuJC2vKZN+Ugh7gGnPF+EAeIOKnGMF4C05tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF2B01F00A05;
	Thu, 12 Nov 2026 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479739;
	bh=4b/d/p5+8S+zw10BLN9f4DH7QKGMtbL57MwIFawiGoI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=I4LirJRi6DfgtOcEkRNmD6mAHIh1GwkLbMtkOTj8OVCXs33+0fFRi5FOHGxtdrSjr
	 QzDFmO1Yg5zn5ZFTyzE6pRvtfdy5+BxeaBjvGrr3h/aSHnwDyneIqu35YC1EVDpwQH
	 OSxPkdpLX/plZWxlm80GhTwpn094kE4VpE3blgwP+FErcD/ulxIo043Va2cmuc6b6c
	 Scf4fOyzLvvMxuMgoIcrL+yQPB4Jak0KUdXY3xU8kVMo2CNaMmr3feBlLdvxpkn6q+
	 f/XhFC1e5Em4+QmVQVIyTXE4E3Z3SYCO7kI2Wjty+AJDBSY+9eIrfExf7RHLMPVTFu
	 eijjpDTcDtDdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1FD1749470;
	Thu, 12 Nov 2026 10:35:38 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 12 Nov 2026 11:35:28 +0100
Subject: [PATCH v2] MAINTAINERS: add entry for PEAK-System CAN drivers
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
Message-Id: <20261112-new_maintainers-v2-1-794b73ce8685@peak-system.fr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBREf4XctTV9hIKu/A9DTIGLVEMhvRUlp
 P9uwbWLWZxk5swKhN4iwTlbweNsyY4ugTxk0PTG3ZHZNjFILrXgvGAO37fBWBdS0BNrZZFLpWr
 NTQ5pNXns7Gc3Xqsf06t+YBM2zdboLYXRL/vlLLbef/ssmGDqVKJGpYUsm8uE5slooYDDsfNQx
 Ri/etExQcUAAAA=
X-Change-ID: 20261007-new_maintainers-d275233b60a5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794479737; l=2400;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=OB+db2VoIi21gwz8pTexgzVANUMGkfO2rHGDfSfD5rA=;
 b=BFO1K/zjXKNNQZ6aHOr3bbIhTVShLtYDnzTeYuT2rVQ5psBcW94pwOXAjGVHHUA/1v+JIuw9S
 E90kTVgDzeHAOsIiTS/PijrUphG7FIkUJ2neTdD/ox3hbNVvTtr6VLX
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PEAK-System CAN drivers (peak_canfd, peak_pci, peak_pcmcia and
peak_usb) are only covered by the generic CAN NETWORK DRIVERS entry, so
get_maintainer.pl doesn't Cc their author on patches and bug reports
touching them.

Add a dedicated entry. I wrote these drivers and maintain them as part
of my work at PEAK-System, where I have the hardware and the firmware
documentation needed to review and test changes. Patches keep going
through the CAN tree, the entry only makes sure they reach me.

Also list the PEAK-System Linux support address as a reviewer, so that
reports keep reaching the company if my own address ever goes stale.

Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
v1 was only sent to LKML, because get_maintainer.pl returns nothing
else for a patch touching MAINTAINERS alone. Sorry for that; this
version is addressed to the CAN maintainers and list.
---
Changes in v2:
- Send to the CAN maintainers and linux-can (v1 only went to LKML).
- List socketcan@peak-system.fr as R: instead of M:, since it is a
  company role address kept for continuity.
- Add the peak_usb sysfs ABI documentation file.
- Reword the commit message to explain why the entry is needed.
- Link to v1: https://patch.msgid.link/20261007-new_maintainers-v1-1-398e6e36128c@peak-system.fr
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..567358d57d79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21780,6 +21780,18 @@ PDS DSC VIRTIO DATA PATH ACCELERATOR
 R:	Brett Creeley <brett.creeley@amd.com>
 F:	drivers/vdpa/pds/
 
+PEAK-SYSTEM CAN DRIVERS
+M:	Stéphane Grosjean <s.grosjean@peak-system.fr>
+R:	PEAK-System Linux support <socketcan@peak-system.fr>
+L:	linux-can@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-class-net-peak_usb
+F:	drivers/net/can/peak_canfd/
+F:	drivers/net/can/sja1000/peak_pci.c
+F:	drivers/net/can/sja1000/peak_pcmcia.c
+F:	drivers/net/can/usb/peak_usb/
+F:	include/linux/can/dev/peak_canfd.h
+
 PECI HARDWARE MONITORING DRIVERS
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-hwmon@vger.kernel.org

---
base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
change-id: 20261007-new_maintainers-d275233b60a5

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>


