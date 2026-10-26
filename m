Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017585;
	b=SakPFfcxkzs+X2c6WaCrM/tDUOjvKsNbrxCztIrTO/NxoweNsGlK1/8hzjodK9cTpn7k
	 t6MTsxjIBdHg8naM1hvRK4T7Dxe43852FcfK2kEDA2s7nwojcfv9PKaZTtVcjfScQ2tU3
	 kzZF8iWlQHsRSVqsQNuLSQc07yzbj4yAkZdXTDvEy0iqheKEvUYmqbkyB/cTR1/TanSlm
	 iRT1bzv8/F7wJlLuDwc4ZZF8Ac7xaXuhEyzCkfylT81hdFt2DCInzDaDCwS71YEZldgRV
	 k0l1p9130SZpUe8IaSba+8l90G69CmaREg/s6aZF1naDoZ1j3+lR61LXolHdqrQNcRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
	b=aGPRUwiUolV8CV9uTiPSvN4Gi2jlHqKlzDeNeZjHJbmgG7300WdJUXJxLcmoAQG0jo4e
	 t9FUxBCywXXyIgeHPovrDA2VoVk7neD0lGDsAC8eyh2EORsLREGIbtTkV0juYCtjUMtpJ
	 tn5rgsa0kaTNziGKYjFYeec8CmP9e9ZhmPIgeN4gQ/88bh7W3pHJMQrD5s7/CuXVzNkdm
	 x5GEXXMj11w3U9R7qE6l3QIeh24vkKmX2PZtKbVolzDzDAian+RrN5WhouOA/HTQcSdQP
	 Lbfncd+ME9UM/W7Tr33go3LnHBtbG+q2bDp3KV3EhSTnbM2SdjsK26NNQuQM5XNyNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7RUKdBm;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C7606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7RUKdBm
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2111579a91.1
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017585; x=1793622385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
        b=J7RUKdBmFWCFYf7Jm5iuhyIacJuMljP4DULL6+tfAbY8VnPD5NPIWoyJzDLqhCOK8F
         PniBYrHIfIa2L1Fl8LV7ahoG1/HQP3n8pi5GBdaqyYwFuOmJnh35QV/ZHqatgA+le6HO
         HNAulxRUnjbWO05GSaogpGkqryhZSuLSsqOYXzljsrH9vveEqXa5sSKco6lilfpvmoBw
         +F2ugaUMD9M21S6iqpDuSg4jHDaEpwwd31Elh7UOxn2KqC7k8/UAei9qMxhU52eVKsYg
         UhrZ8KtR/n3mMPgG+f74DQQi20v/K9j/xk3m5XfS0E6yz2xztPD1K6EWJldKHSIKfbsr
         kFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017585; x=1793622385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
        b=K9bFiQsWwpRfHqREwkcNH2m4ahtlpxHT1loF/NJkak4fSNE9SkRKPKrSwiB1CzQodG
         5okBHlW9paEi1Lz0UowZljyJIQoh3EBAbo6fg2X1p0Of6hAE+WbjVRxHxYGNI8dJkFD2
         CQoXDN+q4rdcyQqFBnrBXuZljkpITm4RmBlYTMw1nXpPwd+G+VVwD1mwAkVBn5UdFm/J
         xsWHhXcLCSHx/hlaXvb+4eee274nF+zFvhRvnOid9+tbImbrD7uXTMsegLeLH3O+VNg6
         L85EOXGWowbE/LneRq6VT4moL/pgRFzqsSb1dtRNHeIXbBasOm2QNhSqKai/A2qz16Ji
         EBFg==
X-Forwarded-Encrypted: i=1; AKwUvBzt4q9/qynREdbe7HdXA1KHruRVm2hsPXSFOFEVYwb8BJnAklamAcJROfdSxNB0m4K3Z8w3oOC+URA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6mUjH/74OxsTABKxJVOd9xcZoL9WXNEuMJQ8rt+isT/oSmvRw
	q5lBW5IFIFT8uhi2G8IVZzpqhyLvhA7dFuxBO3VYn+I4losp/pjKOiM/
X-Gm-Gg: AYBFou0wPKkNtD6zRWt/4S5ywPyG+3gUIzMhB7gFJuYkwZ9GwVerLdEBYavcoZaS/uo
	i3XH3fx4d9DdGotGnBEn4HT7oSxf18Ngqbkkr2TghDnqAiwiAWEDOVapV76kjQqv+rp3MJ2UDOR
	COwlXiR6XOoPz32py9iykPKq6a5pKpDwG/eTekcjiviexsVglBuSnAFeWT8/pPjQZkOcNoaBlXM
	ImWDvO1OpNH0mQqG3RbRBkOuBsY5ayf+rRgi1VX4LflAVQyDyzHvdlWDAvEDOhI/w7FQw1HxDqp
	7yggvV1C0Qswot8dnPvE/oPxTUh7F5YKZYttMMwthzz6SMsqJXYg6JNwwaSYD0p5g1QJ/SnRreH
	RbL1LjAFyxsgKkmWecPZf/V/IHYlvzk2a6qbp0l4WYvK5cFvu/8BqXEhX+xrpssovsucrfZTkGo
	LnTSpXmwcBhXC0eVS74upbhmwIJ3YMv7Hw+sOwNWJiAuhG1SB+y/IP1A28rs2Y7EfFZ4eNVyr3P
	jx/5lm2NyEFMegkmslh0C5ki/BOXaMtF3wJH3q6J1e1zHc4rc0SovpgKDsCCub+Ab/eIAlaYTs=
X-Received: by 2002:a17:90b:5105:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3adeafad11emr5076749a91.31.1793017584676;
        Mon, 26 Oct 2026 05:26:24 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8894148a91.2.2026.10.26.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:26:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
	support@ems-wuensche.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sebastian Haas <haas@ems-wuensche.com>,
	Markus Plessing <plessing@ems-wuensche.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: sja1000: ems_pci: fix UAF in channel cleanup
Date: Mon, 26 Oct 2026 20:26:15 +0800
Message-ID: <20261026122616.97845-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CAN channel is absent or register_sja1000dev() fails, the
driver frees the network device but leaves its pointer in the
card->net_dev array.

The cleanup path iterates over card->channels, which counts only
successfully registered channels, while the array is indexed by
physical channel number. This mismatch can cause the cleanup path
to access an already-freed network device and skip registered
devices at higher array indices.

Set the array entries to NULL after freeing their devices and
iterate over the entire array during cleanup. This prevents
use-after-free and ensures that all registered channels are
properly released.

This issue was found by our static analysis tool under development.

Fixes: a61a8423c71d ("can: SJA1000 driver for EMS PCI cards")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/can/sja1000/ems_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 986fc8786fac..ff680486a299 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -213,7 +213,7 @@ static void ems_pci_del_card(struct pci_dev *pdev)
 	struct net_device *dev;
 	int i = 0;
 
-	for (i = 0; i < card->channels; i++) {
+	for (i = 0; i < ARRAY_SIZE(card->net_dev); i++) {
 		dev = card->net_dev[i];
 
 		if (!dev)
@@ -399,6 +399,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 					"Registering device failed: %pe\n",
 					ERR_PTR(err));
 				free_sja1000dev(dev);
+				card->net_dev[i] = NULL;
 				goto failure_cleanup;
 			}
 
@@ -408,6 +409,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 				 i + 1, priv->reg_base, dev->irq);
 		} else {
 			free_sja1000dev(dev);
+			card->net_dev[i] = NULL;
 		}
 	}
 
-- 
2.43.0

