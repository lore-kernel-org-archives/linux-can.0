Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA56513568
	for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650866; cv=none; b=tJ2Wmyhf8Wti+5edVIbgbMx6O9rjePtxGTSpz+1uTEUjLQGEYDZmcrvCcWQ4vSsUTiBmA0aP0TO+7QT7sa3B4rcMg0wWDugJ4Fi16FEaw5vxWZAOgmC3GiB5cL9RL4XMHt8quzd2D/1qrs+6m0HthEZYj6XOCnvLOXTom8yl2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650866; c=relaxed/simple;
	bh=LQvhnfXKcS05OD2fvEWvlVvWJRab5SLoPcf72NTyzWs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kjLrgYWsHCnYmKVAqcG453bl3q5Bt1F1hPr3CMh2lsq/0+jF2mJKZRLroqRi6PK1ynBTGmxDDxQcq7OQkPeRXN6vyF0G7XiVbOxXf7YXRcrl+3wxTeH56OAN9e3bvMbQfMRQtMX5KCzMHg/0AhBoVmUteTsPcAAgTRCVBhBW1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68HDDxd0097812;
	Thu, 17 Sep 2026 22:13:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68HDDwlv097808
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 17 Sep 2026 22:13:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c51d839b-4656-4d67-8c48-2d1dccebfd3e@I-love.SAKURA.ne.jp>
Date: Thu, 17 Sep 2026 22:13:58 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 (repost)] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav112.rs.sakura.ne.jp
X-Virus-Status: clean

Ping?

On 2026/09/05 18:44, Tetsuo Handa wrote:
> syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
> netdev_hold() is called during ECU creation but the corresponding
> netdev_put() is never executed because the parent "struct j1939_ecu"
> object is leaked.
(...snipped...)
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Assisted-by: Gemini-Pro
> Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
