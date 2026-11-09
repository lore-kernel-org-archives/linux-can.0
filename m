Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229792;
	b=jhRzAhVt8FMGpXlGCUtwNwt0bj6wUM6i1h8/PWsc5kap9r5/w+tcDPJEvJXezLt3eZKL
	 dYqlJi/56Dj8+QIaSS6GuwDmusbQZ8gPUUkLsvyo8npDPHmZxTVYwlPMZH3mmQ4oxduvK
	 RsAKrRoLcK+Ot9ybh7WZE0jgToEuTRtI4GWbKe0YubaraFUXAVzqMaifNJzkf3vDWx/eq
	 wIudNGzcl8VRtennBNucAEnZgvXT1JsJQbXav/oYK4mwI0QXzozRLdCu8tDDd/NMEpkOU
	 ri2nQwO+ZNsg01yJCnVIakhoGVpt3YCjaknh3901tlQekNQnWWp8u/+f9nXhBq+ZkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229792;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Bn3lxEepttPsS1NHwHC5n1yEFS4pUuU7NMnS31FOcMo=;
	b=X24ZbktAoVTz9p1V+5tId+b3k2PA4pD/BdL0Q0xSForO0NenZBRrI5ZLCR+1WWal6jHw
	 LdBeAJq3GliLBGxcP7g5edIOVlBLXoNkVRcwUqJ8x/x7TsLDKcCJZX/23yCQ05RpgdkZD
	 AsLd2wFWCbDPX/QQcFh2hOell/mR71cb+4Is2NrSo9feJw+Tp0adE8eYy/HYDtGAsw1JX
	 SxMKuwEdlKkO6055LuMZx5kPToyYa0s/AbbRn7mAhuiBEkjf6tjR73661i6GneRuX6FNM
	 xzlidVptIsZTiVvfMsgXGODS+u2toIKgESg+aMfQGy2niMy3btaySgRIl+jX1CPhVyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=fh8qUdft;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99974606A31C;
	Mon,  9 Nov 2026 13:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99974606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=fh8qUdft
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54050f33c;
	Mon, 9 Nov 2026 21:09:41 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: peak_pci: Fix potential use-after-free during removal
Date: Mon,  9 Nov 2026 21:09:39 +0800
Message-ID: <20261109-21df1234b2-can-peak-pci@mail.sdu.edu.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c06dc1d503a1kunmcf0f5ef5121473
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUtLVkxCH0oeTk8dTRlPT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=fh8qUdftvBT4LIg1naZQKs1FiFzvQfyu5vGS9XSed9XfGKejoqDeir1n6e7Ki4KWvbEdYhO5mszuEHWSlIRXuZNTCNv57QouErAJCstJzvNfHHG9I1uc8Q+i6eyAVSrcm5zLojYBnqp4nYC2pQ9qO8rmBnchlE/ndfRFe8morWg=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Bn3lxEepttPsS1NHwHC5n1yEFS4pUuU7NMnS31FOcMo=;
	h=date:mime-version:subject:message-id:from;

The first channel uses the ExpressCard context in its write_reg
callback. Removal frees this context before unregister_sja1000dev()
writes the controller reset register.

Unregister the channel while its ExpressCard context and I2C adapter are
still available.

This issue was found by our static analysis tool under development.

Fixes: 949fe9b35570 ("can: peak_pci: peak_pci_remove(): fix UAF")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/can/sja1000/peak_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 69c61ccf621d..618f8f6a5750 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -752,10 +752,10 @@ static void peak_pci_remove(struct pci_dev *pdev)
 		struct net_device *prev_dev = chan->prev_dev;
 
 		dev_info(&pdev->dev, "removing device %s\n", dev->name);
+		unregister_sja1000dev(dev);
 		/* do that only for first channel */
 		if (!prev_dev && chan->pciec_card)
 			peak_pciec_remove(chan->pciec_card);
-		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
 		dev = prev_dev;
 

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
