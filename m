Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF5386571
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675314; cv=none; b=mafpPdKBHUR0ertyeh+frsMwfhQWtq2EUtRoQDocAT5PzoFYlMM7bmv1zEKCB85l97bQADPsgK3Sghq2rsUbWcE8KfqoAK/plRYe6gn8TvacWpEZ58uox0mktkaMQ1F1N6DMIuz9wuML6myiXAbdkiLjVkHSdBKuiepAqSUe3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675314; c=relaxed/simple;
	bh=MkIc2gOUUxVnGctDz10CrNCpKr6Mb6IDhCWPxN1gGVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuPX1sG5PwAZghUt2N4rfARWA7Ag02SmHGEz4GCTpI+plv49a7LFFCvTV+kpaskIkUKKO7sXPGuR0kbtcXEG1oYHk9C0Ow9wFigY5XZUVZZ9yu11Ure4Wdm4Nrhc+DIKOpEOQFwU+/ybSV2hnDFb+TAxDB6AqlNI5D11SbEFOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68T9mMkX003476;
	Tue, 29 Sep 2026 18:48:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68T9mMu4003473
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 18:48:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2a418d5f-5d1c-4472-81cf-8eb029e0eca7@I-love.SAKURA.ne.jp>
Date: Tue, 29 Sep 2026 18:48:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu leak
 when re-bind failed
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
        syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
 <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
 <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>
 <20260929-ordinary-auk-of-sunshine-8e1cff-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260929-ordinary-auk-of-sunshine-8e1cff-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav315.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/29 18:39, Marc Kleine-Budde wrote:
> On 29.09.2026 18:07:43, Tetsuo Handa wrote:
>> On 2026/09/29 17:56, Marc Kleine-Budde wrote:
>>> I've dropped the patch for now, the netdev bots gave the following
>>> review:
>>>
>>> regards,
>>> Marc
>> Yes, please. I'm trying to make an updated patch.
>>
>> https://sashiko.dev/#/patchset/f982152f-ff51-4d31-a17c-bd0d562c1414%40I-love.SAKURA.ne.jp
> 
> Please use 'v2' as the follow up patch, not 'v1.1'.
> Please include the linux-can mailing list and the j1939 maintainers.
> Please consider using 'b4' to send patches, not Thunderbird.

I need several trial and errors.
I will include linux-can ML and maintainers after passing sashiko's review.

