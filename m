Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174553;
	b=q2SBl6kZfRao8OeC93telikbJoz1v4kdFpMvySPlBy3PCMacB4JCdGphd7QAnm0XhcTV
	 WD02pnW2rkMGcDzi0i6+7e91hjaBLukv+LjCpYgC030xQqG1Wpxh9kIVZ05st/siALdDa
	 ft7pIikKvfxW3zYyvG1Gmbl2qOkrWoI72KkA5jBsAZP/SCAuNVHsTrLse6LeWFOMqj8OS
	 jhh1yzDN4MMqgkPgxBJPK3AL4VX14TIa9m5SZwyiARUftB8bNVJ5+fZ6aQc+TqMfSbcFZ
	 itozq/1tL6itiSSyLa6607LmaTPJOTiRr7mPq3YBSrYp4/9g/qntMHpNcKgt2YVM6hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174553;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=WmCiY0VI9XMV8UBORFAFIFIrwELljU8eY33d46od4dI=;
	b=U4GKuW8BERFOjZ7dtsYLR6ya3Nx+CDLApvb+D8rC8MLrz1cK2aL3Gm2SuXzKY6K8exrg
	 J+e523wooZ1uWbUp0UYUSR3u4IhlZz8RnZcnUFayaun0/YvDz0M99ZKEDUPz3JSkm+/GW
	 K9OyTP9kPTZkbb2dkXsm2x+ESS+4f613wE+JRBBZgxFcYVrIeFoNpoZvH4pU2EUwnhQ25
	 vOp6HF1b14Nl+xfsawvKOAGrYYaPcrJksoff6M7O8QL4/b7+Vp/xvh+DpV3EFTZ4R/Rk5
	 +pj4g+1FfoTtmm/8XlGqfezmqK36L6HkF4VbEDJ1bTro5Ocyjz6Msz3THF4armH2Ufw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC1606A320
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AKBZMJs022155;
	Fri, 20 Nov 2026 20:35:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AKBZLXj022152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 20:35:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <db630610-dba5-4f5b-bd61-09d333132e34@I-love.SAKURA.ne.jp>
Date: Fri, 20 Nov 2026 20:35:22 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/3] can: j1939: make module more robust
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav214.rs.sakura.ne.jp

Hello, j1939 maintainers.

On 2026/11/18 0:56, Tetsuo Handa wrote:
> This series is intended to address the following problems.

Both sashiko-bot@kernel.org and netdev-bot+sashiko@kernel.org are almost
pleased with this v15 patchset.

  https://sashiko.dev/#/patchset/98c16a74-5ea7-476e-ab36-c98fb77b6be4%40I-love.SAKURA.ne.jp
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp

Although netdev-bot+sashiko suggested appending below diff to [PATCH v15 3/3],
it is not worth reposting as v16 without waiting for your response.

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 28f6fa6029ec..f33f40a4c23d 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -69,7 +69,7 @@ struct j1939_priv {
 	netdevice_tracker dev_tracker;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
-	 * also protected by the above lock
+	 * also protected by the "rwlock_t lock" above
 	 */
 	struct j1939_addr_ent {
 		struct j1939_ecu *ecu;

Regarding the deadlock problem in transport.c , I need some trial-and-error
for making a workable patch. Therefore, I want to avoid needlessly re-posting
the whole patchset.

Will you apply at least [PATCH v15 1/3] and [PATCH v15 2/3] now?
(If you don't mind lack of above diff, [PATCH v15 3/3] together please.)

Regards.

