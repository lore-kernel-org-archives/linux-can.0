Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780892;
	b=2sZYiV8XTnSgbXfaYiDsoCYFB++EJZ4wmpApewEpTGCsVkMNUYEXe6Mcv3j/dUQ2/2MB
	 30ecosNVUofcsAq5t9UsNeLmImXVH5N5pY31I8DOhbi0/61vraVJfEmMKEiSaNABjbPOd
	 JxZ6BpDK185wcrScfpTDMe7wBV19ylcE1LCNWcGklgAjrhB2MC2uTSe4ODRC+udOgxCoj
	 p98oeSHsUwjCDR8iaaL8P8HUSqmIi33xWtb1PSX8YZz9nWeR10fB6fylYNqePSM0e+Zv5
	 Re9VprrO7H805fztqjWU6vdmoYkw3NVrw3coJQXt5zsTmhctrduqESerJY+24d/JOVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780892;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=JynelqE7st3LG1E8iQ/bmHv6QRqGXbzYp/NsVThOAD4=;
	b=jaGAwTZJtzsrLOUQZ5AXCcjkV3w8qpt8oJ4VEF+i01syDp32i20B65tAZHc36TkWadc3
	 es2hevE3N4NYzziPY36FioRst7SsYsRyMWOCWso1Aee8zSHgYRU6mPxdxHn4OV28eyHC1
	 3b8eyiyq8z7l7OmQdrqVWNsbvwMAVUXmE5fGgLK8UFBwX0eYH7TS7Zw0oenUshermKxUz
	 56vTCaZj54Co4CPrPFYFnWmtOK+Pz9jX/O5lZ7FNXRSL60UK6Rfty4BymWaJWDSbPI/dP
	 hjpjyIXTW6P0+ERjMqUIFaFTsbdiA2XGWfL2QNCF+7wG6ER6lOWBUclMl2wog+vn8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D7606A321
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 12:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6ARC1Dot002055;
	Fri, 27 Nov 2026 21:01:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6ARC1Dpm002051
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 27 Nov 2026 21:01:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <54cf4887-18b8-4957-ad30-4f91232ee846@I-love.SAKURA.ne.jp>
Date: Fri, 27 Nov 2026 21:01:12 +0900
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
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
 <db630610-dba5-4f5b-bd61-09d333132e34@I-love.SAKURA.ne.jp>
 <awlAMlRxN4mly85w@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <awlAMlRxN4mly85w@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav415.rs.sakura.ne.jp

On 2026/11/27 17:32, Oleksij Rempel wrote:
> About the delay: my mailbox is full of Sashiko reviews and new versions
> of other patch sets, from many developers.

Yes, that's why I don't want to try sending to relevant MLs before
sashiko-bot@kernel.org gets pleased. I was using LKML with dot versioning.

I appreciate if there is a ML which sashiko-bot@kernel.org reviews
but automated tooling (e.g. build bot) do not run. ;-)
