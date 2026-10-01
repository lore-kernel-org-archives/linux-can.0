Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAE4718CD;
	Thu,  1 Oct 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853513; cv=none; b=CMhhsSij3lya+QUjDlj986MerEOuM7sTdNskW3TFOXOxg+ll6xcHxVQknWaz1yMViEHySnNyT8kA8EQL+gmLC9PPBhJ7WMH1PmiziSSQI0IW40QA7hINmX2uco5o78avFTi7Lzg14w0l+Tr0br2zFfLkvX+22erULR1SXTBon/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853513; c=relaxed/simple;
	bh=Wg2Or1kgUX1bn6kQkXoJgDqV6dfJGhrM8CUkK4q3vIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NplvlWfc33P9tAkjuA0FDRoeVqauuz7MS6s8R5WiYoHw1II+qrPC+uAsijbFlQsb2Jpx2chY69A5hfYbwANsOG7djC2LR2N4Lw02DGgZ01xMnG10VoniCQ1Nb8gfwhdZkevog1lrcfPTBizepCLvnjUeNjtu4NjFuXMqsmjIZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=BVSO+KwU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="BVSO+KwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790853508; x=1791458308;
	i=alexander.hoelzl@gmx.net;
	bh=Wg2Or1kgUX1bn6kQkXoJgDqV6dfJGhrM8CUkK4q3vIs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BVSO+KwUGOobaHueyTIQcKFGSdQf7PmCVkAwo4CjPn+y7lSKoVx8Mj+fx+gPkbRk
	 AgW40VV7Vll5IcEgo1pRsKnpD4YaTwfUOBmvgYPOKzE0OJOkHlmk+w5MoB3584TcR
	 d4T0tpRBDAyGMI0tTbbAAkCSTMiL4L/GznSMGTbbpk9hG1GunwsL7kN9uhjkSRkW8
	 2rYE7lXr7WqrC2CjPPx2nXH7gf+G+nIieGHa36v+AKdeQcCxxmOS1JNfmStDI/oxe
	 XAjXJKGvMJEpZ4LS4DHgfcurC+yJFLkfAsyh5/dfATiWIsCdv1hpbqgZrpCVg3ZzO
	 IJmttkgu7qDPKuHluA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1wqsAc1Vt8-00u3gq; Thu, 01
 Oct 2026 13:18:28 +0200
Message-ID: <9da1ca76-4c89-4109-ba78-c08cfe69ea19@gmx.net>
Date: Thu, 1 Oct 2026 13:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Markus Koeniger <markus.koeniger87@gmail.com>
Cc: o.rempel@pengutronix.de, robin@protonic.nl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-can@vger.kernel.org
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
 <ar45DX0aPoWBvA_-@LEGNB0874>
 <20261001-bison-of-undeniable-art-5bcb84-mkl@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
In-Reply-To: <20261001-bison-of-undeniable-art-5bcb84-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ZBgSzh4bQtolW3nW3+d6V4vV9gQN8D93zz/h2Mz7fgP2HDL9YZ
 f9IsZf+jIXTl0b59tmMZtsfPDCFJQYxTjMJ8zpCAxbOrAjPCjTjmsd16rUSwWPv69WbcswD
 iH+oQHT6TjaytIyBPy6pQDgqu0my3KOrFIrrcdttvn2USYN6YQj4UAhuuONtTSqC9YzfpTd
 P9rMZ0/WdWw2IyOclrJcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:llAnXfgBiqo=;yjqQ13+Ic5HFaDDeyUj4faTp+tW
 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
 wvQASaXDr8i0EX9PcXwVS6LKMg==

Hello,
Am 01.10.2026 um 12:57 schrieb Marc Kleine-Budde:
> On 01.10.2026 12:42:21, Markus Koeniger wrote:
>> I really appreciate your solution to schedule the TX timer for a BAM
>> transfer after receiving the looped-back frame.
>
Glad that I could help.

>> We use external CAN controllers in our system, which introduce some
>> jitter into the transmit path. As a result, messages were sent from
>> time to time too quickly and violated the 50 ms minimum interval. Your
>> patch solves this problem.
>>
>> Tested-by: Markus Koeniger markus.koeniger@liebherr.com
>=20
> Thanks for testing, however I'm not sure if we can get this patch
> upstream if sashiko complains about it.
>
I wasn't planning on letting this patch stall. Next week I'll try to=20
address sashiko comment's as well as the other patch I still have open.

Additionally while I'm at it I just wanted to ask, is it intended=20
behavior that the kernel implementation strictly serializes all J1939=20
sessions. E.g when sending a segmented message directed to destination=20
address A it is not possible to have a second session open targeting=20
destination address B. According to the standard this is allowed and not
being able to do so can result in very low performance in some=20
use-cases. This especially true if one of the sessions is a BAM session=20
transmitting a longer message, as there are 50ms pauses between each frame=
.

> regards,
> Marc
>=20

regards,
Alexander

