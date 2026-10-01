Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9F49362B;
	Thu,  1 Oct 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855719; cv=none; b=gaSpVx0HbRI4r8KhCm57fPKimHsWBceDZEFvjBk/gRm8m9gWXns8FI2MfTU80yeXiGVD3iNyr4KB0/4GqsBfo/CiIe1Y3jEyaFxeZpjpR2qBiP/h1S2tvdS3ZJEd8QfDJ5GbVnHKufdgRsDqAICtSu4EqR5TwkRyEXijWLpgTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855719; c=relaxed/simple;
	bh=ox8t4ZMuJtGG150w8QZBr2PP/bonrMtkF/tQx0R6jEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyKU90WLB4UCNy5/JrbxTEExN7L31vooKOGWjDLQcc6S+SGK8YxvWf5tgoCaoudgPxF/o2ytctYU9bM0mFJBBJrLzy632v7NMXM8WapkwLl6Q15fxlZgwmXNM+XjTtd7eQrz8mCsc8tgDQTnHyp4t8tAakEZER1OLGEvSnr+Q/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=bfx5SkXo; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="bfx5SkXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790855693; x=1791460493;
	i=alexander.hoelzl@gmx.net;
	bh=qeA7Y02fudyj1rRk/BJrmbaN/BQpMP1R9GGsHVKjBUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bfx5SkXogiU/2NlGqz2i5tEsuKE/sRGPD9KFxYJyg7qJVZlHNapMxNrN5xs9k9hW
	 HwoOTwQxpAzTNxl0z6grZ8ZbBhisHfgYP6WPMpObbt6UdGqH9ttgqQT9x1w+xEKSt
	 oNoGeYS/AXWkqJtYS2al8kQPDbeeLGihygX9wxQpcPkFiQ8iGoA1xiw2T5BXUfWoA
	 20L+5c5+pUF3+FLwbuU/iw8n4KYqza534hV2/xYYlaHKTiZorniP2HoB66V5wfh2g
	 lHp4qhW2ua0BB8YWnNL+PnzIksHMMHA1KG2m2/xAc2tK5evEWahramT9qGmbk4bLo
	 x2pDXEyT7Yp/hj5fAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1waykH1jei-00ZQCy; Thu, 01
 Oct 2026 13:54:53 +0200
Message-ID: <fc961382-aa90-4d82-b574-131437abb6f6@gmx.net>
Date: Thu, 1 Oct 2026 13:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Markus Koeniger <markus.koeniger87@gmail.com>, robin@protonic.nl,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
 <ar45DX0aPoWBvA_-@LEGNB0874>
 <20261001-bison-of-undeniable-art-5bcb84-mkl@pengutronix.de>
 <9da1ca76-4c89-4109-ba78-c08cfe69ea19@gmx.net>
 <ar5F3nxH6pvuE_Up@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
In-Reply-To: <ar5F3nxH6pvuE_Up@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vezb9FmUeLGeBT+85rYVFr45SwevobX6KK3JSWn+7J0X4oe2lRs
 gXSTkGI4i6B3ghBMJefBb4Gd7bUJGtWz7OKuTRKZEoq66G+zu12AjK0x/WioiXbgnPQhLMF
 6jgQdsnwxA0VrRMqvEzk8n87wQL3Q9bB9QHUWjjG81bekptg8BK4EwoGUy5/5+h7uZGxrfv
 Ji2UhkyX/HyWZtB4uv+HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2XZvFp5n9jg=;6whI5/EBDtkKEQCcFa2PUAoE1C2
 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
 DCo4IebQF0Wm/1VwS2AGHrnq9Q==



Am 01.10.2026 um 13:37 schrieb Oleksij Rempel:
> Hi,
>=20
> On Thu, Oct 01, 2026 at 01:18:27PM +0200, H=C3=B6lzl, Alexander wrote:
>> Hello,
>> Am 01.10.2026 um 12:57 schrieb Marc Kleine-Budde:
>>> On 01.10.2026 12:42:21, Markus Koeniger wrote:
>>>> I really appreciate your solution to schedule the TX timer for a BAM
>>>> transfer after receiving the looped-back frame.
>>>
>> Glad that I could help.
>>
>>>> We use external CAN controllers in our system, which introduce some
>>>> jitter into the transmit path. As a result, messages were sent from
>>>> time to time too quickly and violated the 50 ms minimum interval. You=
r
>>>> patch solves this problem.
>>>>
>>>> Tested-by: Markus Koeniger markus.koeniger@liebherr.com
>>>
>>> Thanks for testing, however I'm not sure if we can get this patch
>>> upstream if sashiko complains about it.
>>>
>> I wasn't planning on letting this patch stall. Next week I'll try to ad=
dress
>> sashiko comment's as well as the other patch I still have open.
>=20
> Nice, thx.
>=20
> I'm working right now on  j1939 selftests for core functionality. Hope
> it will be ready this week. If not, next week i'll be in Prag on E-OSS
> conference...
>=20
Ah that's good to know. In the CTS hold patch  I've also implemented=20
some tests (https://lkml.org/lkml/2026/7/7/85) but I guess they'll=20
mostly be superfluous then?>> Additionally while I'm at it I just wanted=
=20
to ask, is it intended behavior
>> that the kernel implementation strictly serializes all J1939 sessions. =
E.g
>> when sending a segmented message directed to destination address A it i=
s not
>> possible to have a second session open targeting destination address B.
>> According to the standard this is allowed and not
>> being able to do so can result in very low performance in some use-case=
s.
>> This especially true if one of the sessions is a BAM session transmitti=
ng a
>> longer message, as there are 50ms pauses between each frame.
>=20
> Is it not working with a separate socket? If I remember it correctly,
> this behavior should be supported if two sockets send to separate
> addresses. Withing one socket, frames should be serialized.
>=20
I've never tried it with multiple sockets but if you say so I'm sure=20
it'll work :). For my use case specifically this quite inconvenient=20
behavior but I guess I might be abusing the stack a little bit :).
I've written a patch which allows interleaved tx-sessions per socket but=
=20
if the kernel behaves as designed then that's probably not something=20
which I should try to get into the mainline.
