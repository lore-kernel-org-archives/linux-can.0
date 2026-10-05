Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847543CE77;
	Mon,  5 Oct 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192309; cv=pass; b=uibMJ6HWBAU1iRZxZrVtgKlbJ2KZUPFi34Qx+PJGnXw1whtVqIkK72r06zxZ7yCUfILJThvjXaOp8qxV/E7PkTqlEul1gCy8f+NV3CHLaYymjJvMyXZp2SCfbtNA4eY2lRztXyapgIGmgEZC/xTms2nBnmUZEcG+4X1RrPBOX+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192309; c=relaxed/simple;
	bh=cjJaevx08HM7e0lBCr1ZkY01r4wS15SOoE3pQ/01xmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4v+8MdN+7X93r7VCnv1q4CpaEuIrqSuwjLXUyIybnI77JoZAQnVrxHYdSQFKFPKoZVP0PlOp0c2jNM6SdUxXMUPYt0qYBcJVe0qAteLc+5G0FobUULRrZS3KfxZdkOjXJtMCjLt02y23MGKoR0hHvFLTvwatpPaXTcqDZZgX64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rsfZpHCY; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Tm51oeCs; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rsfZpHCY";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Tm51oeCs"
ARC-Seal: i=1; a=rsa-sha256; t=1791192294; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oeGBOmrViLCyqwjHolPerUw9dMMJHCJiWjWUGWzuNxv6SKM9iIbMkNBfugnHohLR+Z
    G2CPpfYM4Q+7qMiFtM68ftfmC1IbRlM1xAta79pA7Xa0FeQ4S8OtrRBEogAmutDvaH2L
    plecld3mWC6x9W8EhefSQpdw8jAuTCc4daoO7JNn/r/igRxGtxTqEUizoVDV/66C42q8
    ifsC2pXZ2VRyTzG5laKQcQaVyQy8qZl73S91eIjtC4mgrjETtpnWK0EvSkQ7cnhQh+XN
    l+9Ko8YuAidDnTGFDsBeth4vbmTOrNrFCd3bje9ODJsViLi3K9U6RkgBJKkgcER856rf
    tNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791192294;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cbWeiGHgVcITfgUbxAKF0jNuMEptPr41k54VU4DRHTQ=;
    b=IcWNHCeFbSHr2bE63sQtXFomyOSI2lZSRImY2tjt28eOgepTD2UM4a2DCDgKvGT6OA
    8yVE5YPgeb68lF2bXLeIQZ9WpLyGmz0GH3NtWF05HY0KQSaquXR5H2fqfB0tYuoryZwT
    eAXFajLRcHguE75dpRlGG81TE6oKdIM+Sh0yP548pDvxGYQYH7Ov44YDPaZxyUJI0Ae5
    6tfBavRi7I4/xu8t8foA3P7LIu1qpYMX3yNEIT871hrj8ylx/rX+r3ioTgYB+Ki38Br9
    mzz9asvm62ouvEsZd99Wh/4N9HHnqnbEu7hvI4tcCBA6tLAwomMj25l/DEkovBWiX/l/
    zVZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791192294;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cbWeiGHgVcITfgUbxAKF0jNuMEptPr41k54VU4DRHTQ=;
    b=rsfZpHCYLG0FFQine5VqoMLJp0ESsAPSOWbPHq6QO4khaA79cSfRhlRcZ1f6rcRGUN
    AOW3Sb9WpSYh1CQ+eSFZlb3bzXMw7Aec2eXxs6OgWVGo8pMaqPNJdZ08UlSBD1vCAq6t
    NoN6soZQllrBhSWtdbut0c925kaWddVM7zZ1rAJEDBv0UgLEoGyv6//sXOcM1yFrBQFr
    WhW2PhTy6uIFR/EwpQ+c+4C51NXDQii7hxOEThItCirYQ7z1JtNE5mJlTIsTAKU/gL7G
    3Ga7fVeJna/VNwrsx11UG/plAlglTMABDPbtPVsXO/1yVSxVyYe/oiba2YmSrnvU4vZa
    o2pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791192294;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cbWeiGHgVcITfgUbxAKF0jNuMEptPr41k54VU4DRHTQ=;
    b=Tm51oeCsUEbr88Ock7GZk/4OKHBjjM5kBS54ANyDR8g38in8BrSNkkJJWKrxSoqArF
    bWAlT/ZipjA66UA0MsAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K04b9a2959Os0qr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 5 Oct 2026 11:24:54 +0200 (CEST)
Message-ID: <fe6d19b7-31f1-4559-b313-da4e2bb6ff98@hartkopp.net>
Date: Mon, 5 Oct 2026 11:24:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, ore@pengutronix.de,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
 <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
 <20261001082552.514c54fd@kernel.org>
 <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
 <20261001111954.2ebaf14c@kernel.org>
 <57de2511-fb5a-4689-bc21-2a9fe25761fc@hartkopp.net>
 <20261005-prophetic-civet-of-faith-08ea65-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261005-prophetic-civet-of-faith-08ea65-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05.10.26 11:20, Marc Kleine-Budde wrote:
> On 05.10.2026 09:28:13, Oliver Hartkopp wrote:
>> Hello Jakub,
>>
>> On 01.10.26 20:19, Jakub Kicinski wrote:
>>> On Thu, 1 Oct 2026 17:38:17 +0200 Marc Kleine-Budde wrote:
>>>> On 01.10.2026 08:25:52, Jakub Kicinski wrote:
>>>>>> Don't know Oleksij has done the sashiko.dev integraton.
>>>>>
>>>>> Let me try to plug you into netdev-ai one for now.
>>>>
>>>> Thanks, do you need anything from us?
>>>
>>> I don't think so, we already had the setup for the old AIR system.
>>> The emails should start flowing in a day or two. Please let me know
>>> if you don't see any review out by Monday!
>>>
>>
>> The new netdev-ai picked some older can-ML patches for an additional review
>> but not the important latest "[PATCH net 0/3] pull-request: can 2026-10-01"
>> which is still only reviewed by gemini-3.1-pro-preview :
>>
>> https://sashiko.dev/#/patchset/20261001151905.1556270-1-mkl%40pengutronix.de
>>
>> Should Marc resend the PR or can you trigger its review manually?
> 
> 👀
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001151905.1556270-1-mkl@pengutronix.de

Ah, thanks! Did not see that. Too many URL locations ;-)

So the can 2026-10-01 PR can get into upstream.

Thanks & sorry for the noise.
Oliver
