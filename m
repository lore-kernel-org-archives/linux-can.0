Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802B3E49C7;
	Wed, 30 Sep 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762536; cv=pass; b=ApWyGnm/qAJCZMrDGn3RwsyLAlLGR28PItFiv/6DZoZNOekZxzAHLqzZcIPuQbsgxnAQWaVH/zEwGmig20ibpLoQCDwOCxcq0CIoHLoHDXoT3pZMiTecGKoAEaEyu5bkscKwalCfAHaQa9AmuJ1nzRhKjvIUir9zsESd/zbScGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762536; c=relaxed/simple;
	bh=qDuIsvcfjXL/ppJaOyaRy08u7dIA37WyysBpw6JixQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxb0YWcBpuV/u/OJeEAwqOQ9z9cmhBtD56luvIYu7tZFjPkQe2m+bUHmgAdMn94WaqmBjvzBKRdT4gtNfX0Sa9bbLQ0RbCZkWpNuNt24VGU5fOTrMQtfqKie42xDGQx+x/oBQiNJB4hs2WJK2JTnQMb3/Hx/GNn9LpIviAMr9PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=H2VOYf4m; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xlDKrGfy; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="H2VOYf4m";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xlDKrGfy"
ARC-Seal: i=1; a=rsa-sha256; t=1790762348; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gqY6meJEnrSBBPiwxT3RoIZVfA4DqUxrUwgop+8eOnxPqDXH6rUnYm63O9NrGbC6Pk
    KPgNY4yBWUGfsI2+1Q+MNMxGQbEaFEHmg/VXHD4eLn78vtBXJH7sCRGcu3gcYvU0woBk
    ACFxZec6OeJEfDrb+B84LB4lqHILf1d/2nHvk2h1JPK87tGWYsS2bI/oD54oZSb1djQK
    hrEL6YPpwhofHrAWvPQaS7Wr5HFP05vck0xNnQ7M1BVwd3BELUPo8lQzw/3kebQJGjJs
    NGw/xVG9il/Fq1nxYvbKPvuY103zRJv4uttjhqjMGk3B8YGpyTBHmrgE4dl6v7u0Ytuq
    AEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790762348;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5cFU2nUSuRqGiQ8h3Z9dgpOAsAYy/l12qVYH/0VgQ6Y=;
    b=NxOj3iP/Z/0HWHf4v5AT2Zh95/FGc/Aj4o1A8OiPeUpx+VI9RCL/Oc9u8kaZ8yKsZY
    NV6u+FNAj2VVInDJtpNozhvi2wxJgnGjjG1lqsIS4WNwqvS0SVIpbu25QFQSH9dwsvZl
    eBQFWvv19FuuYiCmKCAALBj7IP9DgeJKBzqJCobGXJbeOjg5IzLBYZaSEHe88bDI45PX
    GohqdxBqSsUdnB7o9TTaCq6KtLpRGfnjYNkXAxImebSF6K/gbEOrLqMQNiYHOIW18Sai
    SyMEmHOF+9eXC72jYjjSfSzzZfw5RhGGy8Bxy+cgOcMuHIu8mc+RZTEuN53GLHKLtzVC
    enKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790762348;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5cFU2nUSuRqGiQ8h3Z9dgpOAsAYy/l12qVYH/0VgQ6Y=;
    b=H2VOYf4mwl/hPXIotw4miqzIQ/KUFI53phbKrJrd0W4ay/cIctGo6ISf4WZpfAiosJ
    7x33hflVi85paBderllV+Jcj6Ayay2nJuA+zWh2iOs32GI3LIhuEBl11ksqOTaFIuRj4
    OZc82N6yK2Dqc70OOHflMzqnA2/i30NXEADe5SgQvE9zsnlUrlSrOBowkyP/EDUypCwP
    pg+dPOzKMdxM2Ircvorrl8XMykIkiVn5jhMAL8cwP23cEToOYXH9mGeb2ehf+zCwNT5R
    cQFkMZEZ8JmQQFgAfM99lL661r489XRd2gn05buclDtfGxgQPAlc5KswIpJSNWPJRqJh
    vC6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790762348;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5cFU2nUSuRqGiQ8h3Z9dgpOAsAYy/l12qVYH/0VgQ6Y=;
    b=xlDKrGfyoBxk/L3iXUQeC1Gxk1sfHSJ54PO0KLp8JJ/3dflZjGTuUAQuebRkCGlEs6
    PZYvxULlidpWECctd3Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28U9x8Y8s
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 30 Sep 2026 11:59:08 +0200 (CEST)
Message-ID: <f265f6ce-5a3d-499f-aece-09aa16970487@hartkopp.net>
Date: Wed, 30 Sep 2026 11:59:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: can-next - Re: [PATCH v3] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?St=C3=A9phane_Grosjean?=
 <s.grosjean@peak-system.fr>, =?UTF-8?Q?St=C3=A9phane_Grosjean?=
 <stephane.grosjean@free.fr>
References: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>
 <20260930-wondrous-unbeatable-guan-f7b2e1-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260930-wondrous-unbeatable-guan-f7b2e1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

On 30.09.26 11:10, Marc Kleine-Budde wrote:
> On 30.09.2026 10:44:33, Stéphane Grosjean wrote:
>> From: Stéphane Grosjean <s.grosjean@peak-system.fr>
>>
>> CAN bus error reporting is currently missing for all PEAK-System
>> USB-to-CAN FD devices. Add support for reporting bus errors by enabling
>> bus error notifications in the firmware for each CAN channel. Parsing of
>> the entire URB is aborted if the firmware reports an invalid channel.
>>
>> Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
> 
> Good work. Applied to linux-can-next.

There's nothing to see from your patches - neither in

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/

nor in

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/

where you sent the PRs to the netdev team yesterday.

Btw do you have those can-next patches still on your radar?

[can-next v2] can: proc: remove pointers from CAN specific proc output
https://lore.kernel.org/linux-can/20260815103400.117175-1-socketcan@hartkopp.net/

[can-next] can: remove Softing CANcard driver
https://lore.kernel.org/linux-can/20260815103428.117201-1-socketcan@hartkopp.net/

[PATCH can-next] can: raw: remove redundant NULL check before netdev_hold()
https://lore.kernel.org/linux-can/20260831052031.902699-1-ekffu200098@gmail.com/

Best regards,
Oliver

