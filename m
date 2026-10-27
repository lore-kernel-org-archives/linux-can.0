Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111753;
	b=KKc6Xrv409XjVwyYFcazhCMOfKiwaK6Ch+zuoNgvAwViK2+Zasc1SdQQGV9AF4Mt5nnX
	 DltjDVOjgpoekpVkh19sKdIn513Xa08oAvELuSMDYbDUFeMLGXiXVUr+QDvdrxXg+QaPY
	 pFDVeWT3zSkrz9A6hzYQJZhva60gUsBjTA3IO2Lw5xbWHEDV/NnJQfYJnjKSnbqs6z9OJ
	 UU7ERE9R632cI1OBuJxEf5as9nj2veE8iiS8Sy30isGhjqaPJBPZzzI3RJtacPYkShT+k
	 ETan/scP2oUntfZoI+Jrt8wPiSB8kb7qCIZKT5p4JdfjTeF/26vmbGoB/MiC1ajQulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111753;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=/+EZTN8/RL3FnKUS4CqJCvmXjDAScPkKMIBuJc2FtX4=;
	b=IlVzbVzPg0VH4JcLaQ8u1Qcz5sqWiJqY644GhPGSXEHCeeVdHT9rX/rSeq60jw1jrWPH
	 yrXF/u1Fx/SMOxN7pdXYRgKkyhcLFcZ4HVXabY3LYkqAT51vYqBnGXMo/eN15MR6Nlx6d
	 2WVVCJGAV3RiWWBrm8nnjV6j+635A6lAzr1GVZZ5OQ2vrN8OLbMihfO8/FOygJLio70GZ
	 RNMdazldYee01iMCPSjWfEs29FHQ4xHqR7JDMYcujuGhzezrMXCDA2kIQoZ6etEfthntW
	 Ge4rCWfr2fWp7z+mbyvnirPUnCz113u3T/6BejykKgkshuElee5O/W7bYDSkG3pB4RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA053606A32A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA053606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69REZUvj019762;
	Tue, 27 Oct 2026 23:35:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69REZUoe019759
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Oct 2026 23:35:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <732e1fa7-70a0-4abf-8862-3c8913238bf0@I-love.SAKURA.ne.jp>
Date: Tue, 27 Oct 2026 23:35:29 +0900
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
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7df4f6c6-b53f-42d6-9725-e60b763d01f6@I-love.SAKURA.ne.jp>
 <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>
 <20261027033104.76618-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20261027033104.76618-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav212.rs.sakura.ne.jp

On 2026/10/27 12:31, Karl Mehltretter wrote:
> This is based on source review with AI assistance. I have not reproduced
> the unregister hang at runtime.
> 
> Could teardown use a lookup that permits NETREG_UNREGISTERING and a dead
> rx_kref, while retaining the nonzero ecu->kref check? The registration
> and receive-lifetime restrictions are needed when acquiring new users,
> but cleanup must still find the ECU whose reference it owns.
> 
> The ecu->kref check remains necessary because zero-reference entries stay on
> the list until the RCU callback removes them.

Thank you. Sashiko has the same opinion
( https://sashiko.dev/#/patchset/3958917c-1484-41e8-8d62-99575edbf980%40I-love.SAKURA.ne.jp )
and I followed it in the v4 patch.

Sashiko thinks the v4 patch is OK
( https://sashiko.dev/#/patchset/4b2c8d95-d17e-4f36-a340-abf84693d24a%40I-love.SAKURA.ne.jp ).
It is time to check using multiple models via the review bot.
