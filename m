Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AC41C2FB
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683096; cv=none; b=YB0iyvybtLh8CFAH8+Y14aADS9wcjfeDkFcdoG5U1FGxba7+fvEpzmehShf0bqeJ2WixJZWKwA5yJlHovJudIeZ5h6ouY1vJTrBIAh6DhrbARaLx7ebqx51rOAkm+uj6W1dZevY52TzVuaMzcq6fC9tHZOd4/5clEhu0sr9Wbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683096; c=relaxed/simple;
	bh=VVXjTxY9WFpOeSEzngZ1FeJfF/9Bz9NDUcP2pB6hFYo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IKAQBXP1Ja4f4ZCDvarsmnrDzmpv3nsIvafCJAaeFsW52XLYVkzdM3oXmoWpmReAXV8aCirMm5V61nWReYGPFUEu62LpWU/5ZqkNM+T00YiHCvSN2KcyCxvyLDmO8AkPW0mGVwGu+TwRiFUlTy15Eu9Ayklx4UgJDUX45E487B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB2HxtEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB2HxtEC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D2EFC2BCC9;
	Fri, 10 Jul 2026 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783683096;
	bh=VVXjTxY9WFpOeSEzngZ1FeJfF/9Bz9NDUcP2pB6hFYo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WB2HxtEC9UMEUohVNfLTpry5A3Q0DOf0pvF/+xZOEjt/ii/RxaccMKfY9EaHXIAJO
	 mJ+BLVsXVaH6zDK1upC6eqXgnGnTguMGnsANsDUopN6wF338AFMtuFHPFY3dF+90pM
	 TpcfKDTuxAC6MGP/+hyROJanLcKLEpg2RqM/xHErOcNe4uY63bcolimNzmaBATiyg9
	 IPRl91ewPkTMAp1Wav7POR25uQSlONYs6nhOYO7BDMZRYLwXz6OouUSR7Kbnz6zMAx
	 RiKbQaVC552o8J1lCbPHg/2M5Ogx3RE5iUTs7cvQlCWj5OyS3wlF3+wBMOSEcxUYqm
	 tXZXR/JiU+LTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099FFC43458;
	Fri, 10 Jul 2026 11:31:36 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v2 0/2] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 13:31:20 +0200
Message-Id: <20260710-isotp-fixes-v2-0-bc57e26594b2@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjYUGoC/22NwQ7CIBBEf6XZsxggWtST/2F6oGWxq0khLBJN0
 3+X1qvHl5k3MwNjImS4NDMkLMQUpgp618Aw2umOglxl0FK30igpiEOOwtMbWaB15nCSrjW9h2r
 EhFtQhVv3Y371DxzyOrE2RuIc0me7K2rt/V8uSkhhjlY5pZxx/nwdbcrPEON+wgzdsixf36KVk
 bsAAAA=
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783683095; l=973;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=VVXjTxY9WFpOeSEzngZ1FeJfF/9Bz9NDUcP2pB6hFYo=;
 b=IbhAriRn/pAYjiZljWZONmOO+7WAZnLXLOd25Qjzj/AVtu34noD1kfMSa+hIjq3FQwAnKqaKf
 oAbg2GZt5zCBnlzfrCyg45j8Zz+HjI0Aak5F+La6a0Jt39ZN+M3ivtr
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

It covers two fixes reported by Nico Yip and sashiko-bot.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- patch 2: shutdown state machine to fix sashiko-bot complains
  Link: https://lore.kernel.org/linux-can/20260710094807.A50DD1F000E9@smtp.kernel.org/
- Link to v1: https://patch.msgid.link/20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net

---
Oliver Hartkopp (2):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

 net/can/isotp.c | 103 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 29 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>


