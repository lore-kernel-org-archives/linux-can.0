Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17937B021
	for <linux-can@vger.kernel.org>; Thu,  1 Oct 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859622; cv=pass; b=fupWIveQBVH2ZvX6e77atAL2s/uu+g2w6oWVN4RG10oJ1+koBTHtZQmKsjnO+WMWrBAZa4myXjknoeUuoU5I7Y1rorpAXwT6rxnlRNzNS72Zz78T7/M4pDCk9ym9X4zgwCj8ISL05LAFhmuuVDdc+RoJ9munC+Y1uB57BT0oqO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859622; c=relaxed/simple;
	bh=LkJ5E+PoyBrA2/ELoJy2+24tphpXKHGPr6+YnmijLK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJxj2krHQpBrYOoNnh6oFXpAk0zukWxGMyMXAfGeCyVw6vPgfT259eR7rP0fYGuK1u9JT/xMgMzRNS5lWQM8IGXoMjXfoxAZQL0yCJiK0Ekwe5/LaX6IPu3W/JPTxZdbpPUumbL5yBeTNNskjT2HvkDTMU3vLW3pfYCb0qYuFaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aOyBKQZE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tIbBTB3g; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aOyBKQZE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tIbBTB3g"
ARC-Seal: i=1; a=rsa-sha256; t=1790859432; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WmeWgLz2URm67T1jHbMAZ4NH/OPrsZb3kTKDDcgGNVO3A+Pq++het2710PPEY75HuB
    xZearYuH4M2n9obmfJTrFLkQal8biQEiQYMOers4HKxL3a9bF9TGSZX7Jn6xkcJQa+EM
    s6xnmYLMEZSsVSUUlNGbI3Poq9eH42XdqeNITcUlwp2GghIoCxfG7P4KQYQs6gf1Cqmb
    ZBwz2H27fr+mkPgoDlxd44f//WPO5vmb0U+2fUCq33jNeuxCqj3aguFOSqVuHwY9gJj3
    hkgMyCNdLMyJYeUKbzCNpU0sWky5s6a2u0oMSIJJs83oVy8Kyth7t3sL+UkP1jxbTRQB
    O+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790859432;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4VqZW761pXZn28ScyXvnq20NDm+daSdssyh1hCN18Cw=;
    b=Wf86XwEWvRjNt8+bY9ee5WAEuh7aQkE9VZsrMFgTbYMyfBuUbg8PJjFY6iKil/zg1d
    g3MpH0vYJINZf5Qc3PkMn8ELmku68Wk8qbROETDBMDjeWx7ZW7uYCfSEHbMD+rNUJvYi
    oTOgbBB1gtMd6lcMNvwdrx9J/Dtn0cFEznIy7vZn8hn0qnzORWRKEBVU4sqVMnMZguVM
    +pda/lksVPNHShaDZtqnzvK7jeP2EYwzJ4iotmFdPsUyS4NhhIz/b24vg4oWZ5GVJFia
    6Tj1d/6RPRvNQePeOeU91wZ+ZLzFghbpuKOmvns2EvoBT8rWOkwQ+XcmKhuc4a7VPqsD
    i51g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790859432;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4VqZW761pXZn28ScyXvnq20NDm+daSdssyh1hCN18Cw=;
    b=aOyBKQZEmaBBob0nMAMVwoHYw2lMOep5wRORcpD3nZEbEkblWNoo5M6b3ejQO15LnQ
    BA7yNYUtu1OhTg85DefnHZzPp4BsLZV1UAMi/+0BTP6EW62rQjY4t0oPpADtLUc/BDSW
    qDy4wt7bS2DTyF3G4cmiOkNZOShFnBPUiyy7p/qKYUozqh2/6O8JonvlIvU4+UOoRR7w
    we6cdMjFseXBG+wwcqHPJDSKq3jNcIWU+qqS9QwatD7BISRn+/3p+nVKjKtogcUPtfi+
    4J7HV1NlGwCtvHpf7J8hZdUB0i7rApey9/zB+uR9vl7Kyl1zu+9j0Hen4rlqOrNcQHfK
    werw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790859432;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4VqZW761pXZn28ScyXvnq20NDm+daSdssyh1hCN18Cw=;
    b=tIbBTB3gOmEQNF7kS9J/BgCvd09KjnnMEfy6QyWQYwqLmaO1GSA9UBRuVtumYWvRgk
    IBWT6lfZ7y/hoeItr2Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a291CvBjgA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Oct 2026 14:57:11 +0200 (CEST)
Message-ID: <4a531fd1-8984-40cb-9b84-b398f0647831@hartkopp.net>
Date: Thu, 1 Oct 2026 14:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix suspend
 deinit() error path
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-13-mkl@pengutronix.de>
 <20260929193336.D5E721F00893@smtp.kernel.org>
 <20260929-utopian-adventurous-jaybird-e6678f-mkl@pengutronix.de>
 <DLTIEP75FV1D.1V01M5U0KJVL8@baylibre.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <DLTIEP75FV1D.1V01M5U0KJVL8@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01.10.26 14:44, Markus Schneider-Pargmann wrote:
> On Tue Sep 29, 2026 at 10:34 PM CEST, Marc Kleine-Budde wrote:
>> On 29.09.2026 19:33:36, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>> - [High] can: m_can: data race on active_interrupts between suspend error path and ISR
> 
> This is a good point. I think I will leave the active_interrupts as they
> are and instead re-enable the hrtimer. That was one of the two solutions
> I was thinking about. This should also fix the last point sashiko made.
> 
>>> - [Medium] can: tcan4x5x: unbalanced enable_irq_wake() when m_can_class_suspend() fails
> 
> True, should be a follow-up fix. This is already what happens now
> without the patch. The patch doesn't change this behavior but also
> doesn't fix it.
> 
>>> - [Medium] can: m_can: polling hrtimer is permanently disabled on suspend failure
>>> --
>>>
>>> commit c427425150087d727cfdd3220f1be90e0a87c37e
>>> Author: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>>
>> Markus can you comment on these? I'll drop this patch for the net PR for
>> now.
> 
> Thanks I didn't get these.
> 
> Also I am wondering why sashiko didn't flag any of this on my patch
> submission...
> 
>    https://sashiko.dev/#/patchset/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e%40baylibre.com
> 

There are good and even better LLMs :-)

On 01.10.26 12:55, Marc Kleine-Budde wrote:
 > On 01.10.2026 12:28:48, Oliver Hartkopp wrote:
 >> Ok. The review on Linux-CAN ML was done with
 >>
 >> gemini/gemini-3.1-pro-preview
 >>
 >> https://sashiko.dev/#/patchset/20260929163424.16382-1-
 >> socketcan%40hartkopp.net
 >>
 >> While the PR netdev review was done by
 >>
 >> bedrock/us.anthropic.claude-opus-5-5
 >>
 >> https://netdev-ai.bots.linux.dev/sashiko/#/
 >> patchset/20260929210700.1183036-1-mkl%40pengutronix.de
 >>
 >> @Marc: Can we switch on Linux-CAN Patchwork to Claude Opus too?
 > Don't know Oleksij has done the sashiko.dev integraton.
 >
 > Marc
